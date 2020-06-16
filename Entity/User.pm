package Entity::User;

use Moose;

has 'email' => (
    is => 'rw',
    isa => 'Str'
);

has 'name' => (
    is => 'rw',
    isa => 'Str'
);

has 'phone' => (
    is => 'rw',
    isa => 'Str'
);

has 'username' => (
    is => 'rw',
    isa => 'Str'
);

has 'website' => (
    is => 'rw',
    isa => 'Str'
);

has 'id' => (
    is => 'rw',
    isa => 'Int'
);

1;
