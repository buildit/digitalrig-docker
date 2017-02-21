@Library('buildit')
import buildit.*

envz = buildit.Jenkins.globalEnv
def region = envz.REGION
def rigDomain = envz.RIG_DOMAIN
k8s = new K8S(this, Cloud.valueOf(envz.CLOUD), region)

k8s.build([], []) {
    container('kubectl') {
        pod = sh(script: 'echo -n `kubectl get pods -o=custom-columns=NAME:.metadata.name | grep couchdb-staging`', returnStdout: true)
        if(!pod) {
            throw new IllegalStateException('No couchdb pod is running')
        }
        time = sh(script: 'echo -n `date +%Y-%m-%d`', returnStdout: true)
        fileName = "couchdb-staging_${time}.tar.gz"
        sh "kubectl exec ${pod} -- tar czf /tmp/dump.tar.bz2 /var/lib/couchdb"
        sh "kubectl cp ${pod}:/tmp/dump.tar.bz2 ${fileName}"
    }

    container('aws') {
        sh "aws s3 cp ${fileName} s3://backups.${rigDomain}/couchdb/"
    }
}
