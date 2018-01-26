
%resource  old-tld: "com" | "edu" | "gov" | "mil" | "org" ;
%resource  new-tld: "biz" | "name" ;

%resource  ccTLD: "uk" | "to" | "au" | "ca" | "it" | "us" ;

%resource  tech-tld: "io" | "ai" | "tv" ;
%resource  long-tech-tld: "info" ;
%resource  vanity-tld: "aws" ;

%resource  common-tld: old-tld | tech-tld ;

%resource  china: "中国" ;
%resource  eu: "ею" ;
%resource  india-hindi: "भारत" ;
%resource  russia: "рф" ;
%resource  south-korea: "한국";

%resource  well-known-domain:
    "cnn.com" | "foxnews.com" | "boston.com" |
    "dell.com" | "hp.com" | "sun.com" | "sgi.com" |
    "yahoo.com" | "movies.yahoo.com" | "finance.yahoo.com" |
    "lycos.com" | "ibm.com" |
    "prep.ai.mit.edu" |
    "gnu.org" | "apache.org" | "gnome.org" | "kernel.org" |
    "github.com" | "sourceforge.com" |
    "microsoft.com" | "intel.com" |
    "google.com" ;

%resource  www: "www." ;
%resource  developer: "developer." ;
%resource  wildcard: "*." ;

%resource  random-host-segment: alphanum+ ;
%resource  random-primary-domain: random-host-segment common-tld ;

%resource  hostname:
    developer well-known-domain |
    www well-known-domain | well-known-domain ;

test: hostname ;
