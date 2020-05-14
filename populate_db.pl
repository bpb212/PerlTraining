#!/usr/bin/perl

use strict;
use warnings;

use Utils::Util;
use DBI;


my $conf = Utils::Util::read_conf();
my $database_conf = $conf->{database};

my $dbh = DBI->connect("DBI:mysql:host=".$database_conf->{host}, $database_conf->{user}, $database_conf->{pass});

sub readCSV{
    my $file = shift;
    $file = "/perl_training/resources/".$file;

    open my $fh, '<', $file;
    my @lines;
    while (my $line = <$fh> ){
        chomp $line;
        warn "line : $line";
        push @lines, [ split ',', $line ];
    }
    close $fh;

    return \@lines;
}

sub populate_DB{
    my $teams = readCSV('team.csv');
    foreach my $team (@$teams){
        $dbh->do("INSERT IGNORE INTO team (id, name) VALUES( ?, ? )", undef, @$team );
    }

    my $drivers = readCSV('drivers.csv');
    foreach my $driver (@$drivers){
        $dbh->do("INSERT IGNORE INTO driver (id, name,age, points, teamID) VALUES( ?, ?, ?, ?, ? )", undef, @$driver );
    }
}

sub create_DB{
    my $createDBSQL = "CREATE DATABASE IF NOT EXISTS PerlTraining";

    $dbh->do($createDBSQL) or die $@;
    $dbh->do("use PerlTraining") or die $@;

    my $createTable = "CREATE TABLE IF NOT EXISTS driver (
        id INT,
        name VARCHAR(255),
        age INT,
        points INT,
        teamID INT,
        PRIMARY KEY (id)
    );";
    $dbh->do($createTable) or die $@;

    $createTable = "\nCREATE TABLE IF NOT EXISTS team (
        id INT,
        name VARCHAR(255),
        PRIMARY KEY (id)
    );";

    $dbh->do($createTable) or die $@;
}
print "="x100;
print "\n";
create_DB();
populate_DB();

print "="x100;
print "\n";
