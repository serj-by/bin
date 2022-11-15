#! /usr/bin/env python3
lcb, rcb="{", "}"
USAGE=f"""
  Description:
  Filters SQL fil according to second --sections= param using following syntax in .sql file:
  -- {lcb} @myimport-section drops {rcb}
  <sql here>
  -- {lcb} @/myimport-section drops {rcb}
  Usage:
  {__file__} <SQL-name> [<comma-separated sections like drops,creates omit for whole file output>]
"""
import re, sys

with open (sys.argv[1]) as f:
	t = f.read ()





sections=re.findall("--sections=([\w\d\,]+)$", sys.argv[2])
if sections is not None and len(sections)==1:
	sections=sections[0].replace (",", "|")
	m = re.findall("--\s+{ @myimport-section ("+sections+") }\s+([^-]+)\s+--", t, re.MULTILINE)
	res="\n".join (["-- Section "+t[0]+"\n"+t[1] for t in m])
	print (res)
else:
	print ("-- no param --sections specified. Using whole file.")
	print (t)
