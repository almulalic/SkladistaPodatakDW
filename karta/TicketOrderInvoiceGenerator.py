import os
import random
import string
import datetime

sqlFile = open(os.path.join("karta/","kartaNarudzbaRacun.sql"),"w")

#region Helper Functions

def literalString(string): # Dodaje SQL navodnike oko arugmenta
    return "'" + string + "'" 

def SQLDate(datum): # Formatira u SQL string datum
    return datetime.datetime(datum.year,datum.month,datum.day).strftime("%Y-%m-%d")

def SQLDateTime(datum,sati,minute=0,sekunde=0): # Formatira u SQL string datetime
    return datetime.datetime(datum.year,datum.month,datum.day,sati,minute,sekunde).strftime("%Y-%m-%d %H:%M:%S")

def SQLCommaDelimitedValues(initialSQL="",values=[],closeBracket=True): # Pretvara vrijednosti u VALUES formu koja navodi parametre u zageradam odvojene zarezom
    for i in range(len(values)):
        initialSQL += str(values[i])
        if(i < len(values) - 1):
            initialSQL += ", "
    
    if(closeBracket): initialSQL+= ");"

    return initialSQL

#endregion

#region Inicijalizacija

brojFilmova = 44
brojSedmica = 11
projekcijaPoDanu = 5
projekcijaPoFilmu = 5
danaUSedmici = 5
brojSala = 5

vrijemePrikazivanja = [11,13,15,18,20] # u satima
kapacitetiSala = [33,10,10,13,11] 

cijeneNarudzba =  [3,4,5,2,2.5,3,3,3,2.5,3,3,2,3,3,2,2.5,3,3,2,2.5,3,3,4.5,5.5,6.5,5,6,7,5,3,5,3,5,3,2.5,3.5,2.5,2.5,2.5,2.5,2.5,2.5,2.5,2.5,4.5,3.5,2.5,3.5,2.5,3.5]

finalniSql = ""
datum = datetime.datetime(2019,1,7) # Prvi ponedeljak u januaru 2019, datum otvorenja kina

globalKarta = 1 # Logički ID karte, odraz onog u bazi
globalNarudzba = 1 # Logički ID narudžbe, odraz onog u bazi
globalRacun = 1 # Logički ID računa, odraz onog u bazi

sjedistaSlova = string.ascii_letters # Generisanje slova za sjedišta

#endregion

for film in range(brojFilmova):
    for dan in range(projekcijaPoDanu):
        for projekcija in range(projekcijaPoFilmu):
            finalniSql += "/* Projekcija po redu: " + str(dan + 1) + " ,Karte Za Dan " + datum.strftime("%Y-%m-%d") + " */" + "\n"

            kupljenoKarti = random.randint(kapacitetiSala[film % 5] - 10, kapacitetiSala[film % 5]) # Koliko je karti kupljeno za projekcju
            sjedisteId = 1
            redSlovo = 0
            
            for karta in range(kupljenoKarti):
   
                #region Karta SQL

                kartaSql = "INSERT INTO dbo.karta(filmId,cijena,jeIskoristena,sala,vrijemePrikazivanja,sjediste) VALUES ("
                
                values = [
                    film,
                    7,
                    0 if random.randint(0,200) == 54 else 1, # Tehnički svaka 54 karta (u prosjeku) neće biti iskorištena
                    str(projekcija + 1),
                    literalString(SQLDate(datum)),
                    literalString(random.choice(sjedistaSlova[redSlovo]).upper() + str(sjedisteId))
                ]

                finalniSql += SQLCommaDelimitedValues(initialSQL=kartaSql,values=values) + "\n"
                
                #endregion
                
                #region Narudzba SQL

                faktorNarudzbe = random.randint(0,5) # Služi za određivanje broja narudžbi
                brojNarudzbi = 1 if faktorNarudzbe <= 3 else 2 if faktorNarudzbe == 4 else 3 # U prosjeku 4 od 6 slučajeva daje 1 narudžbu dok ostala dva slučaja generišu 2 ili 3  

                keyNarudzbe = globalNarudzba + 1
                for i in range(brojNarudzbi):
                    narudzbaSql = "INSERT INTO dbo.narudzba (narudzbaKey,narudzbaTipId,racunId,datum) VALUES ("

                    values = [
                        literalString("NAR-" + str(keyNarudzbe)),
                        str(random.randint(1,50)),
                        str(globalRacun),
                        literalString(SQLDateTime(datum,vrijemePrikazivanja[film % 5])),
                    ]

                    finalniSql += SQLCommaDelimitedValues(initialSQL=narudzbaSql,values=values) + "\n"
                
                    globalNarudzba += 1 # Povećava logički ID narudžbe

                #endregion

                #region Racun SQL

                racunSql = "INSERT INTO dbo.racun (kinoId,kartaId,narudzbaKey,datum,tipPlacanjaId) VALUES ("
                
                values = [
                    "1" + str(globalKarta),
                    literalString(SQLDateTime(datum,vrijemePrikazivanja[film % 5])),
                    str(1 if random.randint(0,22) <= 11 else random.randint(2,11)) # U prosjeku se u pola slučajeva generiše gotovinsko dok u drugim random kartično plaćanje
                ]
                
                finalniSql += SQLCommaDelimitedValues(initialSQL=racunSql,values=values) + "\n"

                #endregion

                globalKarta += 1 # Povećava logički ID karte
                globalRacun += 1 # Povećava logički ID racuna
                sjedisteId += 1 # Povećava logički ID sjedista

                if(sjedisteId > 5):
                    redSlovo += 1
                
        finalniSql += "/* Kraj dana */ \n"

        datum = datum + datetime.timedelta(days=1) # Povećavamo dan za 1

        if(datum.weekday() == 5): # Ukoliko je petak preskoči do ponedeljka
            datum = datum + datetime.timedelta(days=2)

    finalniSql += "/* Kraj filma */ \n"

sqlFile.write(finalniSql)
sqlFile.close()
