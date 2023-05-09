let $a := doc("JohnLHennessy.xml")//r/*/author[@pid!="h/JohnLHennessy"]
let $b := doc("DAPatterson.xml")//r/*/author[@pid!="p/DAPatterson"]
for $c in distinct-values($a)
where $c=distinct-values($b)
return

   <author>{$c}</author>
   

