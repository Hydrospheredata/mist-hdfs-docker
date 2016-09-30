#!/bin/bash
set -e

/usr/sbin/sshd
sed -i "s%\${JAVA_HOME}%${JAVA_HOME}%" ${HADOOP_HOME}/etc/hadoop/hadoop-env.sh

if [ "$1" = 'start' ]; then
  $HADOOP_HOME/sbin/start-dfs.sh
  if [ -d /usr/share/mist ]; then
    ${HADOOP_HOME}/bin/hadoop fs -put /usr/share/mist/target/scala-*/mist_examples_*.jar /
  fi
  ${HADOOP_HOME}/bin/hadoop fs -ls /
  export lastLog=`ls -t ${HADOOP_HOME}/logs/hadoop-root-namenode-*.log | head -1`
  tail -f $lastLog
else
  exec "$@"
fi
