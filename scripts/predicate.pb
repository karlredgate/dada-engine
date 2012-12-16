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
  IntegerDelineation IntOp   Integer       |
  StringDelineation  StrOp   StringLiteral |

  ListDelineation " has " CookieName StrOp StringLiteral |
  ListDelineation " has " CookieName IntOp Integer       |

  KeywordDelineation    BitIs       BitFieldKeyword |
  KeywordSetDelineation BitContains BitFieldKeyword ;

Relation: FieldLenExpr IntOp Integer |
          delineation_name_use UnaryOp ;

FieldLenExpr: "length" "(" delineation_name_use ")" ;

BitContains: " contains " | " contain " ;
BitIs: " is " ;

StrOp:" eq "|" ne "|" lt "|" gt "|" le "|" ge ";
IntOp:" == "|" != "| " < "| " > "|" <= "|" >= ";

UnaryOp: " present " | " absent " ;

BitFieldKeyword: keyword_name_use ;
CookieName: StringLiteral ;

StringDelineation: "URI_PATH" | "USER_AGENT" | "REQUEST_VERSION" ;
IntegerDelineation: "CONTENT_LENGTH" | "PORT" ;
KeywordDelineation: "METHOD" ;
KeywordSetDelineation: "CONNECTION" | "TRANSFER_ENCODING" ;
ListDelineation: "COOKIE" ;
IPv4Delineation: "CLIENT_ADDRESS" ;
delineation_name_use: 
   StringDelineation | IntegerDelineation | 
   KeywordDelineation | KeywordSetDelineation |
   IPv4Delineation ;
keyword_name_use: "close" | "keep-alive" | "gzip" ;

white: space ;
