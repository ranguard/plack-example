use ExtUtils::MakeMaker;

WriteMakefile(
    'ABSTRACT'	=> 'Test',
    'AUTHOR'	=> 'Leo Lapworth',
    'LICENSE'	=> 'perl',
    'NAME'	=> 'Leo::TEst',
    'PREREQ_PM'	=> {
		    'Plack::App::TemplateToolkit' => '0.07',
		    'Plack' => '9999.04',
		    'Test::More' => '0.1',
		   },
);

