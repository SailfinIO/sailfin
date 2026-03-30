---
title: Editor Setup
description: Install and configure the Sailfin VS Code extension for the best development experience.
section: getting-started
order: 2
---

## Sailfin for Visual Studio Code

The official **Sailfin VS Code extension** adds first-class language support for `.sfn` files directly inside Visual Studio Code. It is the primary supported editor integration for Sailfin and the recommended way to work with Sailfin projects.

**Marketplace:** [https://marketplace.visualstudio.com/items?itemName=SailfinIO.sfn](https://marketplace.visualstudio.com/items?itemName=SailfinIO.sfn)

## Installation

### Via the VS Code Marketplace (recommended)

1. Open VS Code.
2. Open the **Extensions** panel (`Ctrl+Shift+X` / `Cmd+Shift+X`).
3. Search for **Sailfin**.
4. Click **Install** on the extension published by **SailfinIO**.

Alternatively, click the direct marketplace link above and press **Install**.

### Via the Command Palette

```
ext install SailfinIO.sfn
```

Open the Command Palette (`Ctrl+Shift+P` / `Cmd+Shift+P`), run **Extensions: Install Extension**, and paste the ID above.

## Features

| Feature | Status |
|---|---|
| Syntax highlighting for `.sfn` files | ✅ |
| Bracket matching and auto-indentation | ✅ |
| Comment toggling (`//` line comments) | ✅ |
| Effect annotation recognition (`![io]`, `![net]`, …) | ✅ |
| Code snippets for common patterns | ✅ |

> **Note:** Richer features such as error diagnostics, go-to-definition, and inline type hovers are planned as the Sailfin language server matures.

## Getting the Most Out of the Extension

Once installed, open any `.sfn` file and the extension activates automatically. A few tips:

- **File associations** — files with the `.sfn` extension are automatically recognized. No manual configuration is needed.
- **Snippets** — type `fn` and press `Tab` to expand a function stub, or `test` to expand a test block.
- **Theme compatibility** — the extension uses standard TextMate grammar scopes, so it works well with any VS Code color theme.

## Other Editors

Support for editors beyond VS Code (such as Neovim, Zed, and Emacs) is planned for a future release. Contributions are welcome — see the [Contributor Guide](/docs/contributing/guide) for details.

## Next Steps

- [Hello, World!](/docs/getting-started/hello-world) — Write your first Sailfin program
- [Tour of Sailfin](/docs/getting-started/tour) — A guided introduction to the language
