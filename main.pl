#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;

use Entity::Driver;
use Entity::Team;
use Repo::DriverRepo;

my $driver = Entity::Driver->new(
                id => 2,
                teamID => 3,
                name => 'Alonso', age => 23, points => 100);
# warn $driver->name();
# warn Dumper($driver->points());
# warn Dumper($driver->age());
# warn Dumper($driver);


my $repo = new Repo::DriverRepo();
my $teamsArr = $repo->getTeams();
my $drivers = $self->getDrivers();

warn Dumper($repo->getOrderedTeams($teamsArr, $drivers));
