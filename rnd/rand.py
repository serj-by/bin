#!/usr/bin/env python3
import sys, random
minn=1
print ("argv",sys.argv)
maxn=int(sys.argv[1] if len(sys.argv)>=2 else 29)
print (f"Choosing between {minn} and {maxn}:")
print (random.randint(1,maxn))