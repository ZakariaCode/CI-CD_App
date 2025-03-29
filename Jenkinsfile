pipeline {
    agent any

    environment {
        // Définir l'image Docker et le tag à utiliser
        DOCKER_IMAGE = 'zakaria631/mon-site-web'
        DOCKER_TAG = 'latest'
    }

    stages {
        // Cloner le projet depuis GitHub
        stage('Cloner le projet') {
            steps {
                git branch: 'main', url: 'https://github.com/ZakariaCode/CI-CD_App.git'
            }
        }

        // Tester la version de Docker
        stage('Test Docker') {
            steps {
                sh 'docker --version'
            }
        }

        // Construire l'image Docker
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE:$DOCKER_TAG .'
            }
        }

        // Tester l'image Docker en exécutant un conteneur
        stage('Test Docker Image') {
            steps {
                script {
                    // Arrêter et supprimer le conteneur existant s'il existe
                    sh "docker rm -f test-container || true"  // Force supprimer si le conteneur existe déjà

                    // Lancer le nouveau conteneur
                    sh "docker run -d -p 8081:81 --name test-container $DOCKER_IMAGE:$DOCKER_TAG"
                }
            }
        }

        // Pousser l'image Docker vers Docker Hub
        stage('Push to Docker Hub') {
            steps {
                // Authentification à Docker Hub avec les credentials Jenkins
                withCredentials([usernamePassword(credentialsId: 'Jenkins_pipeline', 
                                                   usernameVariable: 'DOCKER_USERNAME', 
                                                   passwordVariable: 'DOCKER_PASSWORD')]) {
                    // Effectuer un login Docker en mode non interactif
                    sh 'docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD'
                    // Pousser l'image vers Docker Hub
                    sh 'docker push $DOCKER_IMAGE:$DOCKER_TAG'
                }
            }
        }

        // Nettoyage : arrêter et supprimer le conteneur de test
        stage('Cleanup') {
            steps {
                sh 'docker stop test-container && docker rm test-container'
            }
        }
    }
}
