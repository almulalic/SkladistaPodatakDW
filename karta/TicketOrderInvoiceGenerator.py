import os
import random
import string
import datetime

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

#region Fajlovi 

transakcijeSarajevo = open(os.path.join("karta/sql/transakcijeSarajevo.sql"),"w",encoding="utf-8")
transakcijeMostar = open(os.path.join("karta/sql/transakcijeMostar.sql"),"w",encoding="utf-8")
transakcijeTuzla = open(os.path.join("karta/sql/transakcijeTuzla.sql"),"w",encoding="utf-8")
transakcijeBanjaLuka = open(os.path.join("karta/sql/transakcijeBanjaLuka.sql"),"w",encoding="utf-8")
transakcijeBihac = open(os.path.join("karta/sql/transakcijeBihac.sql"),"w",encoding="utf-8")

fileAccessor = [transakcijeSarajevo,transakcijeMostar,transakcijeTuzla,transakcijeBanjaLuka,transakcijeBihac]

ratingSarajevo = open(os.path.join("NoDB/ratingSarajevo.csv"),"w")
ratingMostar = open(os.path.join("NoDB/ratingMostar.csv"),"w")
ratingTuzla = open(os.path.join("NoDB/ratingTuzla.csv"),"w")
ratingBanjaLuka = open(os.path.join("NoDB/ratingBanjaLuka.csv"),"w")
ratingBihac = open(os.path.join("NoDB/ratingBihac.csv"),"w")

ratingAccessor = [ratingSarajevo,ratingMostar,ratingTuzla,ratingBanjaLuka,ratingBihac]

#endregion

outputSQL = ""

brojGradova = 5

gradovi = ['Sarajevo','Mostar','Tuzla','Banja Luka','Mostar']
brojSala = [5,4,4,4,3] # po gradovima
kapacitetiSala = [
    [33,10,10,13,11],
    [25,10,15,10],
    [20,10,10,10],
    [25,10,10,10],
    [20,10,10]
] # po gradovima

brojFilmova = 44
brojSedmica = 11

danaUSedmici = 5

projekcijaPoDanu = 5
vrijemePrikazivanja = [11,13,15,18,20] 
projekcijaPoFilmu = 5

datum = datetime.datetime(2019,1,7) # Prvi ponedeljak u januaru 2019, datum otvorenja kina

sjedistaSlova = string.ascii_letters # Generisanje slova za sjedišta

identities = []
with open(os.path.join("karta/source/identities.csv"),"r",encoding="utf-8") as f:
    for x in f.read().split("\n"):
        if(len(x) > 0):
            identities.append(x.split(";"))

ratingOutputSQL = ""
prosjecnaOcjenaKina = 5
prosjecnaOcjenaUsluge = 4

globalKarta = 1 # Logički ID karte, odraz onog u bazi
globalNarudzba = 1 # Logički ID narudžbe, odraz onog u bazi
globalRacun = 1 # Logički ID računa, odraz onog u bazi
globalRating = 1 # Logički ID računa, odraz onog u fajlu

#endregion

