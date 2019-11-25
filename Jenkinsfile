pipeline {
    agent {
        docker {
            image 'maven:3-alpine' 
            args '-v /root/.m2:/root/.m2' 
        }
    }
    stages {
        stage('Build') { 
            steps {
                sh 'mvn -B -DskipTests clean package' 
            }
        }
        stage('Test') {
            steps {
                sh 'mvn test'
            }
            post {
                always {
                    junit 'target/surefire-reports/*.xml'
                }
            }
        }
        stage('Deliver') { 
            steps {
                sh './jenkins/scripts/deliver.sh' 
            }
        }
        stage('Create Docker') {
            steps {
                script {
                    def myApp = docker.build("radekpribyl/myapp:${env.BUILD_ID}", "--build-arg APPDIR=target/ --build-arg APPNAME=my-app-1.0-SNAPSHOT.jar .")
                }
            }
        }
    }
}