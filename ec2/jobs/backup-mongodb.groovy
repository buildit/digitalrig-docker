@Library('buildit')
import buildit.*

envz = buildit.Jenkins.globalEnv
def region = envz.REGION
def rigDomain = envz.RIG_DOMAIN
k8s = new K8S(this, Cloud.valueOf(envz.CLOUD), region)

k8s.build([containerTemplate(name: 'mongo', image: 'mongo', ttyEnabled: true, command: 'cat', resourceRequestMemory: '128m')], []) {
    container('mongo') {
        time = sh(script: 'echo -n `date +%Y-%m-%d`', returnStdout: true)
        fileName = "mongo-staging-mongodb_${time}.dump"
        sh "mongodump --host mongo-staging-mongodb -v --archive=${fileName}"
    }

    container('aws') {
        sh "aws s3 cp ${fileName} s3://backups.${rigDomain}/mongodb/"
    }
}
