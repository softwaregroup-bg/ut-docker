pipeline {
    agent { label 'implementation-slaves' }
    stages {
        stage('build') {
            environment {
                DOCKER = credentials('dockerPublisher')
            }
            steps {
                // sh 'printenv | sort'
                script {
                    currentBuild.displayName = '#' + currentBuild.number + ' - ' + env.GIT_BRANCH
                }
                ansiColor('xterm') {
                    sh '''docker info
export DOCKER_BUILDKIT=1
echo "${DOCKER_PSW}" | docker login --username "${DOCKER_USR}" --password-stdin nexus-dev.softwaregroup.com:5001
mkdir -p -m 0777 /tmp/app/.npm
docker build -f node.Dockerfile -t nexus-dev.softwaregroup.com:5001/softwaregroup/node-gallium-global:latest -t nexus-dev.softwaregroup.com:5001/softwaregroup/node-gallium-global:9.0.36 .
docker build -f ut.Dockerfile -t nexus-dev.softwaregroup.com:5001/softwaregroup/ut-gallium-global:latest -t nexus-dev.softwaregroup.com:5001/softwaregroup/ut-gallium-global:9.0.36 .
docker build -f impl.Dockerfile -t nexus-dev.softwaregroup.com:5001/softwaregroup/impl-gallium-global:latest -t nexus-dev.softwaregroup.com:5001/softwaregroup/impl-gallium-global:9.0.36 .
docker build -f deploy.Dockerfile -t nexus-dev.softwaregroup.com:5001/softwaregroup/deploy-gallium-global:latest -t nexus-dev.softwaregroup.com:5001/softwaregroup/deploy-gallium-global:9.0.36 .
docker push nexus-dev.softwaregroup.com:5001/softwaregroup/node-gallium-global:latest
docker push nexus-dev.softwaregroup.com:5001/softwaregroup/node-gallium-global:9.0.36
docker push nexus-dev.softwaregroup.com:5001/softwaregroup/ut-gallium-global:latest
docker push nexus-dev.softwaregroup.com:5001/softwaregroup/ut-gallium-global:9.0.36
docker push nexus-dev.softwaregroup.com:5001/softwaregroup/impl-gallium-global:latest
docker push nexus-dev.softwaregroup.com:5001/softwaregroup/impl-gallium-global:9.0.36
docker push nexus-dev.softwaregroup.com:5001/softwaregroup/deploy-gallium-global:latest
docker push nexus-dev.softwaregroup.com:5001/softwaregroup/deploy-gallium-global:9.0.36
# docker build -f capture.Dockerfile -t nexus-dev.softwaregroup.com:5001/softwaregroup/capture-website:latest .
# docker push nexus-dev.softwaregroup.com:5001/softwaregroup/capture-website:latest
# docker build -f localtunnel.Dockerfile -t nexus-dev.softwaregroup.com:5001/softwaregroup/localtunnel:latest .
# docker push nexus-dev.softwaregroup.com:5001/softwaregroup/localtunnel:latest
'''
                }
            }
            post {
                always {
                    emailext(
                        mimeType: 'text/html',
                        body: '''<h1>Jenkins build ut-docker ${BUILD_DISPLAY_NAME}</h1>
<h2><b>Status</b>: ${BUILD_STATUS}</h2>
<b>Trigger</b>:  ${CAUSE}<br>
<b>Job</b>: ${JOB_URL}<br>
<b>Branch</b>: http://github.com/softwaregroup-bg/ut-docker/tree/''' + env.GIT_BRANCH + '''<br>
<b>MR/PR</b>: ${CHANGE_URL}<br>
<b>Summary</b>: ${BUILD_URL}<br>
<b>Console</b>: ${BUILD_URL}console<br>
<b>Workspace</b>: ${BUILD_URL}/execution/node/4/ws<br>
<b>Changes</b>:<pre>
${CHANGES}
</pre>
        ''',
                        recipientProviders: [[$class: 'CulpritsRecipientProvider'],[$class: 'RequesterRecipientProvider']],
                        subject: 'Build ${BUILD_STATUS} in Jenkins: ut-docker ${BUILD_DISPLAY_NAME} (' + currentBuild.durationString +')'
                    )
                }
            }
        }
    }
}
