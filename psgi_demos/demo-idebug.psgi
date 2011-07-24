#!/usr/bin/env perl

# Interactive Debugger demo

use strict;
use warnings;
use Plack::Builder;

my $body = join '', <DATA>;

my $app = sub {
    my $self = shift;
    
    my $foo = 'bar';

    # Do whatever you want, but return PSGI-compatible response...
    # ...or die.

    # See http://search.cpan.org/~miyagawa/PSGI/PSGI.pod

    die "oops" if $foo eq 'bar';

    [200, ['Content-Type' => 'text/html'], [ $body ]];
};

builder {
    # Enable Interactive debugging
    enable "InteractiveDebugger";

    # Make Plack middleware render some static for you
    enable "Static",
      path => qr{\.(?:js|css|jpe?g|gif|ico|png|html?|swf|txt)$},
      root => './htdocs';

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