pipeline {
    agent none
    stages {
        stage('Build within Docker container') {
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
                        stash name: "build-output", includes: "target/*.jar"
                    }
                }
            }
        }
        stage('Create Docker') {
            agent any
            steps {
                unstash "build-output"
                script {
                    def myApp = docker.build("radekpribyl/myapp:${env.BUILD_ID}", "--build-arg APPDIR=target/ --build-arg APPNAME=my-app-1.0-SNAPSHOT.jar .")
                }
            }
        }
    }
}
