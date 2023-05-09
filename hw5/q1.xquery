for $a in distinct-values(doc("JohnLHennessy.xml")//r/*/author[@pid!="h/JohnLHennessy"])
let $count  := count(doc("JohnLHennessy.xml")//r/*[author=$a])
order by $count descending
return
   <author name="{$a}" count="{$count}"/>
