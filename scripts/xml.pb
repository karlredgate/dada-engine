
%resource xml-header: "<?xml version='1.0'?>\n" ;

rdf-document(namespaces body):
   start-tag-with-attributes("rdf:RDF" namespaces)
   body
   end-tag("rdf:RDF") ;

%resource    rdf-namespace: " xmlns:rdf='http://www.w3.org/1999/02/22-rdf-syntax-ns#'" ;
%resource   rdfs-namespace: " xmlns:rdfs='http://www.w3.org/2000/01/rdf-schema#'" ;
%resource    owl-namespace: " xmlns:owl='http://www.w3.org/2002/07/owl#'" ;
%resource     dc-namespace: " xmlns:dc='http://purl.org/dc/elements/1.1/'" ;
%resource dcterms-namespace: " xmlns:dcterms='http://purl.org/dc/terms/'" ;
%resource     dr-namespace: " xmlns:dr='http://carbonite.com/2014/09/dr'" ;

%resource start-tag(name) : "<" name ">" ;
%resource start-tag-with-attributes(name attributes) : "<" name "\n" attributes ">\n" ;
%resource end-tag(name) : "</" name ">\n" ;

%resource element(name content) : start-tag(name) content end-tag(name) ;
