package Repo::DriverRepo;

use Moose;

use DBI;
use Utils;
use Data::Dumper;

has 'dbh' => (
    is => 'ro',
    isa => 'DBI::db',
    builder => '_dbi_connect'
);

sub _dbi_connect {
    my $self = shift;

    my $conf = Utils::read_conf();
    my $database_conf = $conf->{database};
    warn Dumper($database_conf);
    my $dbh = DBI->connect("DBI:mysql:database=".$database_conf->{host}, $database_conf->{user}, $database_conf->{pass});

    return $dbh;
}

1;
