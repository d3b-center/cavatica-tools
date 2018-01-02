#!/usr/bin/env perl -w
#use strict;
#use warnings;
use MIME::Base64;
use JSON;
use REST::Client;
use Getopt::Std;
use vars qw($opt_t $opt_b $opt_i $opt_k $opt_v $opt_p $opt_h);
getopts('t:v:b:i:k:p:h');
my $token=$opt_t;
my $bucket=$opt_b;
my $volume=$opt_v;
my $access_id=$opt_i;
my $access_key=$opt_k;
my $prefix=$opt_p;
my $help=$opt_h;
use REST::Client;

 if ($help){
        &usage();exit;
}
 unless($token){
        &usage();
        exit;
}

my $host = 'https://cavatica-api.sbgenomics.com/v2';

my $des="s3://$bucket/$prefix/";

my %request_body_map = (
		"name" =>"$volume",
                "description" => "$des",
		"service" => {
			"type" =>"S3",
			"bucket" => "$bucket",
			"prefix" => "$prefix",
			"credentials" => {
				"access_key_id" => "$access_id",
				"secret_access_key" => "$access_key"
				},
			"properties" => {
				"sse_algorithm" => "AES256"
				}
			},
		"access_mode" => "RO"
	);
my $client = REST::Client->new(host => $host);
 
my $XToken=$token;

$client->POST('/storage/volumes',
		encode_json(\%request_body_map),
                {'X-SBG-Auth-Token' => "$XToken",
		'Content-Type' => 'application/json',
               'Accept' => 'application/json'}); 
 
 print 'Response: ' . $client->responseContent() . "\n";

sub usage {
        my $usage= << "USAGE";

Usage: perl post_new_volume.pl -t <token> -b <bucket_name> -v <volume_name> -i <access_key_id> -k <secret_access_key> -p <prefix>

Example: perl post_new_volume.pl -t  ef6a1...das6  -b test.cavatica -v task_test_volume -i AKIA...Q -k 8Z+mJ4...LG

USAGE
        print $usage;
        }
