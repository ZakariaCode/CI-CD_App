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
                    sh "docker rm -f test-container || true"  // Force supprimer si le conteneur existe déjà
                    sh "docker run -d -p 8081:80 --name test-container $DOCKER_IMAGE:$DOCKER_TAG"
                }
            }
        }
        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'my-docker-hub-password', 
                                                   usernameVariable: 'DOCKER_USERNAME', 
                                                   passwordVariable: 'DOCKER_PASSWORD')]) {
                    sh 'docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD'
                    sh 'docker push $DOCKER_IMAGE:$DOCKER_TAG'
                }
            }
        }
        // stage('Cleanup') {
        //     steps {
        //         sh 'docker stop test-container && docker rm test-container'
        //     }
        // }
    }
}
