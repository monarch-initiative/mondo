pipeline {
    agent { label 'monarch-agent-large' }
    triggers {
        cron('H H * * 7')  //sometime on Sundays
    }
    environment {
        HOME = "${env.WORKSPACE}"       
    }
    stages {
        stage('setup') {
            steps {
                sh '''
                echo "I'm setting myself up!"
                '''
            }
        }
        stage('do-stuff') {
            steps {
                sh '''
                echo "I'm doing stuff!"
                '''
            }
        }
        stage('upload') {
            steps {
                sh '''
                    echo "I'm uploading!"
                '''
            }
        }
    }
}
