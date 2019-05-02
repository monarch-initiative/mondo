// This is a Groovy file that gets loaded during a Jenkins build by the pipeline script
// (after a branch merge when testing branches) and one of the functions below is loaded
// to continue the build.

//The calling script from the Jenkins build, to reuse a couple of methods instead of duplication here
def callerScript

def setCaller(caller){
	callerScript = caller
}

def testMondo(){
	stage('make test') {
		try {
			docker.image('obolibrary/odkfull').inside('--memory=100g -e ROBOT_JAVA_ARGS=-Xmx64G'){
				sh 'cd src/ontology; make test'
			} 
			callerScript.tagSuccess('Tests passed!')
		} catch (exc) {
			callerScript.tagError('Test error!')
			throw exc
		}
	}
}

return this


// the following is added to a script pipeline build in Jenkins before this file is loaded and ran
/*
node {
    
    stage ('Checkout'){
        tagPending('Started!')
        try{
            sh 'git --version'
            sh 'git clone https://github.com/monarch-initiative/mondo.git . | true'
            sh 'git merge --abort | true'
            sh 'git clean -xdf'
            sh 'git fetch --all --prune'
            sh "git checkout -f origin/${TRAVIS_BRANCH}"
            sh 'git branch --no-list | egrep -v "(\\*)" | xargs -r git branch -D'
            sh "git reset --hard origin/${TRAVIS_BRANCH}"
            sh "git checkout -B ${BUILD_TAG}"
            tagPending("Checked out ${TRAVIS_BRANCH}!") 
        }
        catch (exc) {
            tagError("Error with checking out ${TRAVIS_BRANCH}!")
            trow exc
        }
    }
    
    stage('Merge if needed'){
        if (env.TRAVIS_PULL_REQUEST != 'false'){
            try{
                sh "git merge origin/${TRAVIS_PULL_REQUEST_BRANCH}"
                tagPending("Merged ${TRAVIS_PULL_REQUEST_BRANCH}!") 
            }
            catch(exc){
                tagError("Error with merging ${TRAVIS_PULL_REQUEST_BRANCH}!")
                throw exc
            }
        }
    }

    def jenkinsFile = load 'Jenkinsfile'
    jenkinsFile.setCaller(this)
    jenkinsFile.testMondo()
}

def getStatusSha(){
    if (env.TRAVIS_PULL_REQUEST == 'false'){
        return env.TRAVIS_COMMIT
    }else{
        return env.TRAVIS_PULL_REQUEST_SHA
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
        githubNotify \
        account: 'monarch-initiative', \
        context: 'Jenkins Mondo test', \
        credentialsId: 'ShahimGHNameTokenForStatusUpdates', \
        description: message, \
        repo: 'mondo', \
        sha: getStatusSha(), \
        status: status, \
        targetUrl: env.BUILD_URL+'console'
}
*/

