use strict;
use ExtUtils::MakeMaker;
use Config;
use File::Spec;

## Uncomment if you wish to alter rtfparser.l
#my $LEX = 'flex';
#
#FINDLEX:
#for my $lex (qw(flex lex)){
#  for my $bin (split(/$Config::Config{path_sep}/, $ENV{PATH})){
#    my $path = MM->catfile($bin, $lex);
#    if(MM->maybe_command($path)){
#      $LEX = $path;
#      last FINDLEX;
#    }
#  }
#}
#
#$LEX = ExtUtils::MakeMaker::prompt("Where is your lex program", $LEX);
#die "This module requires lex!\n" unless($LEX);

WriteMakefile(
    NAME                => 'RTF::HTMLConverter',
    VERSION_FROM        => 'HTMLConverter.pm',
    INC                 => ' -I. ',
    PM                  => { 
              'Lexer.pm'         => File::Spec->catfile('$(INST_LIBDIR)', 'Lexer.pm'),
              'HTMLConverter.pm' => File::Spec->catfile('$(INST_LIBDIR)', 'HTMLConverter.pm'),
                           },
    PREREQ_PM           => {
                             'Error'        => 0,
                             'Encode'       => 0,
                           },
    OBJECT              => 'rtfparser.o Lexer.o',
    clean               => { FILES          => 'Lexer.pm' },
## Uncomment if you wish to alter rtfparser.l
#    clean               => { FILES          => 'rtfparser.c Lexer.pm' },
);

## Uncomment if you wish to alter rtfparser.l
#sub MY::postamble {
#qq[rtfparser.c: rtfparser.l
#\t$LEX -ortfparser.c rtfparser.l
#
#];
#}

## Maybe this is not the best way, but I have not found anything better.
sub MY::post_constants {
  return 'INST_AUTODIR     = '.File::Spec->catdir('$(INST_LIB)', qw(auto RTF Lexer))."\n".
         'INST_ARCHAUTODIR = '.File::Spec->catdir('$(INST_ARCHLIB)', qw(auto RTF Lexer))."\n\n".
         'INST_STATIC  = '.File::Spec->catfile('$(INST_ARCHAUTODIR)', 'Lexer$(LIB_EXT)')."\n".
         'INST_DYNAMIC = '.File::Spec->catfile('$(INST_ARCHAUTODIR)', 'Lexer.$(DLEXT)')."\n".
         'INST_BOOT    = '.File::Spec->catfile('$(INST_ARCHAUTODIR)', 'Lexer.bs');
}

