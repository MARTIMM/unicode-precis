[![Build Status](https://travis-ci.org/MARTIMM/unicode-precis.svg?branch=master)](https://travis-ci.org/MARTIMM/unicode-precis)

# PRECIS Framework: Preparation, Enforcement, and Comparison of Internationalized Strings in Application Protocols

Many tests are based on the Unicode® database as well as the unicode tools from perl6. Not all methods and functions are in place e.g. uniprop() is not yet available in the jvm. Also perl6 seems to be based on Unicode version 6.1.0.

## Synopsis

```
```

### RFC's

I've started to study rfc4013 for SASLprep. Then recognized it was a profile based on Stringprep specified in rfc3454. Both are obsoleted by rfc7613 and rfc7564 resp because they are tied to Unicode version 3.2. The newer rfc's are specified to be free of any version.

* rfc3454 - Preparation of Internationalized Strings ("stringprep").
* rfc7564 - PRECIS Framework: Preparation, Enforcement, and Comparison of Internationalized Strings in Application Protocols. Obsoletes rfc3454.

* rfc4013 - SASLprep: Stringprep Profile for User Names and
* rfc7613 - Preparation, Enforcement, and Comparison of Internationalized Strings Representing Usernames and Passwords. Obsoletes rfc4013.

Further needed information from
* rfc5892 - The Unicode Code Points and Internationalized Domain Names for Applications (IDNA)

### Perl 6

NOTE: At the moment jvm does not yet support several unicode functions such as
unival, uniprop etc. Moarvm does support them. I'll try to emulate them but it isn't clear if it is fast enaugh.

Perl 6 uses graphemes as a base for the Str string type. These are the visible entities which show as a single symbol and are counted as such with the ```Str.chars``` method. From this, normal forms can be generated using the string methods NFC, NFD, NFKC and NFKD. Furthermore the strings can be encoded to utf-8.

## Implementation track

First the basis of the PRECIS framework will be build. As soon as possible a profile for usernames and passwords follows. This is my first need. When this functions well enough, other profiles can be inserted. Perl 6 unicode is based on UCD version 6.1.0 while I am looking at tables of version 9.0.0.

Naming of modules;
  Unicode::PRECIS                                           from rfc7564
  Unicode::PRECIS::Identifier                               from rfc7564
  Unicode::PRECIS::Identifier::UsernameCaseMapped           from rfc7613
  Unicode::PRECIS::Identifier::UsernameCasePreserved        from rfc7613

  Unicode::PRECIS::Freeform                                 from rfc7564
  Unicode::PRECIS::Freeform::OpaqueString                   from rfc7613

## Versions of perl, moarvm

This project is tested with latest Rakudo built on MoarVM implementing Perl v6.c.

## Bugs, known limitations and todo
* Try to use tables when uniprop is not available
* Try to use the highest possible unicode version when using tables. At the time of writing this 9.0.0.

## Changelog

See [semantic versioning](http://semver.org/). Please note point 4. on
that page: *Major version zero (0.y.z) is for initial development. Anything may
change at any time. The public API should not be considered stable.*

* 0.2.0
  * New start with newer rfc's
* 0.1.1
  * Abandon translation. There are several follow ups of the rfc's to study first.
  * Renamed the repository into unicode-precis
* 0.1
  * Start project. The sources are taken from the perl 5 modules and translated into perl6

## License

Released under [Artistic License 2.0](http://www.perlfoundation.org/artistic_license_2_0).

## Authors

```
Marcel Timmerman translation of the modules for perl 6
```
## Contact

MARTIMM on github: MARTIMM
