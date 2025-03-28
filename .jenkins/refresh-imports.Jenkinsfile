pipeline {
    agent { label 'monarch-agent-large' }
    triggers {
        cron('H H * * 7')  //sometime on Sundays
    }
    environment {
        HOME = "${env.WORKSPACE}"
        MEMORY_GB = 40
    }
    stages {
        stage('setup') {
            steps {
                sh '''
                echo "I'm setting up"    
                '''
            }
        }
        stage('do-stuff') {
            steps {
                dir("src/ontology") {
                    sh '''
                    sh run.sh make refresh-merged
                    '''
                }
            }
        }
        stage('upload') {
            steps {
                sh '''
                    echo "In this step, in the future, I will make a new branch, commit the changes and push. I'll need permissions first"
                '''
            }
        }
    }
}
