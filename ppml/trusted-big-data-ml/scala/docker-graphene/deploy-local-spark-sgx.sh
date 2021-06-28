#!/bin/bash

export ENCLAVE_KEY_PATH=/Users/shuaibincheng/Data/git/analytics-zoo/ppml/trusted-big-data-ml/scala/docker-graphene/enclave-key.pem
export DATA_PATH=/Users/shuaibincheng/Data/git/analytics-zoo/ppml/trusted-big-data-ml/scala/docker-graphene/data
export KEYS_PATH=/Users/shuaibincheng/Data/git/analytics-zoo/ppml/trusted-big-data-ml/scala/docker-graphene/keys
export PASSWORD_PATH=/Users/shuaibincheng/Data/git/analytics-zoo/ppml/trusted-big-data-ml/scala/docker-graphene/password
export LOCAL_IP=127.0.0.1

#sudo docker pull intelanalytics/analytics-zoo-ppml-trusted-big-data-ml-scala-graphene:0.10-SNAPSHOT

sudo docker run -itd \
    --privileged \
    --net=host \
    --cpuset-cpus="0-3" \
    --oom-kill-disable \
    --device=/dev/gsgx \
    --device=/dev/sgx/enclave \
    --device=/dev/sgx/provision \
    -v $ENCLAVE_KEY_PATH:/graphene/Pal/src/host/Linux-SGX/signer/enclave-key.pem \
    -v $DATA_PATH:/ppml/trusted-big-data-ml/work/data \
    -v $KEYS_PATH:/ppml/trusted-big-data-ml/work/keys \
    -v $PASSWORD_PATH:/ppml/trusted-big-data-ml/work/password \
    --name=spark-local \
    -e LOCAL_IP=$LOCAL_IP \
    -e SGX_MEM_SIZE=64G \
    -p 8080:18080 \
    intelanalytics/analytics-zoo-ppml-trusted-big-data-ml-scala-graphene:0.10-SNAPSHOT
