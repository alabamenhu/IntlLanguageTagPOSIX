unit class LanguageTag::POSIX;
    use Intl::LanguageTaggish;
    also does LanguageTaggish;

    # Notes for further development
    #   Handling multiple modifiers:
    #      https://www.gnu.org/software/libc/manual/html_node/Locale-Names.html
    #   Converting
    #      https://wiki.openoffice.org/wiki/LocaleMapping

has $.language; #= The language of the tag
has $.region;   #= The region of the tag
has $.encoding; #= The encoding for the text
has $.modifier; #= A modifier adjusting some aspect of the language

method Str {
    ~ $!language
    ~ ("_$!region"   if $!region  )
    ~ (".$!encoding" if $!encoding)
    ~ ("@$!modifier" if $!modifier)
}

# The initial set of encodings are the ones used in the OpenOffice locale mapping.
# After the first fully blank line, the encodings come from
#    L<http://std.dkuug.dk/cultreg/registrations/chreg.htm>
# and use the following general pattern for mapping the names
#   - Agency name as one subtag (ansi, iso, etc)
#   - Each subsequent subtag is an alpha group or a digit group
# In three cases, tags are not possible:
#   - MACEDONIAN became macedona
#   - MACINTOSH  became macntosh
#   - INVARIANT  became invary
my constant %encodings = <
    ISO-8859-1              iso-8859-1
    ISO-8859-2              iso-8859-2
    ISO-8859-7              iso-8859-7
    ISO-8859-8              iso-8859-8
    ISO-8859-9              iso-8859-9
    ISO-8859-13             iso-8859-13
    TIS-620                 tis-620
    eucJP                   euc-jp
    SJIS                    sjis
    eucKR                   euc-kr
    UTF-8                   utf8
    UTF-16                  utf16

    1026                    1026
    1047                    1047
    437                     437
    500                     500
    500V1                   500-v-1
    850                     850
    851                     851
    852                     852
    855                     855
    857                     857
    860                     860
    861                     861
    862                     862
    863                     863
    865                     865
    869                     869
    904                     904
    ANSI_X3.110-1983        ansi-x-3-110-1983
    ANSI_X3.4-1968          ansi-x-3-4-1968
    ANSI_X3.4-1986          ansi-x-3-4-1986
    ARABIC                  arabic
    ARABIC7                 arabic-7
    ASCII                   ascii
    ASMO-708                asmo-708
    ASMO_449                asmo-449
    BALTIC                  baltic
    BS_4730                 bs-4730
    BS_VIEWDATA             bs-viewdata
    CA                      ca
    CN                      cn
    CP-AR                   cp-ar
    CP-GR                   cp-gr
    CP-HU                   cp-hu
    CP-IS                   cp-is
    CP037                   cp-037
    CP038                   cp-038
    CP1004                  cp-1004
    CP1026                  cp-1026
    CP1047                  cp-1047
    CP1250                  cp-1250
    CP1251                  cp-1251
    CP1252                  cp-1252
    CP1253                  cp-1253
    CP1254                  cp-1254
    CP1255                  cp-1255
    CP1256                  cp-1256
    CP1257                  cp-1257
    CP273                   cp-273
    CP274                   cp-274
    CP275                   cp-275
    CP278                   cp-278
    CP280                   cp-280
    CP281                   cp-281
    CP284                   cp-284
    CP285                   cp-285
    CP290                   cp-290
    CP297                   cp-297
    CP367                   cp-367
    CP420                   cp-420
    CP423                   cp-423
    CP424                   cp-424
    CP437                   cp-437
    CP500                   cp-500
    CP819                   cp-819
    CP850                   cp-850
    CP851                   cp-851
    CP852                   cp-852
    CP855                   cp-855
    CP857                   cp-857
    CP860                   cp-860
    CP861                   cp-861
    CP862                   cp-862
    CP863                   cp-863
    CP864                   cp-864
    CP865                   cp-865
    CP868                   cp-868
    CP869                   cp-869
    CP870                   cp-870
    CP871                   cp-871
    CP875                   cp-875
    CP880                   cp-880
    CP891                   cp-891
    CP903                   cp-903
    CP904                   cp-904
    CP905                   cp-905
    CP918                   cp-918
    CSA7-1                  csa-7-1
    CSA7-2                  csa-7-2
    CSA_T500-1983           csa-t-500-1983
    CSA_Z243.4-1985-1       csa-z-243-4-1985-1
    CSA_Z243.4-1985-2       csa-z-243-4-1985-2
    CSA_Z243.4-1985-GR      csa-z-243-4-1985-gr
    CSN_369103              csn-369103
    CUBA                    cuba
    CWI                     cwi
    CWI-2                   cwi-2
    CYRILLIC                cyrillic
    DE                      de
    DEC                     dec
    DEC-MCS                 dec-mcs
    DIN_66003               din-66003
    DK                      dk
    DS2089                  ds-2089
    DS_2089                 ds-2089
    E13B                    e-13-b
    EBCDIC-AT-DE            ebcdic-at-de
    EBCDIC-AT-DE-A          ebcdic-at-de-a
    EBCDIC-BE               ebcdic-be
    EBCDIC-BR               ebcdic-br
    EBCDIC-CA-FR            ebcdic-ca-fr
    EBCDIC-CP-AR1           ebcdic-cp-ar-1
    EBCDIC-CP-AR2           ebcdic-cp-ar-2
    EBCDIC-CP-BE            ebcdic-cp-be
    EBCDIC-CP-CA            ebcdic-cp-ca
    EBCDIC-CP-CH            ebcdic-cp-ch
    EBCDIC-CP-DK            ebcdic-cp-dk
    EBCDIC-CP-ES            ebcdic-cp-es
    EBCDIC-CP-FI            ebcdic-cp-fi
    EBCDIC-CP-FR            ebcdic-cp-fr
    EBCDIC-CP-GB            ebcdic-cp-gb
    EBCDIC-CP-GR            ebcdic-cp-gr
    EBCDIC-CP-HE            ebcdic-cp-he
    EBCDIC-CP-IS            ebcdic-cp-is
    EBCDIC-CP-IT            ebcdic-cp-it
    EBCDIC-CP-NL            ebcdic-cp-nl
    EBCDIC-CP-NO            ebcdic-cp-no
    EBCDIC-CP-ROECE         ebcdic-cp-roece
    EBCDIC-CP-SE            ebcdic-cp-se
    EBCDIC-CP-TR            ebcdic-cp-tr
    EBCDIC-CP-US            ebcdic-cp-us
    EBCDIC-CP-WT            ebcdic-cp-wt
    EBCDIC-CP-YU            ebcdic-cp-yu
    EBCDIC-CYRILLIC         ebcdic-cyrillic
    EBCDIC-DK-NO            ebcdic-dk-no
    EBCDIC-DK-NO-A          ebcdic-dk-no-a
    EBCDIC-ES               ebcdic-es
    EBCDIC-ES-A             ebcdic-es-a
    EBCDIC-ES-S             ebcdic-es-s
    EBCDIC-FI-SE            ebcdic-fi-se
    EBCDIC-FI-SE-A          ebcdic-fi-se-a
    EBCDIC-FR               ebcdic-fr
    EBCDIC-GREEK            ebcdic-greek
    EBCDIC-INT              ebcdic-int
    EBCDIC-INT1             ebcdic-int-1
    EBCDIC-IS-FRISS         ebcdic-is-friss
    EBCDIC-IT               ebcdic-it
    EBCDIC-JP-E             ebcdic-jp-e
    EBCDIC-JP-KANA          ebcdic-jp-kana
    EBCDIC-PT               ebcdic-pt
    EBCDIC-UK               ebcdic-uk
    EBCDIC-US               ebcdic-us
    ECMA-114                ecma-114
    ECMA-118                ecma-118
    ECMA-CYRILLIC           ecma-cyrillic
    ELOT_928                elot-928
    ES                      es
    ES2                     es-2
    FI                      fi
    FR                      fr
    FRISS                   friss
    GB                      gb
    GB_1988-80              gb-1988-80
    GOST_19768-74           gost-19768-74
    GOST_19768-87           gost-19768-87
    GREEK                   greek
    GREEK-CCITT             greek-ccitt
    GREEK7                  greek-7
    GREEK7-OLD              greek-7-old
    GREEK8                  greek-8
    HEBREW                  hebrew
    HP-ROMAN8               hp-roman-8
    HU                      hu
    IBM037                  ibm-037
    IBM038                  ibm-038
    IBM1004                 ibm-1004
    IBM1026                 ibm-1026
    IBM1047                 ibm-1047
    IBM256                  ibm-256
    IBM273                  ibm-273
    IBM274                  ibm-274
    IBM275                  ibm-275
    IBM277                  ibm-277
    IBM278                  ibm-278
    IBM280                  ibm-280
    IBM281                  ibm-281
    IBM284                  ibm-284
    IBM285                  ibm-285
    IBM290                  ibm-290
    IBM297                  ibm-297
    IBM367                  ibm-367
    IBM420                  ibm-420
    IBM423                  ibm-423
    IBM424                  ibm-424
    IBM437                  ibm-437
    IBM500                  ibm-500
    IBM819                  ibm-819
    IBM850                  ibm-850
    IBM851                  ibm-851
    IBM852                  ibm-852
    IBM855                  ibm-855
    IBM857                  ibm-857
    IBM860                  ibm-860
    IBM861                  ibm-861
    IBM862                  ibm-862
    IBM863                  ibm-863
    IBM864                  ibm-864
    IBM865                  ibm-865
    IBM868                  ibm-868
    IBM869                  ibm-869
    IBM870                  ibm-870
    IBM871                  ibm-871
    IBM875                  ibm-875
    IBM880                  ibm-880
    IBM891                  ibm-891
    IBM903                  ibm-903
    IBM904                  ibm-904
    IBM905                  ibm-905
    IBM918                  ibm-918
    IEC_P27-1               iec-p-27-1
    INIS                    inis
    INIS-8                  inis-8
    INIS-CYRILLIC           inis-cyrillic
    INVARIANT               invary
    IRV                     irv
    ISO-8859-1              iso-8859-1
    ISO-8859-10             iso-8859-10
    ISO-8859-2              iso-8859-2
    ISO-8859-3              iso-8859-3
    ISO-8859-4              iso-8859-4
    ISO-8859-5              iso-8859-5
    ISO-8859-6              iso-8859-6
    ISO-8859-7              iso-8859-7
    ISO-8859-8              iso-8859-8
    ISO-8859-9              iso-8859-9
    ISO-IR-10               iso-ir-10
    ISO-IR-100              iso-ir-100
    ISO-IR-101              iso-ir-101
    ISO-IR-102              iso-ir-102
    ISO-IR-103              iso-ir-103
    ISO-IR-109              iso-ir-109
    ISO-IR-11               iso-ir-11
    ISO-IR-110              iso-ir-110
    ISO-IR-111              iso-ir-111
    ISO-IR-121              iso-ir-121
    ISO-IR-122              iso-ir-122
    ISO-IR-123              iso-ir-123
    ISO-IR-126              iso-ir-126
    ISO-IR-127              iso-ir-127
    ISO-IR-128              iso-ir-128
    ISO-IR-13               iso-ir-13
    ISO-IR-138              iso-ir-138
    ISO-IR-139              iso-ir-139
    ISO-IR-14               iso-ir-14
    ISO-IR-141              iso-ir-141
    ISO-IR-142              iso-ir-142
    ISO-IR-143              iso-ir-143
    ISO-IR-144              iso-ir-144
    ISO-IR-146              iso-ir-146
    ISO-IR-147              iso-ir-147
    ISO-IR-148              iso-ir-148
    ISO-IR-15               iso-ir-15
    ISO-IR-150              iso-ir-150
    ISO-IR-151              iso-ir-151
    ISO-IR-152              iso-ir-152
    ISO-IR-153              iso-ir-153
    ISO-IR-154              iso-ir-154
    ISO-IR-155              iso-ir-155
    ISO-IR-156              iso-ir-156
    ISO-IR-157              iso-ir-157
    ISO-IR-158              iso-ir-158
    ISO-IR-16               iso-ir-16
    ISO-IR-17               iso-ir-17
    ISO-IR-170              iso-ir-170
    ISO-IR-179              iso-ir-179
    ISO-IR-18               iso-ir-18
    ISO-IR-19               iso-ir-19
    ISO-IR-2                iso-ir-2
    ISO-IR-21               iso-ir-21
    ISO-IR-25               iso-ir-25
    ISO-IR-27               iso-ir-27
    ISO-IR-37               iso-ir-37
    ISO-IR-4                iso-ir-4
    ISO-IR-47               iso-ir-47
    ISO-IR-49               iso-ir-49
    ISO-IR-50               iso-ir-50
    ISO-IR-51               iso-ir-51
    ISO-IR-54               iso-ir-54
    ISO-IR-55               iso-ir-55
    ISO-IR-57               iso-ir-57
    ISO-IR-6                iso-ir-6
    ISO-IR-60               iso-ir-60
    ISO-IR-61               iso-ir-61
    ISO-IR-69               iso-ir-69
    ISO-IR-70               iso-ir-70
    ISO-IR-8-1              iso-ir-8-1
    ISO-IR-8-2              iso-ir-8-2
    ISO-IR-84               iso-ir-84
    ISO-IR-85               iso-ir-85
    ISO-IR-86               iso-ir-86
    ISO-IR-88               iso-ir-88
    ISO-IR-89               iso-ir-89
    ISO-IR-9-1              iso-ir-9-1
    ISO-IR-9-2              iso-ir-9-2
    ISO-IR-90               iso-ir-90
    ISO-IR-91               iso-ir-91
    ISO-IR-92               iso-ir-92
    ISO-IR-93               iso-ir-93
    ISO-IR-94               iso-ir-94
    ISO-IR-95               iso-ir-95
    ISO-IR-96               iso-ir-96
    ISO-IR-98               iso-ir-98
    ISO-IR-99               iso-ir-99
    ISO646-CA               iso-646-ca
    ISO646-CA2              iso-646-ca-2
    ISO646-CN               iso-646-cn
    ISO646-CU               iso-646-cu
    ISO646-DE               iso-646-de
    ISO646-DK               iso-646-dk
    ISO646-ES               iso-646-es
    ISO646-ES2              iso-646-es-2
    ISO646-FI               iso-646-fi
    ISO646-FR               iso-646-fr
    ISO646-FR1              iso-646-fr-1
    ISO646-GB               iso-646-gb
    ISO646-HU               iso-646-hu
    ISO646-IT               iso-646-it
    ISO646-JP               iso-646-jp
    ISO646-JP-OCR-B         iso-646-jp-ocr-b
    ISO646-KR               iso-646-kr
    ISO646-NO               iso-646-no
    ISO646-NO2              iso-646-no-2
    ISO646-PT               iso-646-pt
    ISO646-PT2              iso-646-pt-2
    ISO646-SE               iso-646-se
    ISO646-SE2              iso-646-se-2
    ISO646-US               iso-646-us
    ISO646-YU               iso-646-yu
    ISO6937                 iso-6937
    ISO_10367-BOX           iso-10367-box
    ISO_2033-1983           iso-2033-1983
    ISO_5427                iso-5427
    ISO_5427-EXT            iso-5427-ext
    ISO_5427:1981           iso-5427-1981
    ISO_5428                iso-5428
    ISO_5428:1980           iso-5428-1980
    ISO_646.BASIC           iso-646-basic
    ISO_646.BASIC:1983      iso-646-basic-1983
    ISO_646.IRV             iso-646-irv
    ISO_646.IRV:1983        iso-646-irv-1983
    ISO_646.IRV:1991        iso-646-irv-1991
    ISO_6937                iso-6937
    ISO_6937-2-25           iso-6937-2-25
    ISO_6937-2-ADD          iso-6937-2-add
    ISO_6937-2:1983         iso-6937-2-1983
    ISO_6937:1992           iso-6937-1992
    ISO_8859-1              iso-8859-1
    ISO_8859-10             iso-8859-10
    ISO_8859-10:1993        iso-8859-10-1993
    ISO_8859-1:1987         iso-8859-1-1987
    ISO_8859-2              iso-8859-2
    ISO_8859-2:1987         iso-8859-2-1987
    ISO_8859-3              iso-8859-3
    ISO_8859-3:1988         iso-8859-3-1988
    ISO_8859-4              iso-8859-4
    ISO_8859-4:1988         iso-8859-4-1988
    ISO_8859-5              iso-8859-5
    ISO_8859-5:1988         iso-8859-5-1988
    ISO_8859-6              iso-8859-6
    ISO_8859-6:1987         iso-8859-6-1987
    ISO_8859-7              iso-8859-7
    ISO_8859-7:1987         iso-8859-7-1987
    ISO_8859-8              iso-8859-8
    ISO_8859-8:1988         iso-8859-8-1988
    ISO_8859-9              iso-8859-9
    ISO_8859-9:1989         iso-8859-9-1989
    ISO_8859-SUPP           iso-8859-supp
    ISO_9036                iso-9036
    IT                      it
    JIS_C6220-1969          jis-c-6220-1969
    JIS_C6220-1969-JP       jis-c-6220-1969-jp
    JIS_C6220-1969-RO       jis-c-6220-1969-ro
    JIS_C6229-1984-A        jis-c-6229-1984-a
    JIS_C6229-1984-B        jis-c-6229-1984-b
    JIS_C6229-1984-B-ADD    jis-c-6229-1984-b-add
    JIS_C6229-1984-HAND     jis-c-6229-1984-hand
    JIS_C6229-1984-HAND-ADD jis-c-6229-1984-hand-add
    JIS_C6229-1984-KANA     jis-c-6229-1984-kana
    JIS_X0201               jis-x-0201
    JP                      jp
    JP-OCR-A                jp-ocr-a
    JP-OCR-B                jp-ocr-b
    JP-OCR-B-ADD            jp-ocr-b-add
    JP-OCR-HAND             jp-ocr-hand
    JP-OCR-HAND-ADD         jp-ocr-hand-add
    JS                      js
    JUS_I.B1.002            jus-i-b-1-002
    JUS_I.B1.003-MAC        jus-i-b-1-003-mac
    JUS_I.B1.003-SERB       jus-i-b-1-003-serb
    KATAKANA                katakana
    KOI-7                   koi-7
    KOI-8                   koi-8
    KOI8-R                  koi-8-r
    KSC5636                 ksc-5636
    L1                      l-1
    L2                      l-2
    L3                      l-3
    L4                      l-4
    L5                      l-5
    L6                      l-6
    LAP                     lap
    LATIN-GREEK             latin-greek
    LATIN-GREEK-1           latin-greek-1
    LATIN-LAP               latin-lap
    LATIN1                  latin-1
    LATIN1-2-5              latin-1-2-5
    LATIN2                  latin-2
    LATIN3                  latin-3
    LATIN4                  latin-4
    LATIN5                  latin-5
    LATIN6                  latin-6
    MAC                     mac
    MAC-IS                  mac-is
    MACEDONIAN              macedona
    MACINTOSH               macntosh
    MS-ANSI                 ms-ansi
    MS-ARAB                 ms-arab
    MS-CYRL                 ms-cyrl
    MS-EE                   ms-ee
    MS-GREEK                ms-greek
    MS-HEBR                 ms-hebr
    MS-TURK                 ms-turk
    MSZ_7795.3              ms-z-7795-3
    NAPLPS                  naplps
    NATS-DANO               nats-dano
    NATS-DANO-ADD           nats-dano-add
    NATS-SEFI               nats-sefi
    NATS-SEFI-ADD           nats-sefi-add
    NC_NC00-10              nc-nc-00-10
    NC_NC00-10:81           nc-nc-00-10-81
    NEXT                    next
    NEXTSTEP                nextstep
    NF_Z_62-010             nf-z-62-010
    NF_Z_62-010_(1973)      nf-z-62-010-1973
    NO                      no
    NO2                     no-2
    NS_4551-1               ns-4551-1
    NS_4551-2               ns-4551-2
    OS2LATIN1               os2-latin-1
    PT                      pt
    PT2                     pt-2
    R8                      r-8
    REF                     ref
    ROMAN8                  roman-8
    SAMI                    sami
    SE                      se
    SE2                     se-2
    SEN_850200_B            sen-850200-b
    SEN_850200_C            sen-850200-c
    SERBIAN                 serbian
    SS636127                ss-636127
    ST_SEV_358-88           st-sev-358-88
    T.101-G2                t-101-g-2
    T.61                    t-61
    T.61-7BIT               t-61-7-bit
    T.61-8BIT               t-61-8-bit
    UK                      uk
    US                      us
    US-ASCII                us-ascii
    VIDEOTEX-SUPPL          videotex-suppl
    WINBALTRIM              win-baltrim
    X0201                   x-0201
    X0201-7                 x-0201-7
    YU                      yu
