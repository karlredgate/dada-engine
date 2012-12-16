
#include "base.pb"

object:
    http_0_9_request  |
    http_1_x_request  |
    http_1_x_response ;

good_http_request  : http_0_9_request | http_1_x_request ;
good_http_response : http_1_x_response ;

http_0_9_request : method space uri crlf ;
http_1_x_request : request_line headers crlf ;
http_1_x_response: response_line headers crlf ;

request_line: method space uri space version crlf ;
response_line:
    version space response_code space response_message crlf ;

method: "GET" | "POST" | "HEAD" ;
uri: [authority | "" | ""] "/" path ;
version: "HTTP/1.0" | "HTTP/1.1" ;

headers: header* ;

header: valid_header | random_header ;

valid_header : known_header_name hws* ":" hws* header_value crlf ;
random_header: known_header_name hws* ":" hws* header_value crlf ;

header_name:
    known_header_name |
    known_header_name |
    known_header_name |
    random_header_name ;
random_header_name: lowercase+ ;
header_value: lowercase+ | cookie_list ;

response_code: { = 100..505 } ;
response_message: ascii* ;

known_header_name:
    "Connection" |
    "Content-Length" |
    "Host" |
    "Transfer-Encoding" | 
    "Cookie"
    ;

known_request_header:
    Accept | 
    Accept-Charset | 
    Cookie
    ;

# Request headers
Accept:          "Accept" ":" ;
Accept-Charset:  "Accept-Charset" ":" ;
Accept-Encoding: "Accept-Encoding" ":" ;
Accept-Language: "Accept-Language" ":" ;
Authorization:   "Authorization" ":" ;
Expect:          "Expect" ":" ;
From:          "From" ":" ;
Host:          "Host" ":" ;
If-Match:          "If-Match" ":" ;
If-Modified-Since:          "If-Modified-Since" ":" ;
If-None-Match:          "If-None-Match" ":" ;
If-Range:          "If-Range" ":" ;
If-Unmodified-Since:          "If-Unmodified-Since" ":" ;
Max-Forwards: "Max-Forwards" ":" ;
Proxy-Authorization: "Proxy-Authorization" ":" credentials ;
credentials: "" ;
Referer: "Referer" ":" ;
TE: "TE" ":" ;
User-Agent: "User-Agent" ":" ;

# Special request header
Cookie:          "Cookie" ":" ;

# Response headers
Accept-Ranges: "Accept-Ranges" ":" ;
Age:          "Age" ":" ;
ETag:          "ETag" ":" ;
Location: "Location" ":" ;
Vary: "Vary" ":" ;


Proxy-Authenticate: "Proxy-Authenticate" ":" challenge ;
challenge: "" ;

Retry-After: "Retry-After" ":" ;
Server: "Server" ":" ;
WWW-Authenticate: "WWW-Authenticate" ":" ;


# Entity headers
Allow:          "Allow" ":" ;
Content-Encoding: "Content-Encoding" ":" ;
Content-Language: "Content-Language" ":" ;
Content-Length: "Content-Length" ":" ;
Content-Location: "Content-Location" ":" ;
Content-MD5: "Content-MD5" ":" ;
Content-Range: "Content-Range" ":" ;
Content-Type: "Content-Type" ":" ;
Expires:          "Expires" ":" ;
Last-Modified: "Last-Modified" ":" ;
Range: "Range" ":" ;

# General headers
Cache-Control: "Cache-Control" ":" ;
Connection:    "Connection" ":" ;
Date: "Date" ":" ;
Pragma: "Pragma" ":" ;
Trailer: "Trailer" ":" ;
Transfer-Encoding: "Transfer-Encoding" ":" ;
Upgrade: "Upgrade" ":" product ;
product: "HTTP/1.1" | "HTTP/2.0" | "SHTTP/1.3" ;
Via: "Via" ":" ;
Warning: "Warning" ":" ;


authority: scheme "://" host port ;
scheme: "http" | "ftp" ;
host: host_segment | host_path "." tld ;
host_path: host_segment | host "." host_segment ;
host_segment: known_host_segment | random_host_segment ;
random_host_segment: alphanum+ ;
known_host_segment:
    "cnn" | "yahoo" | "sun" | "google" | "lycos" | "ibm" |
    "microsoft" | "sgi" | "sourceforge"
    ;

tld: "com" | "edu" | "gov" | "org" ;
ccTLD:
    "uk" | "to" | "au" | "ca" | "it"
    "us" ;

known_domain:
    "www.cnn.com" | "www.sun.com" | "google.com" |
    "www.yahoo.com" | "movies.yahoo.com" | "finance.yahoo.com" |
    "lycos.com" | "www.ibm.com" |
    "prep.ai.mit.edu" |
    "www.gnu.org" | "www.apache.org" | "www.gnome.org" | "www.kernel.org" |
    "www.sgi.com" | "sourceforge.com" |
    "www.microsoft.com" | "www.intel.com"
    ;

port: ":" Integer | "" ;

path: path_segment | path "/" path_segment ;
path_segment: alphanum+ | alphanum* ;

cookie_list:
    cookie |
    cookie_list hws* ";" hws* cookie ;
cookie: canon_cookie ;
canon_cookie: cookie_name "=" cookie_value ;
cookie_name: alphanum+ ;
cookie_value: alphanum+ ;
