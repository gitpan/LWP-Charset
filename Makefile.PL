use inc::Module::Install;

name            ('LWP-Charset');
abstract        ('Retrive charset infromation from HTTP::Response object.');
author          ('Kang-min Liu <gugod@gugod.org>');
license         ('perl');
version_from    ('lib/LWP/Charset.pm');
requires        ( LWP::UserAgent => 0);
build_requires  ('Test::More');

&auto_install;
&WriteAll;
