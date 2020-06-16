package Repo::UserRepo;

use Moose;

use Entity::User;

use HTTP::Request;
use LWP::UserAgent;
use Data::Dumper;
use JSON;

has 'users' => (
    isa => 'ArrayRef',
    is => 'rw'
);

sub fetchAPI{
    my $self = shift;

    my @users;
    my $request = HTTP::Request->new(GET => 'http://jsonplaceholder.typicode.com/users');
    my $ua = LWP::UserAgent->new;
    my $response = $ua->request($request);

    if($response->is_success){
        warn Dumper(JSON::from_json($response->content()));
        my $responseContent = JSON::from_json($response->content());
        foreach my $item (@$responseContent){
            my $user = Entity::User->new(
                    email => $item->{email},
                    name => $item->{name},
                    phone => $item->{phone},
                    username => $item->{username},
                    id => $item->{id},
                    website => $item->{website}
                );
            push @users, $user;
        }
    }
    else {
        warn "I failed this city ";
    }

    $self->users(\@users);
}

1;
