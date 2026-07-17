# Formal Verification Example Prompts

Use `formal-verification-engineer` for prompts such as:

```text
Convert this vault's conservation and no-free-shares requirements into Foundry invariants, Halmos symbolic checks, and SMTChecker assertions. State assumptions, add a failing control, and explain any unverified behavior.
```

Expected behavior: distinguish requirements from assumptions, choose bounded tools deliberately, check vacuity, and convert counterexamples into concrete regression tests.
