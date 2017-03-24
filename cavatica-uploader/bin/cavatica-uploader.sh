#!/bin/sh

# build classpath
base_dir=$(dirname $0)/..
classpath=$(echo $base_dir/target/*.jar $base_dir/lib/*.jar | tr " " :)

# add other parameters!
jvm_args="-Xmx256m -Xss256k"
classpath=$classpath:conf/
external_libs=/usr/local/lib
main_class=com.sbgenomics.cli.uploader.CLIUploader
log_path=$(dirname $0)/../log

# run application
java -cp $classpath -DLOG_PATH=$log_path -Djava.library.path=$external_libs $jvm_args $main_class "$@"
