package Repo::DriverRepo;

use Moose;

use DBI;
use Utils::Util;
use Data::Dumper;

has 'dbh' => (
    is => 'ro',
    isa => 'DBI::db',
    builder => '_dbi_connect'
);

sub _dbi_connect {
    my $self = shift;

    my $conf = Utils::Util::read_conf();
    my $database_conf = $conf->{database};

    my $dbh = DBI->connect("DBI:mysql:database=PerlTraining:host=".$database_conf->{host}, $database_conf->{user}, $database_conf->{pass});

    return $dbh;
}



1;
