
use ExtUtils::MakeMaker;

WriteMakefile(
    AUTHOR              => 'Kang-min Liu (gugod@gugod.org)',
    ABSTRACT            => 'Retrive charset infromation from HTTP::Response object.',
    NAME                => 'LWP::Charset',
    VERSION_FROM        => 'Charset.pm',
    DISTNAME            => 'LWP-Charset',
    EXE_FILES		=> [ 'lwp-charset' ],
    PREREQ_PM           => {
        'LWP::UserAgent'   => '0',
    },
    dist                => {
        COMPRESS        => 'gzip -9',
        SUFFIX          => '.gz',
    },
);
