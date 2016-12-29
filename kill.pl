#!/usr/bin/perl -w

open A,"ps -efl | grep lixinwei |";
while(<A>){
	@arr = split" ",$_;
	if(/sshd/ || /top/ || /vi/  || /sftp/){
		next;
	}
	system qq{kill $arr[3]};
}

close A;

