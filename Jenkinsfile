node {
  currentBuild.result = "SUCCESS"
  try {
    stage('clone project') {
      checkout scm
    }
    stage('build hdfs container') {
      docker.withRegistry('https://index.docker.io/v1/', '2276974e-852b-45ab-bf14-9136e1b31217') {
        def branch = env.BRANCH_NAME
        echo "branch - ${branch}"
        def tag = sh(returnStdout: true, script: "git tag -l --contains HEAD").trim()
        if (tag == '') {
          echo "tag not found"
        } else {
          echo "tag - ${tag}"
        }
        if ( branch == 'master') {
          pcImg = docker.build("hydrosphere/hdfs:latest")
          pcImg.push()
        } else {
          pcImg = docker.build("hydrosphere/hdfs:${branch}")
        }
      }
    }
  }
  catch (err) {
    currentBuild.result = "FAILURE"
    echo "${err}"
    gitEmail = sh(returnStdout: true, script: "git --no-pager show -s --format='%ae' HEAD").trim()
    mail body: "project build error is here: ${env.BUILD_URL}" ,
        from: 'hydro-support@provectus.com',
        replyTo: 'noreply@provectus.com',
        subject: 'project build failed',
        to: gitEmail
    throw err
  }
}
