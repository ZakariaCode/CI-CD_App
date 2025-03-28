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
        stage('Test Docker') {
            steps {
                sh '/usr/local/bin/docker --version'
            }
        }
        stage('Build Docker Image') {
            steps {
                sh '/usr/local/bin/docker build -t $DOCKER_IMAGE:$DOCKER_TAG .'
            }
        }

        stage('Test Docker Image') {
            steps {
                sh '/usr/local/bin/docker run -d -p 8081:81 --name test-container $DOCKER_IMAGE:$DOCKER_TAG'
                sh 'sleep 5'  // Attendre que le conteneur démarre
                sh 'curl -I http://localhost:8081'
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([string(credentialsId: 'docker-hub-password', variable: 'DOCKER_PASS')]) {
                    sh 'echo $DOCKER_PASS | /usr/local/bin/docker login -u zakaria631 --password-stdin'
                    sh '/usr/local/bin/docker push $DOCKER_IMAGE:$DOCKER_TAG'
                }
            }
        }

        stage('Cleanup') {
            steps {
                sh '/usr/local/bin/docker stop test-container && /usr/local/bin/docker rm test-container'
            }
        }
    }
}