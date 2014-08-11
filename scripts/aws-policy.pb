
policy: "{" nl
        version "," nl
        statement-list nl
        "}" ;

version: "\"Version\":" simple-date-string ;

simple-date-string: "\"" year "-" month "-" day "\"" ;

year: "2012" | "2013" | "2014" ;
month: "01" | "02" | "03" | "04" | "05" | "06" |
       "07" | "08" | "09" | "10" | "11" | "12" ;
day: "01" ;

statement-list: "\"Statement\": [" statements "]" ;
statements: statement | statement "\n" statements ;

statement: "{" effect-clause ","
               action-clause ","
               resource-clause
               optional-clauses "}" ;

effect-clause:   "\"Effect\":"   effect ;
action-clause:   "\"Action\":"   action ;
resource-clause: "\"Resource\":" resource-value ;

optional-clauses: "" |
                  "," condition-clause ;

condition-clause: "\"Condition\":" condition-value ;
condition-value: "{" nl
                 condition-expressions
                 "}" nl ;

condition-expressions: condition-expression |
                       condition-expressions "," condition-expression ;

condition-expression: stringlike-expression ;

stringlike-expression: "\"StringLike\":"  "{" "}" ;

effect: "\"Allow\"" "\"Deny\"" ;
action: "\"\"" ;
resource-value: [ single-resource | resource-list ] ;

single-resource: "" ;
resource-list: "[" resources "]" ;

resources: "" ;

arn: "arn:aws:" service ":" region ":" account-id ":" resource-name ;

service: "iam" | "ec2" | "s3" ;

region: "us-west-1" ;

account-id: "877348900806" ;

resource-name: user-resource | group-resource ;

user-resource:  "user"  resource-path "/" user-name ;
group-resource: "group" resource-path "/" group-name ;

resource-path: "" | "/path" ;

user-name: "" ;
group-name: "" ;

nl: "\n" ;
