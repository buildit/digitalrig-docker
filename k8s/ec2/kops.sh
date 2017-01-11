export KOPS_STATE_STORE=s3://kops.store.k8s.riglet.io
kops create cluster --zones=us-east-1b --dns-zone=k8s.riglet.io --node-size=m4.large rsafronov.k8s.riglet.io
