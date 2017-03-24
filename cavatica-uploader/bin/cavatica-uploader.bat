@ECHO OFF

for %%F in (%0) do set DIRNAME=%%~dpF
set DIRNAME=%DIRNAME%/..

set JVM_ARGS=-Xmx256m
set CLASSPATH=%DIRNAME%/conf/*;%DIRNAME%/lib/*
set MAIN_CLASS=com.sbgenomics.cli.uploader.CLIUploader
set LOG_PATH=%DIRNAME%/log

java -classpath %CLASSPATH% -DLOG_PATH=%LOG_PATH% %JVM_ARGS% %MAIN_CLASS% %*
