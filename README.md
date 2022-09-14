# Docker Meetup, Dublin


Examples to understand how to use `build-context` and bake file to reduce friction between development and CI.


Buildx options:

- build-context
- builder

## Use cases

- Add resources to the Docker build context
- Change the base docker image
- Building Multi-arch images
- Execute heavy builds in remote machines


## Examples and code

[Buildx options in docker build](./multi-arch/README.md)

[Bake example](./bake-multiapp/README.md)

## More resources:

- https://docs.docker.com/build/buildx/drivers/kubernetes
- https://docs.docker.com/desktop/containerd/
- https://www.docker.com/blog/faster-multi-platform-builds-dockerfile-cross-compilation-guide/
- https://www.docker.com/blog/dockerfiles-now-support-multiple-build-contexts/
- https://docs.docker.com/desktop/extensions-sdk/
- https://docs.docker.com/desktop/extensions-sdk/build/test-debug/