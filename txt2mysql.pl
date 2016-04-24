#!/bin/perl
#
# imports txt file with file system data into mysql
# txt created with:
#	find -exec stat -t {} \; > list.txt

use strict;
use warnings;
use DBI;
use DateTime;
use File::Basename;

my @hd=("file", "size", "blocks", "type", "uid", "gid", "device", "inode", "links", "uid2", "gid2", "access", "modify", "change", "ioblock");

# Create a hash that holds attributes for the connection 
 my $attr = {
                RaiseError => 1, # Make database errors fatal to script
                AutoCommit => 0, # Prevent statements from committing 
                                 # their transactions.
            }; 
# Open a connection using a DSN. Supply the username and password.
my $dbh = DBI->connect("DBI:mysql:work","work","work", $attr);

if (defined $dbh->err) {
    # Connection failed.
    die "Failed to connect: $DBI::errstr";
}  

my $count=0;

# now retrieve data from the table.
#  my $sth = $dbh->prepare("SELECT * FROM test");
#  $sth->execute();
#  while (my $ref = $sth->fetchrow_hashref()) {
#    print "Found a row: id = $ref->{'id'}, vorname = $ref->{'vorname'}\n";
#  }
#  $sth->finish();

# print join("\t", @hd),"\n";

my $sth = $dbh->prepare("INSERT INTO files(bkname, linenr, filename, size, blocks, type, uid, gid, device, inode, links, uid2, gid2, access_d, modify_d, change_d, ioblock) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");

while(<>) {
	my @ln = split / /;
	
	my @fn;
	while($#ln > 13) {
		push(@fn, shift @ln)
	}

	my $dt_access = DateTime->from_epoch(epoch => $ln[10]);
	my $dt_modify = DateTime->from_epoch(epoch => $ln[11]);
	my $dt_change = DateTime->from_epoch(epoch => $ln[12]);

	my $bname = basename($ARGV);

	$sth->execute($bname, $., join(' ',@fn),$ln[0], $ln[1], $ln[2], $ln[3], $ln[4], $ln[5], $ln[6], $ln[7], $ln[8], $ln[9], $dt_access, $dt_modify, $dt_change, $ln[13]) || die;

	if ($. % 10000 == 0)  {
		print "commit at $bname $.\n";
		$dbh->commit;
	}
	#print join("\t",,@ln);
}

$dbh->commit;
$dbh->disconnect();

