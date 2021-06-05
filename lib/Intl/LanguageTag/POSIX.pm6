unit class LanguageTag::POSIX;
    use Intl::LanguageTaggish;
    also does LanguageTaggish;

has $.language; #= The language of the tag
has $.region;   #= The region of the tag
has $.encoding; #= The encoding for the text
has $.modifier; #= A modifier adjusting some aspect of the language
    # Handling multiple modifiers: https://www.gnu.org/software/libc/manual/html_node/Locale-Names.html

method Str {
    ~ $!language
    ~ ("_$!region"   if $!region  )
    ~ (".$!encoding" if $!encoding)
    ~ ("@$!modifier" if $!modifier)
}

# For future use https://wiki.openoffice.org/wiki/LocaleMapping
# Note: http://std.dkuug.dk/cultreg/registrations/chreg.htm
#       The list below is currently incomplete
my constant %encodings = <
    ISO-8859-1     iso88591
    ISO-8859-2     iso88592
    ISO-8859-7     iso88597
    ISO-8859-8     iso88598
    ISO-8859-9     iso88599
    ISO-8859-13    iso8859d
    TIS-620        tis620
    eucJP          eucjp
    SJIS           sjis
    eucKR          euckr
    UTF-8          utf8
    UTF-16         utf16
>;

method bcp47 {
    # Needs to account for modifiers, etc later
    $!language ~ ("-$!region" if $!region) ~ "-x-encoding-" ~ %encodings{$!encoding}
}

# Encodings here: http://std.dkuug.dk/cultreg/registrations/chreg.htm
# This alias list comes from `glibc/intl/locale.alias`
my %alias = <
    bokmal		     nb_NO.ISO-8859-1
    bokmål		     nb_NO.ISO-8859-1
    catalan		     ca_ES.ISO-8859-1
    croatian	     hr_HR.ISO-8859-2
    czech		     cs_CZ.ISO-8859-2
    danish           da_DK.ISO-8859-1
    dansk		     da_DK.ISO-8859-1
    deutsch		     de_DE.ISO-8859-1
    dutch		     nl_NL.ISO-8859-1
    eesti		     et_EE.ISO-8859-1
    english		     en_US.ISO-8859-1
    estonian	     et_EE.ISO-8859-1
    finnish          fi_FI.ISO-8859-1
    français	     fr_FR.ISO-8859-1
    french		     fr_FR.ISO-8859-1
    galego		     gl_ES.ISO-8859-1
    galician	     gl_ES.ISO-8859-1
    german		     de_DE.ISO-8859-1
    greek            el_GR.ISO-8859-7
    hebrew           he_IL.ISO-8859-8
    hrvatski	     hr_HR.ISO-8859-2
    hungarian        hu_HU.ISO-8859-2
    icelandic        is_IS.ISO-8859-1
    italian          it_IT.ISO-8859-1
    japanese	     ja_JP.eucJP
    japanese.euc	 ja_JP.eucJP
    ja_JP		     ja_JP.eucJP
    ja_JP.ujis	     ja_JP.eucJP
    japanese.sjis	 ja_JP.SJIS
    korean		     ko_KR.eucKR
    korean.euc 	     ko_KR.eucKR
    ko_KR		     ko_KR.eucKR
    lithuanian       lt_LT.ISO-8859-13
    no_NO		     nb_NO.ISO-8859-1
    no_NO.ISO-8859-1 nb_NO.ISO-8859-1
    norwegian        nb_NO.ISO-8859-1
    nynorsk		     nn_NO.ISO-8859-1
    polish           pl_PL.ISO-8859-2
    portuguese       pt_PT.ISO-8859-1
    romanian         ro_RO.ISO-8859-2
    russian          ru_RU.ISO-8859-5
    slovak           sk_SK.ISO-8859-2
    slovene          sl_SI.ISO-8859-2
    slovenian        sl_SI.ISO-8859-2
    spanish          es_ES.ISO-8859-1
    swedish          sv_SE.ISO-8859-1
    thai		     th_TH.TIS-620
    turkish          tr_TR.ISO-8859-9
>;

    multi method new (:$language, :$region, :$encoding, :$modifier) {
        self.bless: :$language, :$region, :$encoding, :$modifier
    }
    multi method new (Str $s) {
        my token valid { <[a..zA..Z0..9-]> };
        (%alias{$s}:exists ?? %alias{$s} !! $s)
            ~~ /
        $<language>  = [<valid>+]
        ['_'
        $<region>    = [<valid>+]]?
        ['.'
        $<encoding>  = [<valid>+]]?
        ['@'
        $<modifier>  = [<valid>+]]?
        ';'?
        /;

        self.new:
            language => ~ $<language>,
            region   => ~ ($<region>   // ''),
            encoding => ~ ($<encoding> // ''),
            modifier => ~ ($<modifier> // ''),
    }
    method new-from-bcp47 (Str $s) {
        ... #`[not yet implemented]
    }

multi method COERCE(LanguageTaggish:D $s --> LanguageTag::POSIX) is default { self.new: $s.bcp47 }
multi method COERCE(Str()             $s)            { self.new: $s       }

#`<<< old coercion priorities
once LanguageTag::POSIX.REGISTER:
    LanguageTag::POSIX, # Our class
    25,       # Priority level (fairly low)
              # - The @ and . aren't common
              # - Language/region are very greedy
    { so $^tag ~~ /
        <[a..zA..Z-]> ** 2..*
            ['_'
        <[a..zA..Z-]> ** 2..*]
            ['.'
        <[a..zA..Z-]>+ ]
            ['@'
        <[a..zA..Z-]>+ ]
            ';'?
        /
    },
>>>
