import os
import random

def RandomTelefon():
    broj = ("033" if random.randint(0,10) < 5 else "06" + str(random.randint(0,5))) + "/"
    broj += str(random.randint(100,999)) + "-" + str(random.randint(100,999))
    return broj

namelist = open(os.path.join("karta/source/namelist.csv"), 'r',encoding='utf-8')
address = open(os.path.join("karta/source/address.csv"), 'r',encoding='utf-8')
output = open(os.path.join("karta/source/identities.csv"),"w",encoding='utf-8')

outputText = ""

identiteti = []
for red in namelist.read().split("\n"):
    if(len(red) > 0):
        identiteti.append(red.strip())
       
redovi = address.read().split("\n")
for i in range(len(redovi)):
    if(len(redovi[i]) > 0):
        adresa = ""
        for rijec in redovi[i].replace(",","").rstrip().split(" "):
            adresa += rijec.lower().capitalize() + " "
    
        outputText += ';'.join(identiteti[i].split(" ")) + ";" + RandomTelefon() + ";" + adresa + str(random.randint(1,100)) + "," + "\n"
       

output.write(str(outputText))