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
                  sh 'docker --version'
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE:$DOCKER_TAG .'
            }
        }

        stage('Test Docker Image') {
    steps {
        script {
            // Stop and remove the existing container if it exists
            sh "docker rm -f test-container || true"  // force remove if container exists

            // Run the new container
            sh "docker run -d -p 8081:81 --name test-container zakaria631/mon-site-web:latest"
        }
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
