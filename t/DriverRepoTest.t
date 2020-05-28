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
    ok($sortedDrivers[2]->name() eq $driver2->name(), "third driver is driver1");

    $sortedDriversRef = $repo->orderDivers([]);

    is(scalar @$sortedDriversRef, 0, "no driver returned");
}

{
=head getOrderedTeams
    parameters -> arrayref of Entity::Team
    returns arrayref of ordered Entity::Team
=cut
    my @teams;
    my $team1 = new Entity::Team( id => 1, name => "team1" );
    my $team2 = new Entity::Team( id => 2, name => "team2" );

    my @drivers;
    my $driver1 = new Entity::Driver(points => 10, name => 'second', teamID => 1);
    my $driver2 = new Entity::Driver(points => 15, name => 'third', teamID => 1);
    my $driver3 = new Entity::Driver(points => 5, name => 'first', teamID => 2);

    push @drivers, $driver1, $driver2, $driver3;
    push @teams, $team1, $team2;

    my $result = $repo->getOrderedTeams(\@teams, \@drivers);

    ok($result->[0]->name() eq $team1->name(), "team 1 is the first");
    is($result->[-1]->name(), $team2->name(), "team 2 is the last");

    my $t1Points = $driver1->points() + $driver2->points();
    is($result->[0]->points(), $t1Points , "team 1 has $t1Points points");
    is($result->[1]->points(), $driver3->points() , "team 2 has ".$driver3->points()." points");

    is_deeply($result, \@teams, "result is deeply");

}

done_testing();
