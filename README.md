# zipkin-appinisights-docker

Docker image of Zipkin with ApplicationInsights storage integration

## Usage

### Build the image

1. Build the image with `docker build -t <image-name> .` Example `docker build -t openzipkin/zipkin-ai .` 
2. Configure the required API Keys in the .env file.
3. Create container instances with `docker-compose up`

Make sure the image name matches with the image name inside the `docker-compose.yml` file.

### App Insights integration

Currently I'm including the binaries from this [Pull Request](https://github.com/openzipkin/zipkin-azure/pull/27). This is quick, dirty and momentary solution. When the PR gets approved I'll try to cleanup this. I hate binaries in a repo.

### Kubernetes

In the kubernetes folder you will find the `deployments` and `services` description file converted using Kompose.
I used private registry to upload the images, please be sure to update the images name in `zipkin-ai-deployment.yml` file.

Not sure why, I had to expose the service manually. Took me a while figure it out the solution, this why I'm mention it.

Thanks to Zipkin and AppInsights integration devs.
