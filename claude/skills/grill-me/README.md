# grill-me

A Claude Code skill that interviews you relentlessly about a plan or design — one question at a time — until every branch of the decision tree is resolved.

## Why this exists

Plans feel solid until someone starts asking questions. That moment when a collaborator points at the part you glossed over and asks *"but what happens when…"* — that is the moment this skill replicates, before you've written a line of code.

`grill-me` works the way a good technical interviewer does: one question at a time, each targeting the weakest assumption in your current answer. It explores the codebase before asking anything code can answer. It gives its own recommended answer so you can agree or push back rather than starting from blank.

## How it works

You type `/grill-me <plan or design>`. The skill:

1. Reads your plan and identifies the first unresolved decision or assumption.
2. Searches the codebase for anything that answers the question without asking you.
3. Asks one focused question, with a recommended answer.
4. Takes your answer, updates its understanding, and finds the next weakest point.
5. Repeats until the plan is fully resolved — or you call it off.

There is no fixed number of rounds. The interview ends when the decision tree is resolved or you say enough.

## Triggers

- `/grill-me`
- `grill-me`
- "grill me"

## Install

Follow the install instructions in [Matt Pocock's skills collection](https://github.com/mattpocock/skills), where this skill lives.

Then run `/skills` inside Claude Code. `grill-me` should appear in the list.

## Skill behavior contract

- One question at a time. Never batches.
- Explores the codebase before asking anything code can answer.
- Provides a recommended answer for each question so you can respond rather than start from blank.
- Stops when the decision tree is resolved or you call it off.

## Related

- [`prompt-grill`](https://github.com/dotoricode/prompt-grill) — borrows this interview pattern to sharpen vague work requests into 5-slot XML prompts before execution.
- [`cerberus`](https://github.com/dotoricode/cerberus) — uses grill-me as head 2 (plan interrogation) in a 3-gate verification workflow.

## License

MIT.
