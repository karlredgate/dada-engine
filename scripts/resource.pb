
%resource  L4Address: DottedQuad ;
%resource  L4Mask:    DottedMask | uint5_bits ;
%resource  L4AddressSpec: L4Address "/" L4Mask | L4Address ;

%resource  DottedQuad: byte "." byte "." byte "." byte ;
%resource  DottedMask:
    "255.255.255." mask-byte  |
    "255.255." mask-byte ".0" |
    "255." mask-byte ".0.0"   |
    mask-byte ".0.0.0"        ;

%resource  byte: { = 1..254 } ;
%resource  mask-byte:
    "128"|"192"|"224"|"240"|"248"|"252"|"254"|"255";

%resource  rfc-date-time: Wdy ", " rfc-date " " rfc-time " UTC" ;

%resource  YR:   digit digit ;
%resource  YEAR: digit digit digit digit ;
%resource  DY:   "0" non-zero | non-zero digit ;
%resource  rfc-date: DY "-" Mon "-" YEAR ;
%resource  SC: ["0"|"1"|"2"|"3"|"4"|"5"] digit ;

%resource  Wdy: "Sun" | "Mon" | "Tue" | "Wed" | "Thu" | "Fri" | "Sat" ;
%resource  Mon: "Jan" | "Feb" | "Mar" | "Apr" | "May" | "Jun" |
                "Jul" | "Aug" | "Sep" | "Oct" | "Nov" | "Dec" ;

%resource  rfc-time: HR ":" MN ":" SC ;
%resource  HR: "0" digit | "1" digit | "2" ["0"|"1"|"2"|"3"] ;
%resource  MN: ["0"|"1"|"2"|"3"|"4"|"5"] digit ;


testnumber-init: { serial = 1 } ;
testnumber: $serial { serial = serial + 1 } ;

encoded: { decoded = "" } encoded-char+ encoded-char* encoded-char* ;
encoded-char: c=choose-char ?d=$c>tolower { decoded = decoded + d } ;
%trans tolower:
   ".*" : l ;

