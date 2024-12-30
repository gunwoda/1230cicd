pipeline {
    agent any

    environment {
        IMAGE_NAME = "test1230/cicdtest"
        DOCKER_USERNAME = "${env.DOCKER_USERNAME}" // GitHub Secrets로 전달받음
        DOCKER_PASSWORD = "${env.DOCKERHUB_TOKEN}" // GitHub Secrets로 전달받음
    }

    stages {
//         stage('Checkout') {
//             steps {
//                 // GitHub에서 소스코드 가져오기
//                 git branch: 'main', url: 'https://github.com/gunwoda/1230cicd.git'
//             }
//         }
        stage("permission"){
             steps{
                 sh "chmod +x ./gradlew"
             }
         }

        stage('Set Tag') {
            steps {
                script {
                    // Git 커밋 해시값 가져오기
                    TAG = sh(script: "git rev-parse --short HEAD", returnStdout: true).trim()
                    echo "Git Commit Hash: ${TAG}"
                }
            }
        }

        stage('Build') {
            steps {
                // Gradle 빌드 및 테스트 실행
                sh './gradlew clean build'
            }
        }

        stage('Docker Login') {
            steps {
                // Jenkins Credentials를 사용하여 Docker Hub에 로그인
                withCredentials([usernamePassword(credentialsId: 'dockerhub-id', usernameVariable: 'username', passwordVariable: 'token')]) {
                    sh "echo ${token} | docker login -u ${username} --password-stdin"
                }
            }
        }

        stage('Docker Build') {
            steps {
                // Docker 이미지 빌드
                sh "docker build -t ${IMAGE_NAME}:${TAG} ."
            }
        }

        stage('Test Image') {
            steps {
                // 빌드한 Docker 이미지를 테스트
                sh "docker run --rm ${IMAGE_NAME}:${TAG} java -jar /app.jar --spring.profiles.active=test"
            }
        }

        stage('Push to Registry') {
            steps {
                // Docker Registry로 푸시
                sh "docker push ${IMAGE_NAME}:${TAG}"
            }
        }
    }

    post {
        success {
            echo 'Pipeline 실행 성공!'
        }
        failure {
            echo 'Pipeline 실행 실패.'
        }
    }
}
