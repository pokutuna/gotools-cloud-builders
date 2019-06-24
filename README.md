# gotools-cloud-builders

This builder runs the tools installed by `go get`, like [golint](https://github.com/golang/lint), [staticcheck](https://staticcheck.io/), and so on.

Usage is almost the same as original `gcr.io/cloud-builders/go` image.  
https://github.com/GoogleCloudPlatform/cloud-builders/blob/master/go/README.md

## Add tools & building this builder

To add tools, edit `install_tools.ash` and add `go get`.

    #!/bin/ash

    # list install tools
    go get golang.org/x/lint/golint


To build this builder, run the following command in this directory.

    $ gcloud builds submit . --config=cloudbuild.yaml


Then you can use `gcr.io/$YOUR_PROJECT_ID/gotools` builder.

## Using this builder

```
steps:

# golint
- name: gcr.io/pokutuna/gotools
  args: ["golint", "-set_exit_status"]
  env: ["PROJECT_ROOT=github.com/pokutuna/foobar"]

# staticcheck(and other tools) requires dependent modules are installed
- name: gcr.io/cloud-builders/go
  args: ["get"]
  env: ["PROJECT_ROOT=github.com/pokutuna/foobar"]

# staticcehck
# (To use staticheck, add `go get honnef.co/go/tools/cmd/staticcheck` in `install_tools.ash`)
- name: gcr.io/pokutuna/gotools
  args: ["staticcheck"]
  env: ["PROJECT_ROOT=github.com/pokutuna/foobar"]

...
```

See the original document [Workspace setup](https://github.com/GoogleCloudPlatform/cloud-builders/blob/master/go/README.md#workspace-setup) section about `$GOPATH` and `$PROJECT_ROOT`. Sometimes you may need to set `GO111MODULE=on` to `env`.
