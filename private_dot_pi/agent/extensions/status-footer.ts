import type { AssistantMessage } from "@earendil-works/pi-ai";
import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";
import { stripTerminalSequences, truncateToWidth, visibleWidth } from "@earendil-works/pi-tui";

const THINK_THEME: Record<string, string> = {
	off: "thinkingOff",
	minimal: "thinkingMinimal",
	low: "thinkingLow",
	medium: "thinkingMedium",
	high: "thinkingHigh",
	xhigh: "thinkingXhigh",
	max: "thinkingMax",
};

const SEP = " · ";
const SEP_W = visibleWidth(SEP);
const noop = () => {};

type Item = [text: string, style: string];

const fmtDuration = (ms: number) => {
	const s = Math.floor(ms / 1000);
	if (s < 60) return `${s}s`;
	if (s < 3600) return `${Math.floor(s / 60)}m`;
	return `${Math.floor(s / 3600)}h${Math.floor((s % 3600) / 60)}m`;
};

const fmtTokens = (n: number) => {
	if (n < 1_000) return `${n}`;

	if (n < 100_000) {
		const value = (n / 1_000).toFixed(1);
		return `${value.endsWith(".0") ? Math.round(n / 1_000) : value}k`;
	}

	if (n < 1_000_000) return `${Math.round(n / 1_000)}k`;

	const value = (n / 1_000_000).toFixed(1);
	return `${value.endsWith(".0") ? Math.round(n / 1_000_000) : value}M`;
};

const contextColor = (pct: number | null) =>
	pct == null ? "dim" : pct >= 90 ? "error" : pct >= 75 ? "warning" : "dim";

const levelFromStatus = (raw?: string): string | null => {
	if (!raw) return null;

	const status = stripTerminalSequences(raw);

	const match =
		status.match(/caveman level:\s*(\S+)/i) ??
		status.match(/ponytail:\s*(?:\S+\s+)?(\S+)/i);

	return match?.[1]?.toLowerCase() ?? "full";
};

const collectTotals = (ctx: any) => {
	let cost = 0;
	let tokens = 0;

	for (const entry of ctx.sessionManager.getBranch()) {
		if (entry.type !== "message" || entry.message.role !== "assistant") continue;

		const usage = (entry.message as AssistantMessage).usage;
		cost += usage.cost.total;
		tokens += usage.totalTokens;
	}

	return { cost, tokens };
};

export default function (pi: ExtensionAPI) {
	let startTime = Date.now();
	let requestRender: () => void = noop;
	let installTimer: ReturnType<typeof setTimeout> | null = null;

	const installFooter = (ctx: any) => {
		ctx.ui.setFooter((tui, theme, footerData) => {
			const render = () => tui.requestRender();
			const unsubscribe = footerData.onBranchChange(render);

			requestRender = render;

			queueMicrotask(() => {
				if (requestRender === render) render();
			});

			return {
				invalidate() {},

				dispose() {
					unsubscribe();
					if (requestRender === render) requestRender = noop;
				},

				render(width: number): string[] {
					const { cost, tokens } = collectTotals(ctx);
					const context = ctx.getContextUsage()?.percent ?? null;
					const thinking = ctx.thinkingLevel ?? "off";
					const statuses = footerData.getExtensionStatuses();

					const caveman = levelFromStatus(statuses.get("caveman"));
					const ponytail = levelFromStatus(statuses.get("ponytail"));

					const left: Item[] = [
						[ctx.model ? `${ctx.model.provider}/${ctx.model.id}` : "?", "accent"],
						[thinking, THINK_THEME[thinking] ?? "dim"],
					];

					if (caveman)
						left.push([`🪨 ${caveman}`, caveman === "full" ? "dim" : "warning"]);

					if (ponytail)
						left.push([`➰ ${ponytail}`, ponytail === "full" ? "dim" : "warning"]);

					const right: Item[] = [
						[`$${cost.toFixed(2)}`, "success"],
						[fmtDuration(Date.now() - startTime), "dim"],
						[fmtTokens(tokens), "dim"],
						[`◌ ${context == null ? "?" : Math.round(context)}%`, contextColor(context)],
					];

					const widthOf = (items: Item[]) =>
						items.reduce(
							(sum, [text], i) => sum + visibleWidth(text) + (i ? SEP_W : 0),
							0,
						);

					const fits = () => widthOf(left) + widthOf(right) + 1 <= width;

					if (!fits()) right.splice(2, 1); // tokens
					if (!fits()) right.splice(1, 1); // duration
					if (!fits() && ponytail) left.pop();
					if (!fits() && caveman) left.pop();
					if (!fits()) right.pop(); // context

					const renderSide = (items: Item[]) =>
						items.map(([text, style]) => theme.fg(style, text)).join(SEP);

					const l = renderSide(left);
					const r = renderSide(right);
					const gap = Math.max(1, width - visibleWidth(l) - visibleWidth(r));

					return [truncateToWidth(`${l}${" ".repeat(gap)}${r}`, width)];
				},
			};
		});
	};

	pi.on("session_start", (_event, ctx) => {
		startTime = Date.now();

		// pi-claude-code-tui resets the footer on the next tick, so install ours afterward.
		if (installTimer) clearTimeout(installTimer);

		installTimer = setTimeout(() => {
			installTimer = null;
			installFooter(ctx);
		}, 10);
	});

	pi.on("session_shutdown", () => {
		if (installTimer) clearTimeout(installTimer);
		installTimer = null;
		requestRender = noop;
	});

	pi.on("model_select", requestRender);
	pi.on("thinking_level_select", requestRender);
	pi.on("turn_end", requestRender);
}