for kino in range(brojGradova):

    for film in range(1,brojFilmova+1):
      
        for dan in range(projekcijaPoDanu):        
           
            for projekcija in range(projekcijaPoFilmu): 

                kupljenoKarti = random.randint(kapacitetiSala[kino][film % brojSala[kino]] - 5, kapacitetiSala[kino][film % brojSala[kino]]) # Koliko je karti kupljeno za projekcju
                sjedisteId = 1
                redSlovo = 0
                
                for karta in range(kupljenoKarti):
    
                    #region Rezervacija SQL
                    
                    if(random.randint(0,100) % 40 == 0):

                        rezervacijaSql = "INSERT INTO dbo.rezervacija(ime,prezime,kontaktTelefon,adresa,jePlaceno,kinoId,filmId,tipRezervacijeId,datum) VALUES ("
                        
                        identitet = identities[random.randint(0,len(identities) - 1)]

                        values = [
                            literalString(identitet[0]),
                            literalString(identitet[1]),
                            literalString(identitet[2]),
                            literalString(identitet[3]).replace(".",""),
                            0 if random.randint(0,110) % 2 == 0 else 1,
                            kino + 1,
                            film,
                            random.randint(1,4),
                            literalString(SQLDate(datum))
                        ]

                        outputSQL += SQLCommaDelimitedValues(initialSQL=rezervacijaSql,values=values) + "\n"
                    
                    #endregion

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

                    outputSQL += SQLCommaDelimitedValues(initialSQL=kartaSql,values=values) + "\n"
                    
                    #endregion
                    
                    #region Narudzba SQL

                    faktorNarudzbe = random.randint(0,10) # Služi za određivanje broja narudžbi
                    brojNarudzbi =  0 if faktorNarudzbe == 0 else \
                                    1 if faktorNarudzbe <= 5 else \
                                    2 if faktorNarudzbe <= 7 else 3 # U prosjeku 4 od 6 slučajeva daje 1 narudžbu dok ostala dva slučaja generišu 2 ili 3  

                    keyNarudzbe = globalNarudzba
                    if(brojNarudzbi > 0):
                        for i in range(brojNarudzbi):
                            narudzbaSql = "INSERT INTO dbo.narudzba (narudzbaKey,narudzbaTipId,datum) VALUES ("

                            values = [
                                literalString("NAR-" + str(keyNarudzbe)),
                                str(random.randint(1,50)),
                                literalString(SQLDateTime(datum,vrijemePrikazivanja[film % 5])),
                            ]

                            outputSQL += SQLCommaDelimitedValues(initialSQL=narudzbaSql,values=values) + "\n"
                    else:
                        keyNarudzbe = "null"

                    #endregion

                    #region Racun SQL

                    racunSql = "INSERT INTO dbo.racun (kinoId,kartaId,narudzbaKey,datum,tipPlacanjaId) VALUES ("
                    
                    values = [
                        kino + 1,
                        str(globalKarta),
                        literalString("NAR-" + str(keyNarudzbe)),
                        literalString(SQLDateTime(datum,vrijemePrikazivanja[film % 5])),
                        str(1 if random.randint(0,22) <= 11 else random.randint(2,11)) # U prosjeku se u pola slučajeva generiše gotovinsko dok u drugim random kartično plaćanje
                    ]
                    
                    outputSQL += SQLCommaDelimitedValues(initialSQL=racunSql,values=values) + "\n"

                    #endregion
        

                    globalKarta += 1 # Povećava logički ID karte
                    globalRacun += 1 # Povećava logički ID racuna
                    sjedisteId += 1 # Povećava logički ID sjedista
                    globalNarudzba += 1 # Povećava logički ID sjedista

                    if(sjedisteId > 5):
                        redSlovo += 1

                #region Rating/Ocjene
                        
                brojUtisaka = random.randint(int(kupljenoKarti/2),kupljenoKarti) # Pretpostavljamo da neće svi kupiti kartu
                prosjecnaOcjenaFilma = random.randint(1,5)

                for i in range(brojUtisaka):
                    ratingOutputSQL += ','.join([
                        str(kino + 1),
                        str(globalRating),
                        str(prosjecnaOcjenaKina if random.randint(0,10) <= 7 else random.randint(1,5)),
                        str(prosjecnaOcjenaUsluge if random.randint(0,10) <= 5 else random.randint(1,5)),
                        str(prosjecnaOcjenaFilma if random.randint(0,10) <= 6 else random.randint(1,5)),
                        str(datum)
                    ]) + "\n"
                    globalRating+=1

                #endregion   

            datum = datum + datetime.timedelta(days=1) # Povećavamo dan za 1

            if(datum.weekday() == 5): # Ukoliko je petak preskoči do ponedeljka
                datum = datum + datetime.timedelta(days=2)
        
        
    fileAccessor[kino].write(str(outputSQL))
    fileAccessor[kino].close()

    # ratingAccessor[kino].write(str(outputSQL))
    # ratingAccessor[kino].close()

    outputSQL = ""
