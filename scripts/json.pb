
#include "base.pb"

JSONText : JSONValue ;

JSONValue :
            JSONObject |
            JSONNullLiteral |
            JSONBooleanLiteral |
            JSONArray |
            JSONString |
            JSONNumber ;

JSONObject : "{" JSONObjectMembers "}" ;
JSONObjectMembers : JSONMemberList | "" ;
JSONMemberList : JSONMember | JSONMemberList "," JSONMember ;
JSONMember : JSONString ":" JSONValue ;

JSONArray : "[" JSONArrayMembers "]" ;
JSONArrayMembers : JSONElementList | "" ;
JSONElementList : JSONValue | JSONElementList "," JSONValue ;

JSONString : StringLiteral ;
JSONNumber : Integer ;
JSONNullLiteral : "null" ;
JSONBooleanLiteral : "true" | "false" ;
