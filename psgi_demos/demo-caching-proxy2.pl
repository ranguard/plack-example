use feature qw(say);

use Plack::Builder;
use Plack::App::Proxy;
use Plack::Middleware::Cache;

use LWP::Simple;
use LWP::Protocol::PSGI;

my $app
    = Plack::App::Proxy->new( remote => "http://london.pm.org/" )->to_app;

$app = builder {
    enable "Cache",
        match_url => '^/.*',               # everything
        cache_dir => '/tmp/plack-cache2';
    $app;
};

# Hijack Any LWP::Useragent requests
LWP::Protocol::PSGI->register($app);

my $res = get("http://london.pm.org/");
say '\o/' if $res =~ /London Perl Mongers/;
