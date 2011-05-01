#!/usr/bin/env perl

use strict;
use warnings;
use lib qw(lib);

use Path::Class;
use Plack::App::TemplateToolkit;
use Plack::Builder;
use Plack::Middleware::ErrorDocument;
use Plack::Middleware::Static;

my $base   = dir( 'base' )->stringify();
my $custom = dir( 'custom' )->stringify();

# Create our TT app, specifying the root and file extensions
my $app = Plack::App::TemplateToolkit->new(
    root => [ ( $custom, $base ) ],    # required
    # extension => '.html',          # optional
)->to_app;

# Plack::Middleware::Deflater might be good to use here

$app = Plack::Middleware::ErrorDocument->wrap( $app,
    404 => "$base/page_not_found.html", );

# Binary files can be served directly
$app = Plack::Middleware::Static->wrap(
    $app,
    path => qr{[gif|png|jpg|swf|ico|mov|mp3|pdf|js|css]$},
    root => $base
);

$app = Plack::Middleware::Static->wrap(
    $app,
    path         => qr{[gif|png|jpg|swf|ico|mov|mp3|pdf|js|css]$},
    root         => $custom,
    pass_through => 1, # So the 'base' static can pick it up
);


return builder {
    $app;
}
