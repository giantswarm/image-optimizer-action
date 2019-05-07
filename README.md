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

## Limitations / possible improvements

- Only works on branches, not on pushes to `master`. This could be made configurable in the future.

- Only works on files with suffix `.jpg` or `.JPG`, not `.jpeg` etc. We should use `file` on every added file and detect JPEGs that way instead.

- No way to ignore specific files, e. g. files that have been optimized already before being committed.
