#! /usr/bin/env python3
from random import choice
trials=1000
opts=["cin", "mate", "macos"]
lst=[choice(opts) for _ in range (opts)]
res=[(opt, lst.count(opts)) for opt in opts]
print (res)