#!/usr/bin/env python3
from random import *
import sys
trials_n=5
# if len(sys.argv)>1:
#     opts=sys.argv[1:]
# else:
opts=input().split()
resl=[]
for _ in range(trials_n):
    resl += [choice(opts)]
print(resl)
