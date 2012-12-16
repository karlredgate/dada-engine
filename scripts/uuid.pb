
uuid: random-uuid32 "-" random-uuid16 "-4" random-uuid12 "-" ["8"|"9"|"a"|"b"] random-uuid12 "-" random-uuid48 ;

random-uuid48: random-uuid32 random-uuid16 ;
random-uuid32: random-uuid16 random-uuid16 ;
random-uuid16: random-uuid12 random-uuid4 ;
random-uuid12: random-uuid4 random-uuid4 random-uuid4 ;

random-uuid4: "0" | "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9" |
              "a" | "b" | "c" | "d" | "e" | "f" ;
