use strict;
use warnings;
my $n=1;
open FILE,"<","SNP_List.txt";
open FILE_w,">","result.txt";
select FILE_w;
$|=1;
print FILE_w "RSID\tNA\tMAF\tAA\tMA\n";
while(<FILE>)
{
	chomp;
	my $rs=$_;
	print STDOUT "$n\t$rs\n";
	$n++;
	use HTTP::Tiny;
	my $http = HTTP::Tiny->new();
	my $server = 'http://rest.ensembl.org';
	my $ext = "/variation/human/$rs?population_genotypes=1";
	my $response = $http->get($server.$ext, {
			headers => { 'Content-type' => 'application/json' }
			});
#die "Failed!\n" unless $response->{success};
	unless ($response->{success})
	{
		$n++;
		next;
	}
	use JSON;
	use Data::Dumper;
	if(length $response->{content}) {
		my $hash = decode_json($response->{content});
		local $Data::Dumper::Terse = 1;
		local $Data::Dumper::Indent = 1;
#print Dumper $hash;
		if(exists($$hash{error}))
		{
			print FILE_w "rs$rs\tNA\tNA\tNA\tNA\n";
			next;
		}
		my $mappings=$$hash{mappings};
		my $allele_string=$$mappings[0];
		my $AS=$$allele_string{allele_string};
		$AS="NA" unless $AS;
		my $name=$$hash{name};
		$name="NA" unless $name;
		my $MAF=$$hash{MAF};
		$MAF="NA" unless $MAF;
		my $AA=$$hash{ancestral_allele};
		$AA="NA" unless $AA;
		my $MA=$$hash{minor_allele};
		$MA="NA" unless $MA;
		print FILE_w "$name\t$AS\t$MAF\t$AA\t$MA\n";
	}
}
close FILE;
close FILE_w;
