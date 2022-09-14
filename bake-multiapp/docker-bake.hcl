group "default" {
    targets = ["ui", "api"]
}

variable "TAG" {
  default = "v0.0.0"
}

target "ui" {
    dockerfile = "ui/Dockerfile"
    contexts = {
        src = "ui/src"
        config = "ui/config"
        nginx = "docker-image://nginx:alpine"
    }
    tags = [
	    "ipedrazas/dublin-ui:latest",
        "ipedrazas/dublin-ui:${TAG}"
    ]
    platforms = [ "linux/amd64", "linux/arm64" ]
}

target "api" {
    dockerfile = "./Dockerfile"
    context = "./api"
    
    tags = [
         "ipedrazas/dublin-api:latest"
    ]
    platforms = [ "linux/amd64", "linux/arm64" ]
}

target "ui-dev" {
   context = "ui" 
   tags = ["harbor.alacasa.uk/library/ui:dev"]
   dockerfile = "Dockerfile.dev"
}

