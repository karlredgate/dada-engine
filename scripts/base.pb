%resource  Boolean: "true" | "false" ;
%resource  Integer: non-zero digit* ;
%resource  Number : Integer ;
%resource  StringLiteral: "\"" ascii+ ascii* ascii* "\"" ;
%resource  BoundedInteger:
           non-zero  |
           non-zero digit |
           non-zero digit digit |
           non-zero digit digit digit |
           non-zero digit digit digit digit |
           non-zero digit digit digit digit digit |
           non-zero digit digit digit digit digit digit |
           non-zero digit digit digit digit digit digit digit ;

%resource  HexNumber: "0x" hexdigit+ ;
%resource  BoundedHexNumber:
           "0x" hexdigit |
           "0x" hexdigit hexdigit |
           "0x" hexdigit hexdigit hexdigit |
           "0x" hexdigit hexdigit hexdigit hexdigit |
           "0x" hexdigit hexdigit hexdigit hexdigit
                hexdigit |
           "0x" hexdigit hexdigit hexdigit hexdigit
                hexdigit hexdigit |
           "0x" hexdigit hexdigit hexdigit hexdigit
                hexdigit hexdigit hexdigit |
           "0x" octdigit hexdigit hexdigit hexdigit
                hexdigit hexdigit hexdigit hexdigit ;

%resource  HexHash:
           "0x0000000" lhexdigit |
           "0x000000" lhexdigit lhexdigit |
           "0x00000" lhexdigit lhexdigit lhexdigit |
           "0x0000" lhexdigit lhexdigit lhexdigit lhexdigit |
           "0x000" lhexdigit lhexdigit lhexdigit lhexdigit
                   lhexdigit |
           "0x00" lhexdigit lhexdigit lhexdigit lhexdigit
                  lhexdigit lhexdigit |
           "0x0" lhexdigit lhexdigit lhexdigit lhexdigit
                 lhexdigit lhexdigit lhexdigit |
           "0x" octdigit lhexdigit lhexdigit lhexdigit
                lhexdigit lhexdigit lhexdigit lhexdigit ;

/* %resource  L4Address: DottedQuad | BoundedInteger ; */
%resource  L4Address: DottedQuad ;
%resource  L4Mask:    DottedMask | uint5_bits ;
%resource  L4AddressSpec: L4Address "/" L4Mask | L4Address ;

%resource  ascii:    uppercase | lowercase | digit ;
%resource  alpha:    uppercase | lowercase ;
%resource  alphanum: uppercase | lowercase | digit ;
%resource  Identifier: alpha alphanum+ ;

%resource  uint5_t:
     digit | "1" digit | "2" digit | "3" ["0"|"1"] ;

%resource  uint5_bits:
     non-zero | "1" digit | "2" digit | "3" ["0"|"1"|"2"] ;

%resource  uint8_t:
     digit           | digit           |
     non-zero digit  | non-zero digit  |
     "1" digit digit | "1" digit digit |
     "2" ["0"|"1"|"2"|"3"|"4"] digit   |
     "25" ["0"|"1"|"2"|"3"|"4"|"5"]    ;

%resource  digit: "0"|"1"|"2"|"3"|"4"|"5"|"6"|"7"|"8"|"9";
%resource  non-zero:  "1"|"2"|"3"|"4"|"5"|"6"|"7"|"8"|"9";
%resource  octdigit: "0"|"1"|"2"|"3"|"4"|"5"|"6"|"7";
%resource  non0-octdigit: "1"|"2"|"3"|"4"|"5"|"6"|"7";
%resource  hexdigit: "0"|"1"|"2"|"3"|"4"|"5"|"6"|"7"|"8"|"9"|
                     hexA | hexB | hexC | hexD | hexE | hexF;
%resource  non0-hexdigit: "1"|"2"|"3"|"4"|"5"|"6"|"7"|"8"|"9"|
                     hexA | hexB | hexC | hexD | hexE | hexF;
%resource  lhexdigit: "0"|"1"|"2"|"3"|"4"|"5"|"6"|"7"|"8"|"9"|
                      "a"|"b"|"c"|"d"|"e"|"f";

%resource  hexA: "a"|"A";
%resource  hexB: "b"|"B";
%resource  hexC: "c"|"C";
%resource  hexD: "d"|"D";
%resource  hexE: "e"|"E";
%resource  hexF: "f"|"F";

%resource  uppercase:
    "A" | "B" | "C" | "D" | "E" | "F" | "G" | "H" | "I" |
    "J" | "K" | "L" | "M" | "N" | "O" | "P" | "Q" | "R" |
    "S" | "T" | "U" | "V" | "W" | "X" | "Y" | "Z" ;
%resource  lowercase:
    "a" | "b" | "c" | "d" | "e" | "f" | "g" | "h" | "i" |
    "j" | "k" | "l" | "m" | "n" | "o" | "p" | "q" | "r" |
    "s" | "t" | "u" | "v" | "w" | "x" | "y" | "z" ;

%resource  whitespace: hws | vws ;

%resource  hws: space | tab ;
%resource  spaces: space+ ;
%resource  space: " " ;
%resource  tab: "\t" ;

%resource  vws: nl | cr ;
%resource  newline: "\n" ;
%resource  nl: "\n" ;
%resource  lf: "\n" ;
%resource  cr: "\r" ;
%resource  crlf: cr lf ;

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
