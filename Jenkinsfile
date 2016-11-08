node {
  currentBuild.result = "SUCCESS"
  try {
    stage('clone project') {
      checkout scm
    }
    stage('build hdfs container') {
      docker.withRegistry('https://index.docker.io/v1/', '2276974e-852b-45ab-bf14-9136e1b31217') {
        //tokens = "${env.JOB_NAME}".tokenize('/')
        //branch = tokens[tokens.size()-1]
        def branch = env.BRANCH_NAME
        echo "branch - ${branch}"
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
    mail body: "project build error is here: ${env.BUILD_URL}" ,
        from: 'hydro-support@provectus.com',
        replyTo: 'noreply@provectus.com',
        subject: 'project build failed',
        to: "peanig@gmail.com"
    throw err
  }
}
