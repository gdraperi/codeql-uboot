import cpp

from Macro m, MacroInvocation invoc
where m.getName() in  ["ntohs", "ntohl" , "ntohll"] and invoc.getMacro() = m
select invoc.getParentInvocation().getExpr(), "macro invoc"
