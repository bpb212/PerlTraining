#!/usr/bin/perl

use Mojolicious::Lite;


get '/' => sub($c) {
    my $c = shift;



    $c->render(template => 'tables', riders => "rd", teams => "tm");
};

app->start;

__DATA__

@@ tables.html.ep
the drivers are :
<BR>
<%= $riders %>

<BR>
and the teams are :
<BR>
<%= $teams %>
