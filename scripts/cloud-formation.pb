
template :
    "{" new-line
        version     "," new-line
        description "," new-line
        resource-clause new-line
    "}" new-line
;

version:
    quote "AWSTemplateFormatVersion" quote white-space
    ":" white-space
    quote "2010-09-09" quote
;

description:
    quote "Description" quote white-space
    ":" white-space
    quote "a random template" quote
;

resource-clause:
    quote "Resources" quote white-space
    ":" white-space
    "{" new-line
        resource-list
    "}" new-line
;

resource-list:
    resource-list "," new-line resource |
    resource-list "," new-line resource |
    resource-list "," new-line resource |
    resource |
    resource-list "," new-line resource |
    resource-list "," new-line resource
;

resource:
    EC2-resource |
    EIP-resource
;

EC2-resource:
    resource-name ":" "{" new-line
        quote "Type" quote ":" quote "AWS::EC2::Instance" quote "," new-line
        EC2-property-clause
    "}" new-line
;

EIP-resource:
    resource-name ":" "{" new-line
        quote "Type" quote ":" quote "AWS::EC2::EIP" quote "," new-line
        EIP-property-clause
    "}" new-line
;

EC2-property-clause:
    quote "Properties" quote white-space
    ":" white-space
    "{" new-line
        image-id-property      "," new-line
        instance-type-property     new-line
    "}" new-line
;

EIP-property-clause:
    quote "Properties" quote white-space
    ":" white-space
    "{" new-line
    "}" new-line
;

instance-type-property:
    quote "InstanceType" quote white-space
    ":" white-space
    quote instance-type quote
;

instance-type:
    "t2.micro"  | "t2.small"   | "t2.medium"  |
    "m3.medium" | "m3.large"   | "m3.xlarge"  | "m3.2xlarge" |
    "c3.large"  | "c3.xlarge"  | "c3.2xlarge" | "c3.3xlarge" | "c3.8xlarge" |
    "c4.large"  | "c4.xlarge"  | "c4.2xlarge" | "c4.4xlarge" | "c4.8xlarge" |
    "r3.large"  | "r3.xlarge"  | "r3.2xlarge" | "r3.3xlarge" | "r3.8xlarge" |
    "i2.xlarge" | "i2.2xlarge" | "i2.2xlarge" | "i2.8xlarge"
;

image-id-property: quote "ImageId" quote white-space ":" white-space quote ami-id quote ;

ami-id: "ami-" hex-digit hex-digit hex-digit hex-digit 
               hex-digit hex-digit hex-digit hex-digit ;

resource-name: quote identifier quote ;

identifier: consonant vowel consonant vowel consonant ;
consonant:
    "b" | "c" | "d" | "f" | "g" | "h" | "j" | "k" | "l" |
    "m" | "n" | "p" | "r" | "s" | "t" | "v" | "w" | "z"
;
vowel: "a" | "e" | "i" | "o" | "u" ;

hex-digit:      "a" | "b" | "c" | "d" | "e" | "f" |
    "0" | "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9" ;

quote: "\"" ;
new-line: "\n" ;
white-space: " " ;

// vim:autoindent expandtab sw=4
