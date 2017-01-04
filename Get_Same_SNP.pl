#!/usr/bin/perl -w
my @snp;
my @we;
open SNP,"<","./Wegene_LXW.txt";
$|=1;
while(<SNP>)
{
	chomp;
	($w,$x,$y,$z)=split;
	if($w=~/rs/)
	{
		push @snp,$w;
	}
}
close SNP;
open We,"<","./Wegene_V0_LXW.txt";
while(<We>)
{
	chomp;
	($a,$b,$c,$d)=split;
	if($a=~/rs/)
	{
		push @we,$a;
	}
}
close We;
@snp=sort @snp;
@we=sort @we;
$lenth=@we;
$n=0;
foreach $rs(sort @snp)
{
	for($j=$n;($j<$lenth)and($we[$j]le$rs);$j++)
	{
		if($we[$j] eq $rs)
		{
			print "$we[$j]\n";
			$n=$j;
			last;
		}
	}
}
