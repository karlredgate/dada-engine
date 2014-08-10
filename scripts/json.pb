
#include "base.pb"

# JSONText : JSONValue ;
JSONText : JSONObject ;

JSONValue : JSONNullLiteral |
            JSONBooleanLiteral |
            JSONObject |
            JSONArray |
            JSONString |
            JSONNumber ;

# JSONObject : "{" "}" | "{" JSONMemberList "}" ;
JSONObject : "{" nl
             JSONMemberList nl
             "}" ;
JSONMember : JSONString ":" JSONValue ;
JSONMemberList : JSONMember | JSONMemberList "," JSONMember ;
JSONArray : "[" "]" | "[" JSONElementList "]" ;
JSONElementList : JSONValue | JSONElementList "," JSONValue ;

JSONString : StringLiteral ;
JSONNumber : Integer ;
JSONNullLiteral : "null" ;
JSONBooleanLiteral : "true" | "false" ;
