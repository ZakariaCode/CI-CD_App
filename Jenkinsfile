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
                    sh "docker run -d -p 8081:81 --name test-container $DOCKER_IMAGE:$DOCKER_TAG"
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([string(credentialsId: 'cfd2a167-03dc-4749-b257-6f63749d6f48', variable: 'ZakariaCode')]) {
                    // Remplacer ton_utilisateur par ton nom d'utilisateur Docker Hub (par exemple zakaria631)
                    sh 'echo $DOCKER_PASS | docker login -u zakaria631 --password-stdin'
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
