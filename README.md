# cavatica-tools

## cavatica-uploader

```
Upload files to Cavatica

./cavatica-uploader/bin/cavatica-uploader.sh -t <token> -p <project_id>  <file_to_upload>

use ./cavatica-uploader/bin/cavatica-uploader.sh -h to see more usage

```

## get file path ID on Cavatica

```
Usage: perl get_path_id.pl -t <token> -p <project_name>  <file>

Example: perl get_path_id.pl -t  ef6a1...das6 -p zhangb1/develop-project test.bam

```
## post new volume

```
Usage: perl post_new_volume.pl -t <token> -b <bucket_name> -v <volume_name> -i <access_key_id> -k <secret_access_key>

Example: perl post_new_volume.pl -t  ef6a1...das6  -b test.cavatica -v task_test_volume -i AKIA...Q -k 8Z+mJ4...LG

```

## improt file from S3 bucket to Cavatica

```
Usage: perl import_file_volume.pl -t <token> -p <project_name> -v <volume_name> <file_name_cavatica> <file_from_S3_bucket>

Example: perl import_file_volume.pl -t  ef6a1...das6 -p zhangb1/develop-project -v zhangb1/task_test_bucket2 test.bam test.bam

```