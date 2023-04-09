pipeline {
    environment {
        registry = "spiridonovsv89/python-project"
        registryCredential = 'dockerhub'
        PROJECT_ID = 'innate-path-377808'
        CLUSTER_NAME = 'cluster-1'
        LOCATION = 'us-central1-c'
        CREDENTIALS_ID = 'My First Project'
    }
    agent {
        kubernetes {
           yaml '''
            apiVersion: v1
            kind: Pod
            spec:
                containers:
                - name: kubectl
                  image: bitnami/kubectl:latest
                  tty: true
                  securityContext:
                    runAsUser: 0
                    runAsGroup: 0
                    privileged: true
                  command:
                  - cat
                - name: python
                  image: python:3.10
                  command:
                  - /bin/sh
                  tty: true
                  env:
                  - name: MARIADB_ROOT_PASSWORD
                    valueFrom:
                     secretKeyRef:
                      name: mariadb-secret
                      key: mariadb-root-password
                  - name: MARIADB_DATABASE
                    valueFrom:
                     configMapKeyRef:
                      name: mariadb-configmap
                      key: database
                  - name: MARIADB_ROOT_HOST
                    valueFrom:
                     configMapKeyRef:
                      name: mariadb-configmap
                      key: host
                - name: dind
                  image: docker:20-dind
                  command:
                  - dockerd-entrypoint.sh
                  tty: true
                  securityContext:
                    privileged: true
                  env:
                  - name: DOCKER_TLS_VERIFY
                  value: ""
            '''
        }
    }
    stages {

        stage('Test') {
            steps {
                container('python') {
                    sh "pip install -r requirements.txt"
                    sh "python3 -m unittest test.py app.py"
                }
            }
        }

        stage('Building image') {
            steps {
                container('dind') {
                    script {
                        dockerImage = docker.build(registry + ":0.$BUILD_NUMBER", "--network host .")
                    }
                }
            }
        }
        stage('Deploy Image') {
            steps {
                container('dind') {
                    script {
                        docker.withRegistry( '', registryCredential ) {
                            dockerImage.push()
                        }
                    }
                }
            }
        }
        stage('Remove Unused docker image') {
            steps {
                container('dind') {
                    sh "docker rmi $registry:0.$BUILD_NUMBER"
                }
            }
        }
        stage('Deploy to GKE') {
            steps {
                container('kubectl') {
                    step ([$class: 'KubernetesEngineBuilder', projectId: env.PROJECT_ID, clusterName: env.CLUSTER_NAME, location: env.LOCATION, manifestPattern: 'k8s/backend/', credentialsId: env.CREDENTIALS_ID, verifyDeployments: true])
                    sh "sed -i 's#spiridonovsv89/python-project:latest#spiridonovsv89/python-project:0.$BUILD_NUMBER#' ./k8s/frontend/*.yaml"
                    step ([$class: 'KubernetesEngineBuilder', projectId: env.PROJECT_ID, clusterName: env.CLUSTER_NAME, location: env.LOCATION, manifestPattern: 'k8s/frontend/', credentialsId: env.CREDENTIALS_ID, verifyDeployments: true])


                }
            }
        }
    }
}