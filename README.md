# image-optimizer-action

A GitHub action to optimize images pushed to a branch

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
