#!/usr/bin/perl -w
open Disease,"<","./name_only.txt";
my $name;
my $n=1;
print"number\tname\tname_in_baidu\tresult";
while(<Disease>)
{
	chomp;
	$name=$_;
	$web="NA";
	$id="NA";
	print "\n$n\t$name";
	$n++;
	$_=~s/ /+/g;
	system "wget http://baike.baidu.com/search?word=$_ -O ./Dir_search/$name.html";
	open (FILE,"<","./Dir_search/$name.html") || next;
	while(<FILE>)
	{
		if(/<a class="result-title" href="(.*)"/)
		{
			$web=$1;last;
		}
	}
	close FILE;
	system "wget $web -O ./Dir_web/Disease_$name.html";
	open (FILE,"<","./Dir_web/Disease_$name.html") || next;
	while(<FILE>)
	{
		if(/<title>(.*?)_百度百科<\/title>/)
		{
			print "\t$1";
		}
		if(/newLemmaIdEnc:"(.*?)"/)
		{
			$id=$1;last;
		}
	}
	close FILE;
    system "wget http://baike.baidu.com/api/lemmapv?id=$id -O ./Dir_result/Result_$name.txt";
	open (FILE,"<","./Dir_result/Result_$name.txt") || next;
	while(<FILE>)
	{
		if(/{"pv":(.*?)}/)
		{
			print "\t$1";
		}
	}
	close FILE;
}
close Disease;
print "\n";
