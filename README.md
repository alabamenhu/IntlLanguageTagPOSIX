# Intl::LanguageTag::POSIX
 A representation of the POSIX language tag

The posix tag has the basic format of `<lang> ['_'<reg>]? ['.'<enc>]? ['@'<mod>]`.  For instance:

  * **en_IE.UTF-8@euro;**  
  Irish English encoded in UTF-8 using the Euro currency

## Usage notes

   * The encoding is preserved in BCP-47 as a private extension, that is, `en_EN.UTF-8` will become `en-EN-x-encoding-utf8` in order to enable a roundtrip conversion.  This can be avoided by passing the option `:!encoding`.

## Todo
   * Support / distinguish `LC_*` subtags (that is, a complex tag like `LC_CTYPE=en_US.UTF-8;LC_TIME=es_ES.UTF-8;`)

## Version history
  * **v0.2**
    * Improved POSIX ↔︎ BCP-47 coercions with extensive encoding mappings
    * Initial work towards script coercion
  * **v0.1**  
    * Initial release, supporting basic creation of POSIX tags