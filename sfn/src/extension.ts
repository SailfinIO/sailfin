import {
  CodeAction,
  ExtensionContext,
  commands,
  window,
  languages,
  CodeActionKind,
  CompletionItem,
  CompletionItemKind,
  SnippetString,
  MarkdownString,
  TextDocument,
  Position,
  WorkspaceEdit,
  workspace,
  Diagnostic,
  Range,
  DiagnosticSeverity,
  Hover,
  TextEdit,
} from "vscode";

// This method is called when your extension is activated
// Your extension is activated the very first time the command is executed
export function activate(context: ExtensionContext) {
  // Log activation message
  console.log('Congratulations, your extension "sfn" is now active!');

  /**
   * Command: sfn.compileCode
   * Description: Compiles the currently active Sailfin (.sfn) file
   */
  const compileCommand = commands.registerCommand("sfn.compileCode", () => {
    const editor = window.activeTextEditor;

    if (editor) {
      const document = editor.document;

      if (document.languageId === "sfn") {
        window.showInformationMessage(`Compiling ${document.fileName}...`);
        // Add your compile logic here.
      } else {
        window.showErrorMessage("This is not an SFN file!");
      }
    } else {
      window.showErrorMessage("No active editor detected!");
    }
  });

  /**
   * Code Action Provider for SFN files
   * Suggests fixes for diagnostics like undefined variables
   */
  const codeActions = languages.registerCodeActionsProvider("sfn", {
    provideCodeActions(document, range, context, token) {
      const actions: CodeAction[] = [];

      // Iterate over diagnostics within the range
      context.diagnostics.forEach((diagnostic) => {
        // Check if the diagnostic range overlaps with the selected range
        if (range.intersection(diagnostic.range)) {
          if (diagnostic.message.includes("Undefined variable")) {
            const action = new CodeAction(
              "Create variable",
              CodeActionKind.QuickFix
            );

            // Use range information to propose a fix at the exact location
            const variableName = document.getText(diagnostic.range);
            action.command = {
              title: "Create variable",
              command: "sfn.createVariable",
              arguments: [
                document,
                diagnostic.range.start,
                variableName, // Pass the variable name for the quick fix
              ],
            };

            actions.push(action);
          }
        }
      });

      // Handle cancellation using the token
      if (token.isCancellationRequested) {
        console.log("Code action request was cancelled.");
        return [];
      }

      return actions;
    },
  });

  /**
   * Completion Item Provider for SFN files
   * Provides suggestions like "fn" snippets
   */
  const completionProvider = languages.registerCompletionItemProvider(
    "sfn",
    {
      provideCompletionItems(document, position, token, context) {
        const completionItems: CompletionItem[] = [];

        // Detect variables in the current scope and suggest them
        const lines = document.getText().split("\n");
        for (const line of lines) {
          const match = line.match(/let\s+(\w+)\s*->/);
          if (match) {
            const variableCompletion = new CompletionItem(
              match[1],
              CompletionItemKind.Variable
            );
            variableCompletion.insertText = match[1];
            variableCompletion.detail = "Variable";
            completionItems.push(variableCompletion);
          }
        }

        // Get the text before the cursor
        const lineText = document.lineAt(position).text;
        const textBeforeCursor = lineText
          .substring(0, position.character)
          .trim();

        // Context-aware completion logic
        if (textBeforeCursor.endsWith("fn")) {
          // Suggest function template when typing "fn"
          const fnCompletion = new CompletionItem(
            "fn",
            CompletionItemKind.Snippet
          );
          fnCompletion.insertText = new SnippetString(
            "fn ${1:functionName}(${2:params}) -> ${3:returnType} {\n\t$0\n}"
          );
          fnCompletion.detail = "Define a new function";
          fnCompletion.documentation = new MarkdownString(
            "Creates a function declaration."
          );
          completionItems.push(fnCompletion);
        }

        if (textBeforeCursor.endsWith(".")) {
          // If the user typed ".", suggest struct or object members
          const memberCompletion = new CompletionItem(
            "toString",
            CompletionItemKind.Method
          );
          memberCompletion.insertText = "toString()";
          memberCompletion.detail = "Call the `toString` method";
          memberCompletion.documentation = new MarkdownString(
            "Converts an object to a string representation."
          );
          completionItems.push(memberCompletion);

          const anotherMemberCompletion = new CompletionItem(
            "length",
            CompletionItemKind.Property
          );
          anotherMemberCompletion.insertText = "length";
          anotherMemberCompletion.detail = "Property: length";
          anotherMemberCompletion.documentation = new MarkdownString(
            "Returns the length of the array or string."
          );
          completionItems.push(anotherMemberCompletion);
        }

        // General keyword completions
        const keywords = ["let", "mut", "struct", "interface", "enum"];
        for (const keyword of keywords) {
          const keywordCompletion = new CompletionItem(
            keyword,
            CompletionItemKind.Keyword
          );
          keywordCompletion.insertText = keyword;
          keywordCompletion.detail = `Keyword: ${keyword}`;
          keywordCompletion.documentation = new MarkdownString(
            `Inserts the \`${keyword}\` keyword.`
          );
          completionItems.push(keywordCompletion);
        }

        // Handle cancellation
        if (token.isCancellationRequested) {
          console.log("Completion request was cancelled.");
          return [];
        }

        return completionItems;
      },
    },
    "." // Trigger completion when the user types "."
  );

  const createVariableCommand = commands.registerCommand(
    "sfn.createVariable",
    (document: TextDocument, position: Position, variableName: string) => {
      const edit = new WorkspaceEdit();
      const insertPosition = new Position(position.line, 0); // Insert at the start of the line

      // Generate the variable declaration
      const variableDeclaration = `let ${variableName} -> ${"type"} = /* TODO: initialize */;\n`;

      // Apply the edit
      edit.insert(document.uri, insertPosition, variableDeclaration);
      workspace.applyEdit(edit).then(() => {
        window.showInformationMessage(`Variable '${variableName}' created.`);
      });
    }
  );
  const diagnosticCollection = languages.createDiagnosticCollection("sfn");

  const updateDiagnostics = (document: TextDocument) => {
    if (document.languageId !== "sfn") {
      return;
    }

    const diagnostics: Diagnostic[] = [];
    const text = document.getText();

    // Example: Detect unused variables
    const unusedVariableRegex = /let\s+(\w+)\s*->.*?;/g;
    let match;
    while ((match = unusedVariableRegex.exec(text)) !== null) {
      const variable = match[1];
      if (
        !new RegExp(`\\b${variable}\\b`).test(
          text.substring(match.index + match[0].length)
        )
      ) {
        const diagnostic = new Diagnostic(
          new Range(
            document.positionAt(match.index),
            document.positionAt(match.index + match[0].length)
          ),
          `Unused variable '${variable}'`,
          DiagnosticSeverity.Warning
        );
        diagnostics.push(diagnostic);
      }
    }

    diagnosticCollection.set(document.uri, diagnostics);
  };

  workspace.onDidChangeTextDocument((event) => {
    updateDiagnostics(event.document);
  });

  workspace.onDidOpenTextDocument(updateDiagnostics);
  workspace.onDidCloseTextDocument((document) => {
    diagnosticCollection.delete(document.uri);
  });

  const hoverProvider = languages.registerHoverProvider("sfn", {
    provideHover(document, position, token) {
      const wordRange = document.getWordRangeAtPosition(position);
      if (!wordRange) {
        return null;
      }

      const word = document.getText(wordRange);

      // Define hover messages for keywords
      let hoverMessage: string | null = null;

      switch (word) {
        case "fn":
          hoverMessage = "`fn` keyword: Used to define a function.";
          break;
        case "let":
          hoverMessage = "`let` keyword: Used to define an immutable variable.";
          break;
        case "mut":
          hoverMessage = "`mut` keyword: Used to define a mutable variable.";
          break;
        case "struct":
          hoverMessage = "`struct` keyword: Used to define a structured type.";
          break;
        case "interface":
          hoverMessage =
            "`interface` keyword: Used to define a contract for a type.";
          break;
        case "enum":
          hoverMessage =
            "`enum` keyword: Used to define a set of named values.";
          break;
        case "return":
          hoverMessage =
            "`return` keyword: Exits a function and optionally returns a value.";
          break;
        case "if":
          hoverMessage = "`if` keyword: Used for conditional branching.";
          break;
        case "else":
          hoverMessage =
            "`else` keyword: Specifies an alternative branch in conditional statements.";
          break;
        case "for":
          hoverMessage =
            "`for` keyword: Used to iterate over a range or collection.";
          break;
        case "while":
          hoverMessage =
            "`while` keyword: Used to create a loop that continues as long as a condition is true.";
          break;
        case "async":
          hoverMessage = "`async` keyword: Declares an asynchronous function.";
          break;
        case "await":
          hoverMessage =
            "`await` keyword: Waits for the result of an asynchronous operation.";
          break;
        case "match":
          hoverMessage = "`match` keyword: Used for pattern matching.";
          break;
        case "throw":
          hoverMessage = "`throw` keyword: Used to raise an exception.";
          break;
        case "try":
          hoverMessage = "`try` keyword: Defines a block to catch exceptions.";
          break;
        case "catch":
          hoverMessage =
            "`catch` keyword: Handles exceptions thrown in a `try` block.";
          break;
        case "finally":
          hoverMessage =
            "`finally` keyword: Executes a block of code after `try` and `catch` regardless of the result.";
          break;
        default:
          hoverMessage = null;
      }

      // Return hover message if a match is found
      if (hoverMessage) {
        return new Hover(new MarkdownString(hoverMessage));
      }

      return null;
    },
  });

  const documentFormatter = languages.registerDocumentFormattingEditProvider(
    "sfn",
    {
      provideDocumentFormattingEdits(document) {
        const edits: TextEdit[] = [];
        const text = document.getText();

        // Example: Ensure consistent indentation (2 spaces)
        const formattedText = text
          .split("\n")
          .map((line) =>
            line.replace(/^\s+/, (match) => " ".repeat((match.length / 4) * 2))
          )
          .join("\n");

        edits.push(
          TextEdit.replace(
            new Range(document.positionAt(0), document.positionAt(text.length)),
            formattedText
          )
        );

        return edits;
      },
    }
  );

  // Push the subscriptions to the context
  context.subscriptions.push(completionProvider);
  context.subscriptions.push(codeActions);
  context.subscriptions.push(compileCommand);
  context.subscriptions.push(createVariableCommand);
  context.subscriptions.push(diagnosticCollection);
  context.subscriptions.push(hoverProvider);
  context.subscriptions.push(documentFormatter);
}

// This method is called when your extension is deactivated
export function deactivate() {
  console.log('Your extension "sfn" is now deactivated!');
}
