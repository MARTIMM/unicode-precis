# String preparation for use in protocols and procedures.

## Synopsis

```
```

## Implementation track

### Translation from perl 5 modules

Started by taking the modules from perl5 and tried to translate them. This is difficult because the routines used are generating other routines which are evaluated and returned as a transformation procedure of some sort depending on the input (the profile). Then I decided to do it from scratch by looking into the rfc's and saw that the rfc's where obsoleted by others and that this perl5 module was not the proper one to use. One of the reasons not to go further was that the module was pinned to Unicode version 3.2.

### RFC's

I've started to study rfc4013 for SASLprep. Then recognized it was a profile based on Stringprep specified in rfc3454 and discovered the perl5 modules implementing this procedure. Both are obsoleted by rfc7613 and rfc7564 resp. Now I am studying rfc6885.

* rfc3454 - Preparation of Internationalized Strings ("stringprep").
* rfc7564 - PRECIS Framework: Preparation, Enforcement, and Comparison of Internationalized Strings in Application Protocols. Obsoletes rfc3454.
  * Preparation, Enforcement, and Comparison
  * String classes


* rfc6885 - Stringprep Revision and Problem Statement for the Preparation and Comparison of Internationalized Strings (PRECIS). This is an informative document about the process of redesigning the stringprep procedure.

* rfc4013 - SASLprep: Stringprep Profile for User Names and
* rfc7613 - Preparation, Enforcement, and Comparison of Internationalized Strings Representing Usernames and Passwords. Obsoletes rfc4013.

### Perl 6

Perl 6 uses NFG internally to specify character strings. This is not a standard but a perl 6 invention to look at strings as a list of graphemes (see synopsis 15). From this other forms can be generated using the string methods NFC, NFD, NFKC and NFKD. Furthermore the strings can be encoded to utf-8 and utf-16.

## Versions of perl, moarvm and MongoDB

This project is tested with latest Rakudo built on MoarVM implementing Perl v6.c.

## Bugs, known limitations and todo

## Changelog

See [semantic versioning](http://semver.org/). Please note point 4. on
that page: *Major version zero (0.y.z) is for initial development. Anything may
change at any time. The public API should not be considered stable.*

* 0.1.1
  * Abandon translation. There are several follow ups of the rfc's to study first.
* 0.1
  * Start project. The sources are taken from the perl 5 modules and translated into perl6

## License

Released under [Artistic License 2.0](http://www.perlfoundation.org/artistic_license_2_0).

## Authors

```
Claus Färber: Original creator of the modules for perl 5. See [CPAN](http://search.cpan.org/~cfaerber/Unicode-Stringprep-1.105/lib/Unicode/Stringprep.pm)
Marcel Timmerman translation of the modules for perl 6
```
## Contact

MARTIMM on github: MARTIMM/mongo-perl6-driver
