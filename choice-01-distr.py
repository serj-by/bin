#! /usr/bin/env python3
from random import choice
global_trials=5
trials=1000
opts=["cin", "mate", "macos", "mx"]
globres=dict([(opt, 0) for opt in opts])
for i in range (global_trials):
    lst=[choice(opts) for _ in range (trials)]
    res=[(opt, lst.count(opt)) for opt in opts]
    print (res)
    resel=max(res, key=lambda e: e[1])
    print ("res="+str(resel))
    globres[resel[0]]+=1
print ("Global score: "+str(globres))