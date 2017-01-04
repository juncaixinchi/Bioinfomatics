#!/usr/bin/perl -w
## analysis sequcecing data frome 23andme or wegene, Find the same snps and genotype
my @snp;
my @we;
$File_1="23andme_22_8.txt";
$File_2="23andme_5476_3965.txt";
$Result_url="R23andme_3965_8.txt";
open SNP,"<","./$File_1";
while(<SNP>)
{
	chomp;
	($w,$x,$y,$z)=split;
	if($w=~/rs/)
	{
	push @snp,$w;
	$snps{$w}=$z;
	}
}
close SNP;
open We,"<","./$File_2";
while(<We>)
{
	chomp;
	($a,$b,$c,$d)=split;
	if($a=~/rs/)
	{
	push @we,$a;
	$wes{$a}=$d;
	}
}
close We;
@snp=sort @snp;
@we=sort @we;
$lenth=@we;
$n=0;
open FILE_OUT,">","./$Result_url"; 
select FILE_OUT;
$|=1;
print "#rs\t$File_1\t$File_2\n";
foreach $i(sort @snp)
{
	for($j=$n;($j<$lenth)and($we[$j]le$i);$j++)
	{
		if($we[$j] eq $i)
		{
			$rs=$we[$j];
			print "$rs\t$snps{$rs}\t$wes{$rs}\n";
			$n=$j;
			last;
		}
	}
}
close FILE_OUT;