>;

my constant %reverse-encodings = %encodings.antipairs;

# Not exhaustive yet
my constant %scripts = <
    latin    Latn
    cyrillic Cyrl
    greek    Grek
>;

my constant %reverse-scripts = %scripts.antipairs;

method bcp47 {
    # Needs to account for modifiers, etc later
    $!language ~ ("-$!region" if $!region) ~ "-x-encoding-" ~ %encodings{$!encoding}
}

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
        my @subtags = $s.split('-');
        my ($language, $script, $region, $encoding) = '' xx 4;
        my @variants;

        $language = @subtags.shift;
        $script = @subtags.shift
            if @subtags.head ~~ /^ <alpha> ** 4 $/;
        $region = @subtags.shift
            if @subtags.head ~~ /^ [ <alpha> ** 2 | <digit> ** 3 ] $/;

        @variants.push: @subtags.shift
            while @subtags && @subtags.head.chars > 1;

        # Cycle to private use
        @subtags.shift
            while @subtags
               && @subtags.head ne 'x';
        # Try to find encoding (noop if no private use)
        @subtags.shift
            while @subtags
               && @subtags.head ne 'encoding';

        if @subtags > 1 && @subtags.head eq 'encoding' {
            # some tags are shorter versions of others, so
            # we try the longest one possible first
            for (@subtags - 1) ... 1 {
                my $enc = @subtags[1 .. $_].join('-');
                $encoding = %reverse-encodings{$enc}
                    and last
                        if %reverse-encodings{$enc}:exists;
            }
            # Failsafe, but unlikely
            $encoding ||= @subtags[1].uc;
        }

        my
        $modifier  = %reverse-scripts{$script} // '';
        $modifier ~= ',' if $modifier && @variants;
        $modifier ~= @variants.join(',');

        self.bless:
            language => ~  $language,
            region   => ~ ($region   // ''),
            encoding => ~ ($encoding // ''),
            modifier => ~  $modifier,
    }

multi method COERCE(LanguageTaggish:D $s --> LanguageTag::POSIX) is default { self.new-from-bcp47: $s.bcp47 }
multi method COERCE(Str() $s) { self.new: $s }
