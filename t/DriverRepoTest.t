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

done_testing();
