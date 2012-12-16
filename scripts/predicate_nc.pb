#include "base.pb"

Predicate: Condition ;
Condition: Disjunction ;
Disjunction: Conjunction |
  Disjunction white "or" white Conjunction ;
Conjunction: Comparison |
  Conjunction white "and" white Comparison ;

Comparison: Primary | ["not"|"!"] white Primary ;

Primary: Relation | Relation | Relation | Relation |
         "(" white* Condition white* ")" ;

Relation:
  StringDelineation  " matches " StringLiteral |
  StringDelineation  " matches " StringLiteral |
  IPv4Delineation    " matches " L4AddressSpec |
  IntegerDelineation IntOp   BoundedInteger       |
  StringDelineation  StrOp   StringLiteral |

  KeywordDelineation    " is "       BitFieldKeyword |
  KeywordSetDelineation " contains " BitFieldKeyword |
  IntFunctionExpr IntOp BoundedInteger |
  NonDerivedDelineation UnaryOp ;

# IntFunctionExpr: "length" "(" delineation_name_use ")" |
IntFunctionExpr: "length" "(" StringDelineation ")" |
                 "crc32"  "(" StringDelineation ")" ;

StrOp:" eq "|" ne "|" lt "|" gt "|" le "|" ge ";
IntOp:" == "|" != "| " < "| " > "|" <= "|" >= ";

UnaryOp: " present " | " absent " ;

BitFieldKeyword: keyword_name_use ;
CookieName: StringLiteral ;

StringDelineation: "URI_PATH" | "USER_AGENT" | "REQUEST_VERSION" ;
IntegerDelineation: "CONTENT_LENGTH" | "PORT" ;
KeywordDelineation: "METHOD" ;
KeywordSetDelineation: "CONNECTION" | "TRANSFER_ENCODING" ;
IPv4Delineation: "CLIENT_ADDRESS" ;
delineation_name_use: 
   StringDelineation | IntegerDelineation | 
   KeywordDelineation | KeywordSetDelineation |
   IPv4Delineation ;
NonDerivedDelineation: "USER_AGENT" | "REQUEST_VERSION" |
    "CONTENT_LENGTH" | "METHOD" | "CONNECTION" | "TRANSFER_ENCODING" ;
keyword_name_use: "close" | "keep-alive" | "gzip" ;

white: space ;
