use strict;
use warnings;

use Repo::DriverRepo;
use Entity::Driver;
use Entity::Team;

use Test::Simple;
use Test::More;

my $repo = Repo::DriverRepo->new();
{ # test orderDivers
    my @drivers;
    my $driver1 = new Entity::Driver(points => 10, name => 'second');
    my $driver2 = new Entity::Driver(points => 15, name => 'third');
    my $driver3 = new Entity::Driver(points => 5, name => 'first');

    push @drivers, $driver1, $driver2, $driver3;

    my $sortedDriversRef = $repo->orderDivers(\@drivers);
    my @sortedDrivers = @$sortedDriversRef;

    ok($sortedDrivers[0]->name() eq $driver3->name(), "first driver is driver3" );
    ok($sortedDrivers[1]->name() eq $driver1->name(), "second driver is driver1");
    ok($sortedDrivers[2]->name() eq $driver2->name(), "third driver is driver2");

    $sortedDriversRef = $repo->orderDivers([]);

    is(scalar @$sortedDriversRef, 0, "no driver returned");
}

{ # test orderTeams
    my @teams;
    my $team1 = new Entity::Team(id => 1, name => 'third', points => 100);
    my $team2 = new Entity::Team(id => 2, name => 'first', points => 200);
    my $team3 = new Entity::Team(id => 3, name => 'second', points => 150);

    push @teams, $team1, $team2, $team3;

    my $sortedTeamsRef = $repo->orderTeams(\@teams);
    my @sortedTeams = @$sortedTeamsRef;

    ok($sortedTeams[0]->name() eq $team2->name(), "first team is team2");
    ok($sortedTeams[1]->name() eq $team3->name(), "second team is team3");
    ok($sortedTeams[2]->name() eq $team1->name(), "third team is team1");

    $sortedTeamsRef = $repo->orderTeams([]);

    is(scalar @$sortedTeamsRef, 0, "no team returned");
}

done_testing();
