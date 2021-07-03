use Intl::LanguageTag::POSIX;
use Intl::LanguageTaggish;
use Test;

is LanguageTag::POSIX.new('english').bcp47,
   'en-US-x-encoding-iso-8859-1',
   'Default English interpreted correctly';
is LanguageTag::POSIX.new('thai').bcp47,
   'th-TH-x-encoding-tis-620',
   'Default Thai interpreted correctly';

is LanguageTag::POSIX.new-from-bcp47('en-US-x-encoding-utf8').Str,
   'en_US.UTF-8',
   'Correctly preserve encoding information from BCP-47';
is LanguageTag::POSIX.new-from-bcp47('ca-ES-valencia-x-encoding-iso-8859-1').Str,
    'ca_ES.ISO_8859-1@valencia',
    'Correctly preserve variant information from BCP-47';
is LanguageTag::POSIX.new-from-bcp47('sr-Cyrl-RS').Str,
    'sr_RS@cyrillic',
    'Correctly preserve script information from BCP-47';

done-testing;
