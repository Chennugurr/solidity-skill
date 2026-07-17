# Property Workflow

1. Write the natural-language requirement and identify who can violate it.
2. Define state variables, units, quantifiers, time model, and environmental assumptions.
3. Express local assertions, state invariants, relational properties, or equivalence properties.
4. Add positive examples proving the property is reachable and mutation controls proving it can fail.
5. Check for vacuity, over-constrained assumptions, ignored calls, unsupported opcodes, and bounded loops.
6. Minimize counterexamples and reproduce them as Foundry regression tests.

Useful categories include authorization, conservation, solvency, monotonicity, bounded loss, nonce uniqueness, upgrade preservation, and implementation equivalence.
