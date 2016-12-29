#!/usr/bin/perl -w
my @snp;
my @we;
open SNP,"<","./SNP_List_1.txt";
$|=1;
while(<SNP>)
{
	chomp;
	push @snp,$_;
}
close SNP;
open We,"<","./SNP_List_2.txt";
while(<We>)
{
	chomp;
	push @we,$_;
}
close We;
@snp=sort @snp;
@we=sort @we;
$lenth=@we;
$n=0;
foreach $i(sort @snp)
{
	for($j=$n;$j<$lenth;$j++)
	{
		if($we[$j] eq $i)
		{
			print "$we[$j]\n";
			$n=$j;
			last;
		}
	}
}
