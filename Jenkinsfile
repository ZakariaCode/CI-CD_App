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
                sh '''
                    mkdir -p ~/.docker
                    echo '{"credsStore":""}' > ~/.docker/config.json
                    /usr/local/bin/docker build -t $DOCKER_IMAGE:$DOCKER_TAG .
                '''
            }
        }

       stage('Test Docker Image') {
    steps {
        script {
            // Vérifier et supprimer l'ancien conteneur
            sh '''
                if /usr/local/bin/docker ps -a --format '{{.Names}}' | grep -w test-container; then
                    /usr/local/bin/docker stop test-container || true
                    /usr/local/bin/docker rm test-container || true
                fi
            '''

            // Démarrer un nouveau conteneur avec le bon port
            sh '''
                /usr/local/bin/docker run -d -p 8081:80 --name test-container $DOCKER_IMAGE:$DOCKER_TAG
                sleep 10  # Augmenter le temps d'attente
            '''

            // Vérifier si le conteneur tourne
            sh '/usr/local/bin/docker ps -a'

            // Vérifier si nginx tourne bien
            sh '/usr/local/bin/docker exec test-container nginx -t || true'

            // Tester l'accès au serveur
            sh 'curl -I http://localhost:8081 || (echo "Curl failed!" && /usr/local/bin/docker logs test-container && exit 1)'
        }
    }
}


        stage('Push to Docker Hub') {
            steps {
                withCredentials([string(credentialsId: 'docker-hub-password', variable: 'DOCKER_PASS')]) {
                    sh '''
                        echo $DOCKER_PASS | /usr/local/bin/docker login -u zakaria631 --password-stdin
                        /usr/local/bin/docker push $DOCKER_IMAGE:$DOCKER_TAG
                    '''
                }
            }
        }

        stage('Cleanup') {
            steps {
                sh '''
                    /usr/local/bin/docker stop test-container || true
                    /usr/local/bin/docker rm test-container || true
                '''
            }
        }
    }
}
