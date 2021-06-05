use Intl::LanguageTag::POSIX;
use Intl::LanguageTaggish;
use Test;

is LanguageTag::POSIX.new('english').bcp47, 'en-US-x-encoding-iso88591';
is LanguageTag::POSIX.new('thai'   ).bcp47, 'th-TH-x-encoding-tis620';
done-testing;
