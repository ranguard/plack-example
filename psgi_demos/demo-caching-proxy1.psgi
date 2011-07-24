use Plack::Builder;
use Plack::App::Proxy;
use Plack::Middleware::Cache;

my $app
    = Plack::App::Proxy->new( remote => "http://london.pm.org/" )->to_app;

builder {
    enable "Cache",
        match_url => '^/.*',               # everything
        cache_dir => '/tmp/plack-cache';
    $app;
};

