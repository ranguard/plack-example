#!/usr/bin/env perl

# Debugger demo

use strict;
use warnings;
use Plack::Builder;

my $body = join '', <DATA>;

my $app = sub {
    my $self = shift;

    return [200, ['Content-Type' => 'text/html'], [ $body ]];
};

builder {
    # Precious debug info. Right on your page!
    enable 'Debug';

    # Make Plack middleware render some static for you
    enable "ServerStatus::Lite",
        path => '/server-status',
        allow => [ '127.0.0.1'],
        scoreboard => '/tmp/score';

    # Let Plack care about length header
    enable "ContentLength";

    $app;
}

__DATA__
<!doctype html>
<html>

<head>
 <title>Few words about Plack and PSGI</title>
</head>

<body>
 <h1>Hello World!</h1>
</body>

</html>