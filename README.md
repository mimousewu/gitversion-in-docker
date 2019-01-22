# How am I?
This is a tool for generate version by git revsisions.
It base on docker and isolated from source codes. So it can work with any kinds of code, such as Java, Node, Python.

# GitVersion.yml
Copy GitVersion.yml.sample to your code base at root folder. And rename to GitVersion.yml.

The GitVersion.yml determine how the version increase and especilly the `next-version`.

# Integrate with Jenkins
The sample of Jenkinsfile
### before the build
```
stage('Prepare') {
      steps {
        sh "sh gitversion/genGitversion.sh ${WORKSPACE}"
        stash(includes: '.gitversion.json', name: 'gitversion')
      }
    }
```
Above steps will generate a .gitversion.json file and stashs into artifact repo of Jenkins

### During the build
Save the .gitversion.json in the build process for store the version information into application packages or image
```
stage('Build Docker Image') {
      steps {
        unstash 'build'
        unstash 'gitversion'
        sh "... build ..."
      }
    }
```

### After build
For example: use gitversion for tagging the docker image
```
stage('Push to Repo') {
      environment {
        GIT_VERSION = sh (
          script:"sh gitversion/showGitversion.sh ${WORKSPACE}",
          returnStdout: true
        ).trim()
      }
      steps {
        sh "docker tag app:latest app:${env.GIT_VERSION}"
        sh "docker push app:${env.GIT_VERSION}"
      }
    }
```