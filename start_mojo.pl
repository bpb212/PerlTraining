#!/usr/bin/perl

use Mojolicious::Lite;

use Repo::DriverRepo;
use Data::Dumper;

use Repo::UserRepo;
use LWP::UserAgent;
use HTTP::Request;
use Entity::User;


get '/' => sub {
    my $c = shift;

    my $repo = new Repo::DriverRepo();
    my $drivers = $repo->getDrivers();
    $drivers = $repo->orderDivers($drivers);

    my $teams = $repo->getTeams();
    $teams = $repo->getOrderedTeams($teams, $drivers);

    $c->render(template => 'tables', riders => $drivers, teams => $teams);
};

get '/letters' => sub{
    my $c = shift;

    my $repo = new Repo::DriverRepo();
    my $drivers = $repo->getDrivers();

    my %letters;

    foreach my $driver (@$drivers){
        my @driverLetters = split('', $driver->name());
        foreach my $letter (@driverLetters){
            if(! $letter =~ /[a-z]/i){
                next;
            }

            if($letters{$letter}){
                $letters{$letter} ++;
            } else {
                $letters{$letter} = 1;
            }
        }
    }

    my $teams = $repo->getTeams();
    foreach my $team (@$teams){
        my @teamLetters = split('', $team->name());
        foreach my $letter (@teamLetters){
            if(! $letter =~ /[a-z]/i){
                next;
            }

            if($letters{$letter}){
                $letters{$letter} ++;
            } else {
                $letters{$letter} = 1;
            }
        }
    }

    $c->render(template => 'letters', letters => \%letters);
};

get '/api/tryone' => sub {
    my $c = shift;

    my $userRepo = Repo::UserRepo->new();

    $userRepo->fetchAPI();
    warn Dumper($userRepo);


    $c->render(template => 'api', users => $userRepo->users());
};

app->start;

__DATA__

@@ api.html.ep
<h2> API </h2>
JSON : <BR>
% for my $user (@$users) {
    <%= $user->name() %>| <%= $user->username() %> | <%= $user->id() %> | <%= $user->email() %> <BR>
% }

@@ tables.html.ep
the drivers are :
<BR>
<BR>nume|puncte|id<BR>
% for my $i (@$riders) {
    <%= $i->name() %>| <%= $i->points() %> | <%= $i->id() %> <BR>
% }

<BR>
and the teams are :
<BR>
<BR>nume|puncte<BR>
% for my $i (@$teams) {
    <%= $i->name() %>| <%= $i->points() %> <BR>
% }
<BR>
<BR>
<script>
function myFunction() {
  location.replace("http://localhost:3000/letters");
}
function changeToAPI() {
  location.replace("http://localhost:3000/api/tryone");
}
</script>
<button onclick="myFunction()"> Letters </button>
<button onclick="changeToAPI()"> API </button>


@@ letters.html.ep
<h2> LETTERS </h2>
% for my $key (keys %$letters) {
    <%= $key %> = <%= $letters->{$key} %> <BR>
% }
