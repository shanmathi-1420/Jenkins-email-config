pipeline {
  agent any

  stages {
    stage('Build') {
      steps {
        script{
          def scriptOutput = sh(script: '''
          #!/bin/bash
NAME="Shanmathi"
echo "Welcome $NAME! This is a sample bash script file."

for i in {1..5}; do
    echo "Iteration: $i"
done

count=1
while [ $count -le 5 ]; do
    echo "Count: $count"
    count=$((count+1))
done

if [ "$NAME" == "John Doe" ]; then
    echo "The name is Shanmathi!"
else
    echo "The name is not Shanmathi!"
fi
''', returnStdout: true).trim()
          env.SCRIPT_OUTPUT = scriptOutput
        }
      }
    }
    stage('Deploy') {
      steps {
        withCredentials([usernamePassword(credentialsId: "${DOCKER_REGISTRY_CREDS}", passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
          sh "echo \$DOCKER_PASSWORD | docker login -u \$DOCKER_USERNAME --password-stdin docker.io"
          sh 'docker push $DOCKER_BFLASK_IMAGE'
        }
      }
    } 
    stage('Gmail') {
      steps {
        emailext body: "*${currentBuild.currentResult}:* Job Name: ${env.JOB_NAME} || Build Number: ${env.BUILD_NUMBER} \nMore information at: ${env.BUILD_URL}",\nScript Output:\n${env.SCRIPT_OUTPUT},
          subject: 'Declarative Pipeline Build Status',
          to: 'shanmathivlr03@gmail.com'
      }
    }
  }

  post {
    always {
      sh 'docker rm -f mypycont'
      sh 'docker run --name mypycont -d -p 3000:5000 my-flask'
    }
  }
}
