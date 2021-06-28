export HTTP_PROXY_HOST=10.0.0.6
export HTTP_PROXY_PORT=1087
export HTTPS_PROXY_HOST=10.0.0.6
export HTTPS_PROXY_PORT=1087
export JDK_URL=http://10.0.0.6:8888/jdk-8u212-linux-x64.tar.gz
sudo docker buildx create --use --name larger_log --driver-opt env.BUILDKIT_STEP_LOG_MAX_SIZE=50000000
sudo docker buildx build \
    --build-arg http_proxy=http://$HTTP_PROXY_HOST:$HTTP_PROXY_PORT \
    --build-arg https_proxy=http://$HTTPS_PROXY_HOST:$HTTPS_PROXY_PORT \
    --build-arg HTTP_PROXY_HOST=$HTTP_PROXY_HOST \
    --build-arg HTTP_PROXY_PORT=$HTTP_PROXY_PORT \
    --build-arg HTTPS_PROXY_HOST=$HTTPS_PROXY_HOST \
    --build-arg HTTPS_PROXY_PORT=$HTTPS_PROXY_PORT \
    --build-arg JDK_VERSION=8u212 \
    --build-arg JDK_URL=$JDK_URL \
    --build-arg no_proxy=x.x.x.x \
    --progress plain \
    -o type=docker \
    -t intelanalytics/analytics-zoo-ppml-trusted-big-data-ml-scala-graphene:0.10-SNAPSHOT -f ./Dockerfile .
