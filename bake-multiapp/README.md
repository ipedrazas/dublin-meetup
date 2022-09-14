# Docker buildx and bake


The repo structure:

```
.
├── api
│   ├── Dockerfile
│   └── src
│       └── index.html
└── ui
    ├── Dockerfile
    ├── config
    │   └── secret
    └── src
        └── index.html
```

What we want to achieve:

- build one image that runs in a kubernetes cluster and developers macbooks (m1)
- replace the `FROM` image used in the Dockerfiles by better one.
- keep the repo structure separated.
- a build process easy to understand and use

## Buildx options

```
docker buildx build 
--platform linux/amd64,linux/arm64
--build-context src=ui/src 
--build-context config=ui/config 
-t harbor.alacasa.uk/library/dublin-ui:$TAG 
-t harbor.alacasa.uk/library/dublin-ui:latest
--builder=kube
--build-context nginx=docker-image://nginx:alpine 
./ui

```

Let's analyse the above command:

- `docker buildx build ` we instruct docker to doa  build using `buildx`
- This instruction `--platform linux/amd64,linux/arm64 ` tells docker to build the image for kubernetes and for macs.
- This instruction `--build-context nginx=docker-image://nginx:alpine` replaces the nginx image defined in the Dockerfile for an iamge based on alpine.
- These two instructions `--build-context src=ui/src` and `--build-context config=ui/config` tell the Dockerfile where to find the reources. Note the `COPY` instruction in the Dockerfile: `COPY --from=src index.html /usr/share/nginx/html`
- Tagging images using the `-t` flag: `-t harbor.alacasa.uk/library/dublin-ui:latest`
- Last, but not least, `./ui` tells where to find the Dockerfile.

## Buildx options as a bake target

```
target "ui" {
    dockerfile = "ui/Dockerfile"
    contexts = {
        src = "ui/src"
        config = "ui/config"
   nginx = "docker-image://nginx:alpine"
    }
    tags = [
"harbor.alacasa.uk/library/dublin-ui:latest",     "harbor.alacasa.uk/library/dublin-ui:${TAG}"
    ]
    platforms = [ "linux/amd64", "linux/arm64" ]
}
```