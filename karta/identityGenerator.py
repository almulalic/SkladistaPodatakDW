import os
import random

def RandomTelefon():
    broj = ("033" if random.randint(0,10) < 5 else "06" + str(random.randint(0,5))) + "/"
    broj += str(random.randint(100,999)) + "-" + str(random.randint(100,999))
    return broj

namelistFile = open(os.path.join("karta/source/namelist.csv"), 'r',encoding='utf-8')
addressFile = open(os.path.join("karta/source/address.csv"), 'r',encoding='utf-8')
outputFile = open(os.path.join("karta/source/identities.csv"),"w",encoding='utf-8')

outputFileText = ""

identiteti = []
for red in namelistFile.read().split("\n"):
    if(len(red) > 0):
        identiteti.append(red.strip())
       
redovi = addressFile.read().split("\n")
for i in range(len(redovi)):
    if(len(redovi[i]) > 0):
        adresa = ""
        for rijec in redovi[i].replace(",","").rstrip().split(" "):
            adresa += rijec.lower().capitalize() + " "
    
        outputFileText += ';'.join(identiteti[i].split(" ")) + ";" + RandomTelefon() + ";" + adresa + str(random.randint(1,100)) + "," + "\n"
       

outputFile.write(str(outputFileText))

namelistFile.close()
addressFile.close()
outputFile.close()