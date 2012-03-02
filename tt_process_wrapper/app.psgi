use strict;
use Plack::Builder;

use Plack::Middleware::TemplateToolkit;


my $app = Plack::Middleware::TemplateToolkit->new(
    root => 'root',    # required
    PROCESS => 'wrappers/master.html',
)->to_app;


return builder {
enable 'Debug';
enable 'Debug::TemplateToolkit'; 
    $app;
}

