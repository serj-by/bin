#! /usr/bin/en python3
import re, sys

with open (sys.argv[1]) as f:
	t = f.read ()






sections=re.findall("--sections=([\w\d|]+)$", sys.argv[1])
print ("arg", sys.argv[2])
print ("si", sections)
if sections is not None:
	sections=[s[0] for s in sections]
	m = re.findall("--\s+{ @myimport-section ("+sections+") }\s+([^-]+)\s+--", t, re.MULTILINE)
	res="\n".join ([t[1] for t in m])
	print (m, res)
else:
	print ("-- no param --sections pecified. Using whole file.")
	print (t)
