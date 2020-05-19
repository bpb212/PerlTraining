#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;

use Entity::Driver;
use Entity::Team;
use Repo::DriverRepo;

# my $driver = Entity::Driver->new(
#                 id => 2,
#                 teamID => 3,
#                 name => 'Alonso', age => 23, points => 100);
# warn $driver->name();
# warn Dumper($driver->points());
# warn Dumper($driver->age());
# warn Dumper($driver);
#
# my $team = Entity::Team->new( id => 3, name => 'team1');
# warn Dumper($team);
my $repo = Repo::DriverRepo->new();
$repo->orderDivers( $repo->getDrivers() );
