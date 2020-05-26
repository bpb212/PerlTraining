use strict;
use warnings;

use Repo::DriverRepo;
use Entity::Driver;
use Entity::Team;

use Test::Simple;
use Test::More;
#use Test::MockModule;
use Test::Exception;
use Test::Warn;

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
    ok($sortedDrivers[2]->name() eq $driver2->name(), "third driver is driver1");

    $sortedDriversRef = $repo->orderDivers([]);

    is(scalar @$sortedDriversRef, 0, "no driver returned");

}


{ # test orderTeams
    my @drivers;
    my $driver1 = new Entity::Driver(points => 10, name => 'second', teamID => '1');
    my $driver2 = new Entity::Driver(points => 15, name => 'third', teamID => '3');
    my $driver3 = new Entity::Driver(points => 500, name => 'first', teamID => '3');
    my $driver4 = new Entity::Driver(points => 100, name => 'unu', teamID => '2');
    my $driver5 = new Entity::Driver(points => 7, name => 'altul', teamID => '1');

    my @teams;
    my $team1 = new Entity::Team( id => '1', points => '17');
    my $team2 = new Entity::Team( id => '2', points => '100');
    my $team3 = new Entity::Team( id => '3', points => '515');

    push @drivers, $driver1, $driver2, $driver3, $driver4, $driver5;
    push @teams, $team1, $team2, $team3;

    my $pointsRef = $repo->getPointsByTeam(\@drivers);
    my @points = @$pointsRef;

    ok($points[1] eq $team1->points(), "team1 points ok ");
    ok($points[2] eq $team2->points(), "team2 points ok ");
    ok($points[3] eq $team3->points(), "team3 points ok ");

    my $TeamsRef = $repo->orderTeams(\@teams);
    my @sortedTeams = @$TeamsRef;

    ok($sortedTeams[0]->id() eq $team3->id(), "first team is team3");
    ok($sortedTeams[2]->id() eq $team1->id(), "last team is team1");

}
done_testing();
