use strict;
use warnings;

# When trying to debug a FireFox redirect issue
# this was useful - it also shows how to write an inline middleware 

use Plack::Builder;
use Plack::Util;
use Data::Dumper;
local $Data::Dumper::Sortkeys = 1;
 
my $app = ....;

# Add middleware / anything else...

$app = builder {

    enable sub {
        my $app = shift;
        sub {
            my $env = shift;

            # See what is comming from the browser
            warn Dumper($env);

            # Pass through all other middleware/app code
            my $res = $app->($env);

            # Check the response header
            my $ct = Plack::Util::header_get($res->[1],'Content-Type');
            # Only warn if the content type is text/html
            warn Dumper($res) if $ct =~ /html/i;
            
            return $res;
        };
    };
    $app;
};

# return
$app;

