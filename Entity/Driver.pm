package Entity::Driver;

use Moose;
# Moose turns on automatically strict and warnings;

has 'id' => (
    is => 'ro',
    isa => 'Int'
);

has 'teamID' => (
    is => 'rw',
    isa => 'Int'
);

has 'name' => (
    is => 'rw',
    isa => 'Str'
);

has 'age' => (
    is => 'ro',
    isa => 'Int'
);

has 'points' => (
    is => 'rw',
    isa => 'Int'
);

1;
