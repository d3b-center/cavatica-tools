#!/usr/bin/env perl -w
use strict;
use warnings;
use MIME::Base64;
use JSON;
use REST::Client;
use Getopt::Std;
use vars qw($opt_t $opt_p $opt_v $opt_h);
getopts('t:p:v:h');
my $token=$opt_t;
my $project=$opt_p;
my $volume=$opt_v;
my $help=$opt_h;
 use REST::Client;

 if ($help){
        &usage();exit;
}
 unless($token){
        &usage();
        exit;
}

my $file1=shift;
my $path=shift;

my $host = 'https://cavatica-api.sbgenomics.com/v2';

my %request_body_map = (
                 'destination' => {
                             'name' => "$file1",
                             'project' => "$project"
                           },
          'source' => {
                        'volume' => "$volume",
                        'location' => "$path"
                      },
		"overwrite" =>  "true"
	);
my $client = REST::Client->new(host => $host);
 
my $XToken=$token;

$client->POST('/storage/imports',
		encode_json(\%request_body_map),
                {'X-SBG-Auth-Token' => "$XToken",
		'Content-Type' => 'application/json',
               'Accept' => 'application/json'}); 
 
 print 'Response: ' . $client->responseContent() . "\n";

sub usage {
        my $usage= << "USAGE";

Usage: perl import_file_volume.pl -t <token> -p <project_name> -v <volume_name> <file_name_cavatica> <file_from_S3_bucket>

Example: perl import_file_volume.pl -t  ef6a1...das6 -p zhangb1/develop-project -v zhangb1/task_test_bucket2 test.bam test.bam 

USAGE
        print $usage;
        }
