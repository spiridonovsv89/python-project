pipeline {
  environment {
    registry = "spiridonovsv89/python-project"
    registryCredential = 'dockerhub'
  }
  agent {
      label 'python'
  }
  stages {

    stage('Test'){
        steps{
            container('python') {
                sh "pip install -r requirements.txt"
                sh "python3 -m unittest test.py app.py"
            }
        }
    }

    stage('Building image') {
      steps{
        container('dind'){
            script {
                 dockerImage = docker.build(registry + ":$BUILD_NUMBER", "--network host .")
        }
      }
      }
    }
    stage('Deploy Image') {
      steps{
        container('dind'){
            script {
                docker.withRegistry( '', registryCredential ) {
                dockerImage.push()
          }
        }
      }
    }
    }
    stage('Remove Unused docker image') {
      steps{
            container('dind') {
                sh "docker rmi $registry:$BUILD_NUMBER"
         }
       }
     }
   }
 }