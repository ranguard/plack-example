#!/usr/bin/env perl

use strict;
use warnings;

use Path::Class;
use Plack::Middleware::TemplateToolkit;
use Plack::Builder;
use Plack::Middleware::ErrorDocument;
use Plack::Middleware::Static;

my $root = '../multiple_roots/';
my $base_root = "$root/base";
my $custom_root = "$root/custom";

# Create our TT app, specifying the root and file extensions
my $app = Plack::Middleware::TemplateToolkit->new(
    INCLUDE_PATH => [ ( $custom_root, $base_root ) ],    # required
)->to_app;

# Plack::Middleware::Deflater might be good to use here

$app = Plack::Middleware::ErrorDocument->wrap( $app,
    404 => "$base_root/page_not_found.html", );

# Binary files can be served directly
$app = Plack::Middleware::Static->wrap(
    $app,
    path => qr{[gif|png|jpg|swf|ico|mov|mp3|pdf|js|css]$},
    root => $base_root
);

$app = Plack::Middleware::Static->wrap(
    $app,
    path         => qr{[gif|png|jpg|swf|ico|mov|mp3|pdf|js|css]$},
    root         => $custom_root,
    pass_through => 1, # So the 'base' static can pick it up
);

return builder {
	enable "Debug";
    $app;
}
