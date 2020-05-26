package Repo::DriverRepo;

use Moose;

use DBI;
use Utils::Util;
use Data::Dumper;

use strict;
use warnings;

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

sub getDrivers {
    my $self = shift;

    my $sql = "select * from driver";

    my $dbh = $self->dbh();
    $dbh->{RaiseError} = 1;

    my $sth = $dbh->prepare($sql);
    $sth->execute();

    my @drivers;
    while ( my $driver = $sth->fetchrow_hashref()){
        push @drivers, new Entity::Driver(
                id => $driver->{id},
                teamID => $driver->{teamID},
                name => $driver->{name},
                age => $driver->{age},
                points => $driver->{points});
    }

    return \@drivers;
}

sub getTeams {
    my $self = shift;

    my $sql = "select team.id, team.name, sum(driver.points) as points from team inner join driver on team.id = driver.teamID group by driver.teamID";

    my $dbh = $self->dbh();
    $dbh->{RaiseError} = 1;

    my $sth = $dbh->prepare($sql);
    $sth->execute();

    my @teams;
    while ( my $team = $sth->fetchrow_hashref()) {
        push @teams, new Entity::Team(
                id => $team->{id},
                name => $team->{name},
                points => $team->{points}
        )
    }

    return \@teams;
}


sub orderDivers {
    my ($self, $drivers) = @_;

    my @sortedDrivers = sort { $a->points() <=> $b->points() } @$drivers;

    return \@sortedDrivers;
}

sub orderTeams {
    my ($self, $teams) = @_;

    my @sortedTeams = sort {$b->points() <=> $a->points() } @$teams;

    return \@sortedTeams;
}

sub saveToFile {
    my ($self, $drivers) = @_;

    open my $fh, '>', 'resources/result.csv';

    # print $fh $_->name(), $_->points() foreach (@$drivers);
    foreach my $driver (@$drivers){
        warn 'id 1 ' if $driver->id() == 1;
        # unless = !if
        print $fh $driver->name().','.$driver->points()."\n";
    }
    close $fh;
}
1;
