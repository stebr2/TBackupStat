#!/bin/perl
#
# converts txt file with file system data to csv
# txt created with:
#	find -exec stat -t {} \; > list.txt

my @hd=("file", "size", "blocks", "type", "uid", "gid", "device", "inode", "links", "uid2", "gid2", "access", "modify", "change", "ioblock");
print join("\t", @hd),"\n";

while(<>) {
	@ln = split / /;
	
	my @fn;
	while($#ln > 13) {
		push(@fn, shift @ln)
	}
	print join("\t",join(' ',@fn),@ln);
}
