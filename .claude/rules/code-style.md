# Minimalist Code Styling Rules

- Simplicity first: fewest moving parts that solve the actual problem — never at the cost of performance or efficiency.
- Assume the application: write for the case that exists, not ones that might. No abstraction layer, strategy interface, or config for a single concrete case.
- Naming: `snake_case` vars/functions; `_private` leading underscore; `UPPERCASE` constants; `_t` suffix on C typedefs; no abbreviations, no type prefixes.
- Comments: inline only for non-obvious constraints/units/bounds, never narrating the next line; docstrings ≤8 lines, purpose + usage only.
- Ask first when a perf/robustness gain needs added complexity — state the gain, the complexity cost, your recommendation.
