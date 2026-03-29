---
title: AI Constructs
description: Models, prompts, pipelines, and tools — Sailfin's first-class AI features.
section: learn
order: 8
---

Sailfin treats AI as a first-class concern with dedicated syntax for models, prompts, pipelines, and tools.

## Models

Declare model bindings with provider and version:

```sfn
model gpt4o = openai:"gpt-4o";
model claude = anthropic:"claude-sonnet-4-20250514";
```

## Prompts

Type-safe prompt composition with interpolation:

```sfn
fn summarize(text: String) -> String ![model] {
    let result = prompt gpt4o ![model] {
        system "You are a concise summarizer. Respond in 2-3 sentences."
        user "Summarize the following:\n\n{{text}}"
    };
    return result;
}
```

## Pipelines

Chain operations into reusable pipelines:

```sfn
pipeline analyze_feedback {
    step classify(input: String) -> Category ![model] {
        return prompt gpt4o ![model] {
            system "Classify feedback as: positive, negative, or neutral."
            user "{{input}}"
        };
    }

    step extract_themes(input: String) -> Array<String> ![model] {
        return prompt gpt4o ![model] {
            system "Extract key themes as a list."
            user "{{input}}"
        };
    }
}
```

## Tools

Expose functions as tools for model invocation:

```sfn
tool lookup_user {
    description "Look up a user by ID"
    param id: String "The user ID to look up"

    fn execute(id: String) -> User ![io] {
        return db.find_user(id);
    }
}
```

## Generation Cards

Every model call produces a generation card with provenance metadata:

- Input hash
- Model version
- Cost and latency
- Random seed (for reproducibility)

## Next Steps

- [Models & Pipelines (Advanced)](/docs/advanced/ai-constructs) — Engine system, adapters, and training
- [Testing](/docs/learn/testing) — Testing AI-powered code
