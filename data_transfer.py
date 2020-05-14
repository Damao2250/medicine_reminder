import sys
import os
import csv
import codecs
import json

cnt = 1
l = []

"""csv文件有3列，分别是：药品名字，用药注意事项，老年人用药安全"""

with open('data.txt','w') as h:

    with open('qwe.csv','r') as f :
        fc = csv.reader(f)
        for r in fc :
            s = "Warn("+str(cnt)+",'" +r[0]+"','"+r[0]+"，"+r[1]+"','"+r[2]+"','"+r[3]+"'),"
            s = s.replace('\n', '').replace('\r', '')
            print(s)
            h.write(s+"\n")
            # l.append(r)
            cnt = cnt + 1


# with open('data.json','w') as g:
#     json.dump(l,g)
    
