#!/usr/bin/env perl

# NYTProf panel demo

use strict;
use warnings;
use DateTime;
use Plack::Builder;

my $body = join '', <DATA>;

my $app = sub {
    my $self = shift;

    [ 200, [ 'Content-Type' => 'text/html' ], [$body] ];
};

builder {
    enable 'Debug', panels => [ [ 'Profiler::NYTProf' ] ];
    $app;
};

__DATA__
<!doctype html>
<html>

<head>
 <title>Profiling</title>
</head>

<body>
 <h1>Hello World - where am I slow?</h1>
</body>

</html>
