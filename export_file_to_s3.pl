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
 my $host = 'https://cavatica-api.sbgenomics.com';

 my $client = REST::Client->new(host => $host);

 my $XToken="$token";

 #get file1 ID

 my $id1 = &run_id1($file1);
 sub run_id1 {
 my $file1=shift;
 $client->GET("/v2/files?project=$project&name=$file1",
              #'Authorization' => "Basic $encoded_auth",
                {'X-SBG-Auth-Token' => "$XToken",
                'Content-Type' => 'application/json',
               'Accept' => 'application/json'});

 my $res1= 'Response: ' . $client->responseContent() . "\n";
 if ($res1=~/"id":"(.+?)",/){
                return $1;
                }
        }
 print "$file1 file_id is $id1\n";

#export

my $export_id=&export($file1,$id1);
sub export{
	my $read1_1=shift;
	my $path1_1=shift;
	my %request_body_map = (
		'source' => {
			'file' =>"$path1_1"
			},
		'destination' => {
			'volume' => "$volume",
			'location'=> "$read1_1"
			}
		);
	$client->POST('/v2/storage/exports',
                encode_json(\%request_body_map),
                {'X-SBG-Auth-Token' => "$XToken",
                'Content-Type' => 'application/json',
               'Accept' => 'application/json'});

        my  $res5= 'Response: ' . $client->responseContent() . "\n";
        if ($res5=~/"id":"(.+?)",/){
                return $1;
		}
	}
print "export file $file1 export id is $export_id\n";

sub usage{
print <<"USAGE";

Usage: perl export_file_to_s3.pl -t <token> -p <project_name> -v <volume_name>  <file_name_cavatica> 

USAGE
}
