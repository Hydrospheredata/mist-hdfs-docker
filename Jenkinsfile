node 
{
    stage 'clone projet'
    checkout scm
    stage 'build and test'
    parallel ( failFast: false,
        Spark_1_5_2: { test_platform("1.5.2") },
        Spark_1_6_2: { test_platform("1.6.2") },
        Spark_2_0_0: { test_platform("2.0.0") },
    )
}

def test_platform(sparkVersion)
{
  echo 'build ' + sparkVersion
  echo 'prepare ' + sparkVersion
  echo 'test ' + sparkVersion
}
