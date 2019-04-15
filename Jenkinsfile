// This is a Groovy file that gets loaded during a Jenkins build by the pipeline script
// (after a branch merge when testing branches) and one of the functions below is loaded
// to continue the build.

def testMondo(){
	stage('make test') {
		try {
			docker.image('obolibrary/odkfull').inside('--memory=8g -e ROBOT_JAVA_ARGS=-Xmx7G'){
				sh 'cd src/ontology; make test'
			} 
			tagSuccess('Tests passed!')
		} catch (exc) {
			tagError('Test error!')
			throw exc
		}
	}
}

def tagError(message){
    tagStatus('ERROR', message)
}

def tagSuccess(message){
    tagStatus("SUCCESS", message)
}

def tagPending(message){
    tagStatus('PENDING', message)
}

def tagStatus(status, message){
		println "Calling githubNotify with message ${message} and status ${status}, and commit ${env.TRAVIS_COMMIT}"
        githubNotify \
        account: 'monarch-initiative', \
        context: 'Jenkins Branch Test', \
        credentialsId: 'ShahimGHNameTokenForStatusUpdates', \
        description: message, \
        repo: 'mondo', \
        sha: env.TRAVIS_COMMIT, \
        status: status, \
        targetUrl: env.BUILD_URL+'console'
}

return this

/*
// the following is added to a script pipeline build in jenkins before this file is loaded and ran
node {
    
    stage ('Checkout and merge'){
        tagPending('Started!')
        try{
            sh 'git --version'
            sh 'git clone https://github.com/monarch-initiative/mondo.git . | true'
            sh 'git merge --abort | true'
            sh 'git clean -xdf'
            sh 'git fetch --all --prune'
            sh 'git checkout -f master'
            sh 'git branch --no-list | egrep -v "(  master$|\\*)" | xargs -r git branch -D'
            sh 'git reset --hard origin/master'
            sh "git checkout -B ${BUILD_TAG}"
            sh "git merge origin/${TRAVIS_BRANCH}"
            tagPending('Merged!') 
        }
        catch (exc) {
            tagError("Error with checkout/merge!")
        }
    }

    def jenkinsFile = load 'Jenkinsfile'
    jenkinsFile.testMondo()
}

def tagError(message){
    tagStatus('ERROR', message)
}

def tagSuccess(message){
    tagStatus("SUCCESS", message)
}

def tagPending(message){
    tagStatus('PENDING', message)
}

def tagStatus(status, message){
        githubNotify \
        account: 'monarch-initiative', \
        context: 'Jenkins Branch Test', \
        credentialsId: 'ShahimGHNameTokenForStatusUpdates', \
        description: message, \
        repo: 'mondo', \
        sha: env.TRAVIS_COMMIT, \
        status: status, \
        targetUrl: env.BUILD_URL+'console'
}
*/
