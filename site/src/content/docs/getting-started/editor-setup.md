---
title: Editor Setup
description: Configure your editor for Sailfin development with syntax highlighting, snippets, and build tasks.
section: getting-started
order: 2
---

## VS Code (Recommended)

The official **Sailfin extension for Visual Studio Code** is the primary supported
editor integration and the recommended way to work with Sailfin projects. It is
published by **SailfinIO** on the Visual Studio Marketplace.

**Marketplace:** [marketplace.visualstudio.com/items?itemName=SailfinIO.sfn](https://marketplace.visualstudio.com/items?itemName=SailfinIO.sfn)

### Installation

**Via the Extensions panel (recommended):**

1. Open VS Code.
2. Open the **Extensions** panel with `Ctrl+Shift+X` (Windows/Linux) or `Cmd+Shift+X` (macOS).
3. Search for **Sailfin**.
4. Click **Install** on the extension published by **SailfinIO**.

**Via the Command Palette:**

1. Open the Command Palette with `Ctrl+Shift+P` / `Cmd+Shift+P`.
2. Run **Extensions: Install Extension**.
3. Paste the extension ID: `SailfinIO.sfn`
4. Press Enter and click **Install**.

**Via the terminal:**

```bash
code --install-extension SailfinIO.sfn
```

### What the Extension Provides

| Feature | Status |
|---|---|
| Syntax highlighting for `.sfn` files | Available |
| Effect annotation recognition (`![io]`, `![net]`, `![model]`, ...) | Available |
| Bracket matching and auto-indentation | Available |
| Comment toggling (`//` line comments) | Available |
| Code snippets for common patterns | Available |
| Error diagnostics and inline squiggles | Planned (requires LSP, post-1.0) |
| Go-to-definition | Planned (post-1.0) |
| Inline type hovers | Planned (post-1.0) |
| Auto-complete | Planned (post-1.0) |

Richer features such as error diagnostics and go-to-definition depend on the
Sailfin language server, which is planned for development after the 1.0 compiler
release. In the meantime, use a terminal build task (see
[VS Code tasks](#vs-code-tasks) below) to surface compiler errors.

### Confirming the Extension Is Working

Open any `.sfn` file in VS Code. You should see:

- **Syntax coloring** — keywords like `fn`, `let`, `struct`, and `match` are
  highlighted. Effect annotations like `![io]` render distinctly. Struct field
  arrows (`->`) are colored as operators.
- **Status bar language indicator** — the bottom-right of the VS Code window
  shows **Sailfin** as the active language when a `.sfn` file is focused.
- **Bracket matching** — placing your cursor next to `{` or `}` highlights the
  matching pair.

If the file opens but shows no syntax coloring, verify the file has a `.sfn`
extension and that the extension is installed and enabled.

### Available Snippets

Type the trigger word and press `Tab` to expand the snippet:

| Trigger | Expands to |
|---|---|
| `fn` | Function declaration with parameter and return type placeholders |
| `fnio` | Function with `![io]` effect annotation |
| `test` | Test block with `assert` placeholder |
| `struct` | Struct declaration with one field placeholder |
| `match` | Match expression with two arm placeholders |
| `let` | Variable declaration |
| `import` | Import statement |

### Troubleshooting the Extension

**Extension not activating (no syntax highlighting):**

- Confirm the file has a `.sfn` extension — the extension does not activate on
  files with other extensions.
- Check that the extension is enabled: open the Extensions panel, search for
  "Sailfin", and verify it shows as **Enabled** (not **Disabled**).
- Try reloading the VS Code window: `Ctrl+Shift+P` → **Developer: Reload Window**.

**Diagnostics not showing (no red squiggles on errors):**

This is expected. The Sailfin language server is not yet available. To see
compiler errors, use a build task or run `sfn compile` in the integrated terminal.
See [VS Code tasks](#vs-code-tasks) below for a ready-to-use configuration.

**The language indicator shows "Plain Text" instead of "Sailfin":**

The file association may have been overridden by a user setting. Check your
`settings.json` for a `files.associations` entry that maps `*.sfn` to something
else and remove it.

---

## VS Code Tasks

Even without the language server, you can surface compiler errors inside VS Code
by configuring build tasks. Create a `.vscode/tasks.json` file in your project
root:

```json
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "Sailfin: Compile",
      "type": "shell",
      "command": "sfn build ${file}",
      "group": {
        "kind": "build",
        "isDefault": true
      },
      "problemMatcher": {
        "owner": "sailfin",
        "fileLocation": ["relative", "${workspaceFolder}"],
        "pattern": {
          "regexp": "^error\\[.*\\]: (.*)$",
          "message": 1
        }
      },
      "presentation": {
        "reveal": "always",
        "panel": "shared"
      }
    },
    {
      "label": "Sailfin: Test",
      "type": "shell",
      "command": "sfn test",
      "group": "test",
      "presentation": {
        "reveal": "always",
        "panel": "shared"
      }
    },
    {
      "label": "Sailfin: Run current file",
      "type": "shell",
      "command": "sfn run ${file}",
      "group": "none",
      "presentation": {
        "reveal": "always",
        "panel": "shared"
      }
    },
    {
      "label": "Sailfin: Format current file",
      "type": "shell",
      "command": "sfn fmt --write ${file}",
      "group": "none",
      "presentation": {
        "reveal": "silent",
        "panel": "shared"
      }
    }
  ]
}
```

With this configuration:

- Press `Ctrl+Shift+B` / `Cmd+Shift+B` to run the **Sailfin: Compile** task (the
  default build task).
- Open the Command Palette and run **Tasks: Run Test Task** to invoke
  **Sailfin: Test**.
- Open the Command Palette and run **Tasks: Run Task** → **Sailfin: Run current
  file** to run whichever `.sfn` file is currently open.

Compiler output appears in the **Terminal** panel. Errors include file paths and
line numbers, so you can click through to the relevant location.

---

## Formatting with `sfn fmt`

Sailfin ships a built-in code formatter. One canonical style, no configuration —
like `gofmt` for Go. All Sailfin compiler sources and the runtime are formatted
with `sfn fmt` and CI enforces it on every pull request.

### Quick start

```bash
# Format a file and see the result in stdout
sfn fmt src/main.sfn

# Format a file in place
sfn fmt --write src/main.sfn

# Format all .sfn files in a directory
sfn fmt --write src/

# Check formatting without modifying (CI mode)
sfn fmt --check src/
```

### Format-on-save in VS Code

Until the Sailfin language server is available, you can approximate format-on-save
by binding a keyboard shortcut to the format task above. Open **Keyboard Shortcuts**
(`Ctrl+K Ctrl+S`) and bind the **Sailfin: Format current file** task to your
preferred key.

Alternatively, add a `runOnSave` extension (e.g.,
[emeraldwalk.RunOnSave](https://marketplace.visualstudio.com/items?itemName=emeraldwalk.RunOnSave))
with this configuration in `.vscode/settings.json`:

```json
{
  "emeraldwalk.runonsave": {
    "commands": [
      {
        "match": "\\.sfn$",
        "cmd": "sfn fmt --write ${file}"
      }
    ]
  }
}
```

### What the formatter does

- 4-space indentation, K&R braces
- Spaces around operators and after keywords; no space before `:`, `;`, `?`
- No space after unary `!` and `-`
- Imports sorted by path, specifiers sorted alphabetically
- One blank line between top-level declarations
- Single-statement blocks stay inline when they fit

See the [CLI Reference](/docs/reference/cli) for the full list of formatting rules
and known limitations.

---

## Recommended VS Code Settings

Add a `.vscode/settings.json` to your project for a consistent experience across
contributors:

```json
{
  "files.associations": {
    "*.sfn": "sailfin"
  },
  "editor.fontFamily": "'Fira Code', 'Cascadia Code', 'JetBrains Mono', monospace",
  "editor.fontLigatures": true,
  "editor.tabSize": 4,
  "editor.insertSpaces": true,
  "editor.rulers": [100],
  "files.trimTrailingWhitespace": true,
  "files.insertFinalNewline": true
}
```

### Notes on these settings

- **`files.associations`** — explicitly registers `.sfn` as the Sailfin language,
  ensuring the extension activates even if the file association was changed by
  another extension.
- **`editor.fontFamily` and `editor.fontLigatures`** — Sailfin's syntax uses
  several character sequences that render better with a ligature-capable monospace
  font. `->` (field separator), `![...]` (effect annotations), and `=>` (match
  arms) all benefit from ligatures. Fira Code, Cascadia Code, and JetBrains Mono
  are all freely available.
- **`editor.tabSize: 4`** — the Sailfin standard library and compiler source use
  4-space indentation.
- **`editor.rulers: [100]`** — the Sailfin style guide recommends a 100-character
  line limit.

---

## Syntax Highlighting Themes

The Sailfin extension uses standard TextMate grammar scopes, so it works with any
VS Code color theme. A few recommendations:

- **High-contrast themes** make `->` field arrows and `![...]` effect annotations
  especially readable by coloring them as operators distinct from identifiers.
- Themes that distinguish **keywords**, **types**, **operators**, and **strings**
  with clearly different hues work best for Sailfin's dense type and effect syntax.
- Themes known to work well: **One Dark Pro**, **Tokyo Night**, **Catppuccin**,
  **GitHub Dark**, and VS Code's built-in **Dark+**.

There is no Sailfin-branded theme — the standard TextMate scopes are sufficient.

---

## Other Editors

Support for editors beyond VS Code is community-driven. None of the options below
are officially maintained by the Sailfin project. Contributions are welcome — see
the [Contributor Guide](/docs/contributing/guide).

### Neovim / Vim

**Community-supported.**

The recommended approach is a custom Tree-sitter grammar for Sailfin. If one is
available from the community, follow the installation instructions for your
Tree-sitter plugin (e.g., `nvim-treesitter`):

```lua
-- Example nvim-treesitter config (adjust the repo URL when available)
require("nvim-treesitter.configs").setup({
  ensure_installed = { "sailfin" },
})
```

Until a Tree-sitter grammar is published, you can get basic keyword highlighting
by associating `.sfn` files with a syntactically similar language such as Rust:

```vim
" In your init.vim or .vimrc
autocmd BufRead,BufNewFile *.sfn set filetype=rust
```

This is an approximation — Rust highlighting will not correctly color Sailfin's
`->` field syntax or `![...]` effect annotations, but it provides better
readability than plain text.

For Neovim, you can also set the filetype in `init.lua`:

```lua
vim.filetype.add({
  extension = {
    sfn = "sailfin",
  },
})
```

Then add a minimal `sailfin.vim` syntax file to `~/.config/nvim/syntax/` once
a community grammar becomes available.

### Emacs

**Community-supported.**

No official Emacs major mode exists yet. For basic syntax support, you can derive
from `rust-mode` or `prog-mode`:

```elisp
;; Associate .sfn files with rust-mode as an approximation
(add-to-list 'auto-mode-alist '("\\.sfn\\'" . rust-mode))
```

A dedicated `sailfin-mode` is a welcome community contribution. The TextMate
grammar shipped with the VS Code extension can serve as a reference for keyword
lists and scope assignments when writing an Emacs mode.

### JetBrains IDEs (IntelliJ, GoLand, CLion, etc.)

**Community-supported. No official plugin.**

JetBrains IDEs do not have a Sailfin plugin. You can improve the experience
slightly by:

1. Associating `.sfn` files with a known language for basic syntax coloring:
   **Settings → Editor → File Types** → find "Rust" (or another C-like language)
   → add `*.sfn` to its file patterns.
2. Using the IDE's generic file watcher to run `sfn compile` on save and display
   output in the Run tool window.

Full language support (completion, navigation, diagnostics) would require a
JetBrains plugin implementing the Language Server Protocol or using the IntelliJ
Platform SDK directly. This is tracked as a community effort.

### Zed

**Community-supported. No official extension.**

Zed has a Tree-sitter-based extension system. A Sailfin extension would follow
the same approach as the Neovim Tree-sitter grammar. Check the
[Zed Extensions](https://github.com/zed-industries/extensions) repository for
any community submissions.

---

## Compiler-Backed Diagnostics via LSP (Planned)

A Sailfin **language server** (LSP server) is planned for development after the
1.0 compiler release. When available, it will provide:

- Inline error diagnostics in any LSP-capable editor
- Go-to-definition across files
- Hover documentation for types and effects
- Auto-complete for struct fields and function signatures

Until the language server ships, the recommended approach for all editors is to
run the compiler in a terminal or via a build task and read error output there.
The Sailfin compiler's diagnostics include file paths, line numbers, and
fix-it hints that make it straightforward to navigate to errors manually.

---

## Next Steps

- [Hello, World!](/docs/getting-started/hello-world) — Write your first Sailfin program
- [Tour of Sailfin](/docs/getting-started/tour) — A guided introduction to the language
- [Installing Sailfin](/docs/getting-started/install) — Installation instructions if you haven't set up the compiler yet
