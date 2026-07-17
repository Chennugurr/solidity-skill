# Skill Evaluations

The evaluation suite checks that every public skill produces role-appropriate,
safety-conscious output. It is vendor-neutral and does not call a model in CI.

Validate schemas and replay the committed baselines:

```sh
python3 scripts/run-skill-evals.py --validate-only
python3 scripts/run-skill-evals.py --replay-baselines
```

To evaluate an agent, pass an executable adapter. The runner writes one JSON
object to the adapter's standard input and expects one JSON object on standard
output:

```json
{
  "response": "The agent's Markdown response"
}
```

The input includes `id`, `skill`, `skillPath`, `prompt`, and `workspace`. The
adapter may create files inside `workspace`; file assertions are evaluated after
it exits. Adapter runs are isolated in temporary directories and are dry-run
evaluations only.

```sh
python3 scripts/run-skill-evals.py --adapter ./my-agent-adapter
```
