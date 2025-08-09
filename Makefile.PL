#! perl

use ExtUtils::MakeMaker;

#--- Original or revised phrtsd?
my $OPT = $ARGV[0];
my $def = q{};
$def = '-DPHRTSD_ORIG'
  if $OPT =~ /phrtsd_orig/i;

WriteMakefile(
    'NAME'         => 'Math::Random',
    'VERSION_FROM' => 'Random.pm',
    'OBJECT'       => '$(O_FILES)',
    'LIBS'         => ['-lm'],
    'DEFINE'       => $def,
    'TEST_REQUIRES' => {
        'Test2::V0' => 0,
    },
);

