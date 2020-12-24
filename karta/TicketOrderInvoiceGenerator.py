import os
import copy
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

validnaSjedista = []
for slovo in string.ascii_letters[0:7]:
    for broj in range(1,6):
        validnaSjedista.append(slovo.upper() + str(broj))

def GenerisiPermutacijeSjedista(kupljenoKarti):
    permutacija = []
    kopijaMjesta = copy.deepcopy(validnaSjedista)

    for i in range(kupljenoKarti):
        index = random.randint(0,kupljenoKarti-i-1)
        permutacija.append(kopijaMjesta[index])
        del kopijaMjesta[index] 

    return permutacija

#endregion

#region Inicijalizacija

#region Fajlovi 

transkacijeBackup = open(os.path.join("karta/sql/backup.sql"),"w",encoding="utf-8")
transakcijeSarajevo = open(os.path.join("karta/sql/transakcijeSarajevo.sql"),"w",encoding="utf-8")
transakcijeMostar = open(os.path.join("karta/sql/transakcijeMostar.sql"),"w",encoding="utf-8")
transakcijeTuzla = open(os.path.join("karta/sql/transakcijeTuzla.sql"),"w",encoding="utf-8")
transakcijeBanjaLuka = open(os.path.join("karta/sql/transakcijeBanjaLuka.sql"),"w",encoding="utf-8")
transakcijeBihac = open(os.path.join("karta/sql/transakcijeBihac.sql"),"w",encoding="utf-8")

fileAccessor = [transakcijeSarajevo,transakcijeMostar,transakcijeTuzla,transakcijeBanjaLuka,transakcijeBihac]

ratingBackup = open(os.path.join("NoDB/backup.csv"),"w",encoding="utf-8")
ratingSarajevo = open(os.path.join("NoDB/ratingSarajevo.csv"),"w",encoding="utf-8")
ratingMostar = open(os.path.join("NoDB/ratingMostar.csv"),"w",encoding="utf-8")
ratingTuzla = open(os.path.join("NoDB/ratingTuzla.csv"),"w",encoding="utf-8")
ratingBanjaLuka = open(os.path.join("NoDB/ratingBanjaLuka.csv"),"w",encoding="utf-8")
ratingBihac = open(os.path.join("NoDB/ratingBihac.csv"),"w",encoding="utf-8")

ratingAccessor = [ratingSarajevo,ratingMostar,ratingTuzla,ratingBanjaLuka,ratingBihac]

#endregion

outputSQL = "" # Čuva samo SQL od grada koji se obrađuje
globalOutputSQL = "" # Čuva čitav SQL

ratingOutput = "" # Čuva samo rating od projekcije koja se obrađuje
globalRatingOutput = "" # Čuva čitav rating

brojGradova = 5

gradovi = ['Sarajevo','Mostar','Tuzla','Banja Luka','Bihac']
brojSala = [5,4,4,4,3] # po gradovima
kapacitetiSala = [
    [35,10,10,15,10],
    [25,10,15,10],
    [20,10,10,10],
    [15,10,10,10],
    [20,10,10]
] # po gradovima

brojFilmova = 44
brojSedmica = 11

dani = ['ponedeljak','utorak','srijeda','cetvrtak','petak']
danaUSedmici = 5

projekcijaPoDanu = 5
vrijemePrikazivanja = [11,13,15,18,20] 
projekcijaPoFilmu = 5

datum = datetime.datetime(2019,1,7) # Prvi ponedeljak u januaru 2019, datum otvorenja kina

identities = []
with open(os.path.join("karta/source/identities.csv"),"r",encoding="utf-8") as f:
    for x in f.read().split("\n"):
        if(len(x) > 0):
            identities.append(x.split(";"))

prosjecnaOcjenaKina = 5
prosjecnaOcjenaUsluge = 4

globalKarta = 1 # Logički ID karte, odraz onog u bazi
globalNarudzba = 1 # Logički ID narudžbe, odraz onog u bazi
globalRacun = 1 # Logički ID računa, odraz onog u bazi
globalRezervacijaId = 1 # Logički ID rezervacije, odraz onog u bazi
globalRating = 1 # Logički ID računa, odraz onog u fajlu

#endregion

