# image-optimizer-action

A GitHub action to optimize images pushed to a branch.

Uses [guetzli](https://github.com/google/guetzli) to optimize JPEGs in a way
that should reduce most files' size significantly, without reduction the
perceived quality.

**Warning:** Images will be replaced by the action and committed back into
the same branch. Use at your own risk.

There is currently no way to exclude certain files from optimization.

Add it to your `main.workflow` like this:

```nohighlight
workflow "Image optimization" {
  on = "push"
  resolves = ["image-optimizer-action"]
}

action "image-optimizer-action" {
  uses = "giantswarm/image-optimizer-action@master"
  secrets = ["GITHUB_TOKEN"]
}
```
