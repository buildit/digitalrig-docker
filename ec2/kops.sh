export KOPS_STATE_STORE=s3://kops.store.k8s.riglet.io
kops create cluster \
        --cloud=aws \
        --topology private \
        --bastion \
        --zones us-east-1b \
        --master-zones us-east-1b \
        --node-count 3 \
        --node-size t2.medium \
        --master-size t2.medium \
        --dns-zone=k8s.riglet.io \
        --channel alpha \
        --networking weave \
        rsafronov.k8s.riglet.io