for kino in range(brojGradova):
    
    print("Generisanje za grad " + gradovi[kino] + "...")
    
    datum = datetime.datetime(2019,1,7)

    for film in range(1,brojFilmova+1):
        
        print("Generisanje za film " + str(film) + "...")
        
        for dan in range(projekcijaPoDanu):        
            
            for projekcija in range(projekcijaPoFilmu): 
                
                kapacitetSale = kapacitetiSala[kino][film % brojSala[kino]]
                kupljenoKarti = random.randint(kapacitetSale - 5, kapacitetSale) # Koliko je karti kupljeno za projekcju
                
                odabranaSjedista = GenerisiPermutacijeSjedista(kupljenoKarti)
                sjedisteId = 0

                for karta in range(kupljenoKarti):
                    
                    #region Rezervacija SQL
                    
                    jeRezervisana = False

                    if(random.randint(0,100) <= 10):
                        
                        rezervacijaSql = "INSERT INTO dbo.rezervacija(kinoId,filmId,tipRezervacijeId,ime,prezime,kontaktTelefon,adresa,jePlaceno,datum) VALUES ("
                        
                        identitet = identities[random.randint(0,len(identities) - 1)]

                        values = [
                            kino + 1,
                            film,
                            random.randint(1,4),
                            literalString(identitet[0]),
                            literalString(identitet[1]),
                            literalString(identitet[2]),
                            literalString(identitet[3]).replace(".",""),
                            0 if random.randint(0,110) % 2 == 0 else 1,
                            literalString(SQLDate(datum))
                        ]

                        outputSQL += SQLCommaDelimitedValues(initialSQL=rezervacijaSql,values=values) + "\n"
                        jeRezervisana = True

                    #endregion

                    #region Karta SQL
                    
                    kartaSql = "INSERT INTO dbo.karta(filmId,rezervacijaId,salaId,cijena,jeIskoristena,vrijemePrikazivanja,sjediste) VALUES ("
                    
                    values = [
                        film,
                        str(globalRezervacijaId) if jeRezervisana else "null",
                        str(projekcija + 1),
                        7 if random.randint(0,10) <= 7 else 5 if random.randint(0,10) <= 7 else 3.5,
                        0 if random.randint(0,200) == 54 else 1, # Tehnički svaka 54 karta (u prosjeku) neće biti iskorištena
                        literalString(SQLDateTime(datum,vrijemePrikazivanja[film % 5])),
                        literalString(odabranaSjedista[sjedisteId])
                    ]

                    outputSQL += SQLCommaDelimitedValues(initialSQL=kartaSql,values=values) + "\n"

                    #endregion
                    
                    #region Racun SQL

                    racunSql = "INSERT INTO dbo.racun (kinoId,kartaId,tipPlacanjaId,datum) VALUES ("
                    
                    values = [
                        kino + 1,
                        str(globalKarta),
                        str(1 if random.randint(0,22) <= 11 else random.randint(2,11)), # U prosjeku se u pola slučajeva generiše gotovinsko dok u drugim random kartično plaćanje
                        literalString(SQLDateTime(datum,vrijemePrikazivanja[film % 5]))
                    ]
                    
                    outputSQL += SQLCommaDelimitedValues(initialSQL=racunSql,values=values) + "\n"

                    #endregion

                    #region Narudzba SQL

                    faktorNarudzbe = random.randint(0,10) # Služi za određivanje broja narudžbi
                    brojNarudzbi =  0 if faktorNarudzbe == 0 else \
                                    1 if faktorNarudzbe <= 5 else \
                                    2 if faktorNarudzbe <= 7 else 3 # U prosjeku 4 od 6 slučajeva daje 1 narudžbu dok ostala dva slučaja generišu 2 ili 3  

                    if(brojNarudzbi > 0):
                        for i in range(brojNarudzbi):
                            narudzbaSql = "INSERT INTO dbo.narudzba (racunId,tipNarudzbeId,datum) VALUES ("

                            values = [
                                globalRacun,
                                str(random.randint(1,50)),
                                literalString(SQLDateTime(datum,vrijemePrikazivanja[film % 5])),
                            ]

                            outputSQL += SQLCommaDelimitedValues(initialSQL=narudzbaSql,values=values) + "\n"

                    #endregion
        
                    globalKarta += 1 # Povećava logički ID karte
                    globalRacun += 1 # Povećava logički ID racuna
                    sjedisteId += 1 # Povećava logički ID sjedista
                    globalNarudzba += 1 # Povećava logički ID sjedista
                    
                    if(jeRezervisana): 
                        globalRezervacijaId += 1

                #region Rating/Ocjene
                
                brojUtisaka = random.randint(int(kupljenoKarti/2),kupljenoKarti) # Pretpostavljamo da neće svi kupiti kartu
                prosjecnaOcjenaFilma = random.randint(1,5)

                for i in range(brojUtisaka):
                    ratingOutput += ','.join([
                        str(globalRating),
                        str(kino + 1),
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

    globalOutputSQL += outputSQL
    outputSQL = ""

    ratingAccessor[kino].write(str(ratingOutput))
    ratingAccessor[kino].close()

    globalRatingOutput += ratingOutput
    ratingOutput = ""

transkacijeBackup.write(str(globalOutputSQL))
transkacijeBackup.close()

ratingBackup.write(str(globalRatingOutput))
ratingBackup.close()
