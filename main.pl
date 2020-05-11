#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;

use Entity::Driver;
use Repo::DriverRepo;
use Utils;

# my $driver = Entity::Driver->new( name => 'Alonso', age => 23, points => 100);

my $repo = Repo::DriverRepo->new();
warn Dumper(Utils::read_conf());
