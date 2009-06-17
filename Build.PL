use Module::Build;

my $build = Module::Build->new(
    # dist_version_from  => 'lib/App/LexicalVarReplace.pm',
    dist_version       => 0.1,
    module_name        => 'App::LexicalVarReplace',
    license            => 'perl',
    create_readme      => 1,
    create_makefile_pl => 'passthrough',
    script_files       => [qw(script/vim_lexvarrepl)],
    requires           => {
        'perl'            => '5.010',
        'MooseX::Declare' => 0,
        'PPI'             => 0,
        'Padre::PPI'      => 0.05,
    },
    build_requires => { 'Test::Differences' => 0, },
);

$build->create_build_script;

