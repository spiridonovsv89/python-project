pipeline {
    agent any

    environment {
    DOCKERHUB = credentials('dockerhub')
    }
    stages {
        stage('Checkout') {
   	 	    steps {
   		 	    checkout scm
   	 	    }
    	}
        stage('Build') {
            steps {
                echo 'Building..'
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}