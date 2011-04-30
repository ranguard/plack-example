use ExtUtils::MakeMaker;

WriteMakefile(
    'ABSTRACT'  => 'Test',
    'AUTHOR'    => 'Leo Lapworth',
    'LICENSE'   => 'perl',
    'NAME'      => 'Leo::Test',
    'PREREQ_PM' => {
        'Path::Class'                 => 0,
        'Plack::App::TemplateToolkit' => '0.07',
        'Plack'                       => '9999.04',
        'Test::More'                  => '0.1',
    },
);

