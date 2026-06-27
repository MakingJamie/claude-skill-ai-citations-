# Contributing

Thanks for helping keep **AI Citation Foundations** useful and accurate. This skill is intentionally small and honest — the most valuable contributions keep it *current* and *truthful*.

## Report a changed or new AI bot (the most useful contribution)

AI crawler user-agent tokens drift over time: operators rename bots, split training from retrieval, deprecate old tokens, or add new ones. A stale bot list quietly misleads people, so corrections here matter most.

If you spot a token that's outdated, missing, or miscategorised:

1. **Open an issue** using the **"AI bot token update"** template, or
2. **Send a pull request** editing `references/ai-bots-reference.md` — and the matching `assets/robots-*.txt` files if the token appears there.

Either way, **include a link to the operator's official crawler documentation** as your source. Bot behaviour should be cited, never assumed.

## Other welcome contributions

- **Bug fixes** to `scripts/verify-foundations.sh` — keep it portable across macOS (BSD tools) and Linux (GNU tools); avoid GNU-only features like `awk`'s `IGNORECASE`.
- **New stack support** — if a static-site generator is missing from `references/stack-detection.md`, add its detection signal and where its artifacts belong.
- **Clarity** — plain, honest, jargon-light wording. No hype, no citation guarantees.

## Principles

- **Foundational and transparent only.** No cloaking, no serving alternate content to bots.
- **Cite a primary source** for any factual claim, especially bot tokens and spec details.
- **Stay honest.** Mark signals as proven, low-cost, or experimental — never oversell.
- **Keep `SKILL.md` lean.** Detailed knowledge belongs in `references/`, not the workflow body.

## Licensing

By contributing, you agree that your contributions are licensed under this repository's [MIT License](LICENSE).
