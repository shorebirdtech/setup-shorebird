## Landing a PR

No review bot runs here. Land with `--admin` once these hold at the head commit:

- a separate agent's adversarial review is posted as a PR comment, blockers fixed or answered;
- a maintainer has LGTM'd (`lgtm` comment, approval, or opened it). Agents never post `lgtm` or approve;
- `gh pr checks <N> --required` is green, nothing pending, no open review thread. Check right before merging.

```sh
gh pr merge <N> --admin --squash --match-head-commit <full sha>
```
