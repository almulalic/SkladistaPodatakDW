import datetime
import os
import random
import string

sqlFile = open(os.path.join("karta/","kartaNarudzbaRacun.sql"),"w")

brojSedmica = 11
projekcijaPoDanu = 5
projekcijaPoFilmu = 5
danaUSedmici = 5
brojSala = 5

vrijemePrikazivanja = [11,13,15,18,20]
kapacitetiSala = [33,10,10,13,11]


cijeneNarudzba =  [3,4,5,2,2.5,3,3,3,2.5,3,3,2,3,3,2,2.5,3,3,2,2.5,3,3,4.5,5.5,6.5,5,6,7,5,3,5,3,5,3,2.5,3.5,2.5,2.5,2.5,2.5,2.5,2.5,2.5,2.5,4.5,3.5,2.5,3.5,2.5,3.5]

finalniSql = ""
datum = datetime.datetime(2019,1,7)

globalKarta = 1
globalNarudzba = 1
globalRacun = 1

for film in range(1,44):
    for dan in range(projekcijaPoDanu):
        for projekcija in range(projekcijaPoFilmu):
            finalniSql += "/* Projekcija " + str(dan) + " Karte Za Dan " + datum.strftime("%Y-%m-%d") + " */" + "\n"
            kupljenoKarti = random.randint(kapacitetiSala[film % 5] - 10, kapacitetiSala[film % 5])
            sjedisteId = 1
            sjedistaSlova = string.ascii_letters
            redSlovo = 0
            for karta in range(kupljenoKarti):
             
                kartaSql = "INSERT INTO dbo.karta(filmId,cijena,jeIskoristena,sala,vrijemePrikazivanja,sjediste) VALUES ("
                
                values = [
                    film,
                    7,
                    0 if random.randint(0,200) == 54 else 1,
                    str(projekcija + 1),
                    "'" + datetime.datetime(datum.year,datum.month,datum.day,vrijemePrikazivanja[film % 5],0,0).strftime("%Y-%m-%d %H:%M:%S") + "'",
                    "'" + random.choice(sjedistaSlova[redSlovo]).upper() + str(sjedisteId) + "'"
                ]

                for i in range(len(values)):
                    kartaSql += str(values[i]);
                    if(i < len(values) - 1):
                        kartaSql += ", "

                
                kartaSql += ");"
                finalniSql += kartaSql + "\n"

                racunSql = "INSERT INTO dbo.racun (kinoId,kartaId,datum,tipPlacanjaId) VALUES ("
                racunSql += "1," + str(globalKarta) + ","
                racunSql += "'" + datetime.datetime(datum.year,datum.month,datum.day,vrijemePrikazivanja[film % 5],0,0).strftime("%Y-%m-%d %H:%M:%S") + "', "
                racunSql += str(1 if random.randint(0,22) <= 11 else random.randint(2,11))
                racunSql += ");"                

                finalniSql += racunSql + "\n"

                updateKarte = "UPDATE dbo.racun SET kartaId = " + str(globalKarta) + " WHERE id = " + str(globalRacun) + ";"

                finalniSql += updateKarte + "\n"
                
                randNarudzbi = random.randint(0,5)
                brojNarudzbi = 1 if randNarudzbi <= 3 else 2 if randNarudzbi == 4 else 5
        
                for i in range(brojNarudzbi):
                    narudzbaSql = "INSERT INTO dbo.narudzba (narudzbaTipId,racunId,datum) VALUES ("
                    narudzbaSql += str(random.randint(1,50)) + ", "
                    narudzbaSql += str(globalRacun) + ", "
                    narudzbaSql += "'" + datetime.datetime(datum.year,datum.month,datum.day,vrijemePrikazivanja[film % 5],0,0).strftime("%Y-%m-%d %H:%M:%S") + "'" 
                    narudzbaSql += ");"
                    finalniSql += narudzbaSql + "\n"
                    globalNarudzba += 1


                globalKarta+=1
                globalRacun+=1
                sjedisteId+=1

                if(sjedisteId > 5):
                    redSlovo += 1
                
        finalniSql += "/* Kraj dana \n */"
        datum = datum + datetime.timedelta(days=1)

        if(datum.weekday() == 5):
            datum = datum + datetime.timedelta(days=2)

    finalniSql += "/* Kraj filma \n */"

sqlFile.write(finalniSql)

sqlFile.close()
