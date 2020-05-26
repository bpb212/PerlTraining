package Entity::Team;

use Moose;

has 'id' => (
    is => 'ro',
    isa => 'Int',
    required => 1
);

has 'name' => (
    is => 'rw',
    isa => 'Str'
);

has 'points' => (
    is => 'rw',
    isa => 'Int'
);

1;
