 #!/usr/bin/env perl -w
 use strict;
 use warnings;
 use MIME::Base64;
 use Getopt::Std;
 use vars qw($opt_t $opt_p $opt_h);
 getopts('t:p:h');
 my $token=$opt_t;
 my $project=$opt_p;
 my $help=$opt_h;
 my $file=shift;
 use REST::Client;

 if ($help){
        &usage();exit;
}
 unless($token){
        &usage();
        exit;
}
 my $host = 'https://cavatica-api.sbgenomics.com';
 
 my $client = REST::Client->new(host => $host);
 
 my $XToken=$token;
 my $id=&run_id($file);
 sub run_id{
 my $file1=shift;
 $client->GET("/v2/files?project=$project&name=$file1",
		{'X-SBG-Auth-Token' => "$XToken",
		'Content-Type' => 'application/json',
               'Accept' => 'application/json'});
 
	 my $res= 'Response: ' . $client->responseContent() . "\n";
	 if ($res=~/"id":"(.+?)",/){
			return $1;}
	}

print "$file file_id in $project is $id\n";
sub usage {
	my $usage= << "USAGE";
	
Usage: perl get_path_id.pl -t <token> -p <project_name>  <file>
	
Example: perl get_path_id.pl -t  ef6a1...das6 -p zhangb1/develop-project test.bam
	
USAGE
	print $usage;
	}

