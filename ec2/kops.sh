export KOPS_STATE_STORE=s3://kops.store.rsafronov.k8s.riglet.io
kops create cluster \
        --cloud=aws \
        --topology private \
        --bastion \
        --zones us-east-1a,us-east-1b,us-east-1c \
        --master-count 3 \
        --master-zones us-east-1a,us-east-1b,us-east-1c \
        --master-size t2.small \
        --node-count 3 \
        --node-size m4.large \
        --dns-zone=k8s.riglet.io \
        --channel alpha \
        --networking weave \
        rsafronov.k8s.riglet.io