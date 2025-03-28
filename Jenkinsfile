pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'zakaria631/mon-site-web'
        DOCKER_TAG = 'latest'
    }

    stages {
        stage('Cloner le projet') {
            steps {
                git branch: 'main', url: 'https://github.com/ZakariaCode/CI-CD_App.git'

            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE:$DOCKER_TAG .'
            }
        }

        stage('Test Docker Image') {
            steps {
                sh 'docker run -d -p 8081:81 --name test-container $DOCKER_IMAGE:$DOCKER_TAG'
                sh 'sleep 5'  // Attendre que le conteneur démarre
                sh 'curl -I http://localhost:8081'
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([string(credentialsId: 'docker-hub-password', variable: 'DOCKER_PASS')]) {
                    sh 'echo $DOCKER_PASS | docker login -u ton_utilisateur --password-stdin'
                    sh 'docker push $DOCKER_IMAGE:$DOCKER_TAG'
                }
            }
        }

        stage('Cleanup') {
            steps {
                sh 'docker stop test-container && docker rm test-container'
            }
        }
    }
}
