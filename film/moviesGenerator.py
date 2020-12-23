import urllib.request
import json
import random
import os

dates = [
    ['2019-01-07','2019-01-14'],
    ['2019-01-14','2019-01-21'],
    ['2019-01-21','2019-01-28'],
    ['2019-01-28','2019-02-04'],
    ['2019-02-04','2019-02-11'],
    ['2019-02-11','2019-02-18'],
    ['2019-02-18','2019-02-25'],
    ['2019-02-25','2019-03-04'],
    ['2019-03-04','2019-03-11'],
    ['2019-03-11','2019-03-18'],
    ['2019-03-18','2019-03-25'],
]

jsonFile = open(os.path.join("film/","movies.json"),"w")
sqlFile = open(os.path.join("film/","movies.sql"),"w")

final = []
justInserts = []

def normalizeGenre(genreName):
    if(genreName == 'Documentary'):
        return 1
    elif(genreName == 'Drama'):
        return 2
    elif(genreName == 'History'):
        return 3
    elif(genreName == 'Animation'):
        return 4
    elif(genreName == 'Comedy'):
        return 5
    elif(genreName == 'Music'):
        return 6
    elif(genreName == 'Science Fiction'):
        return 7
    elif(genreName == 'Horror'):
        return 8
    elif(genreName == 'Mystery'):
        return 9
    elif(genreName == 'War'):
        return 10
    elif(genreName == 'Action'):
        return 11
    elif(genreName == 'Family'):
        return 12
    elif(genreName == 'Fantasy'):
        return 13
    elif(genreName == 'Adventure'):
        return 14
    elif(genreName == 'Romance'):
        return 15
    elif(genreName == 'Crime'):
        return 16
    elif(genreName == 'Thriller'):
        return 17

for date in dates:
    fetch = json.loads(urllib.request.urlopen("https://api.themoviedb.org/3/discover/movie//?api_key=ef57f4b4474cd9d6bd10f63b55c2bac9&primary_release_date.gte=" + date[0] + "&primary_release_date.lte=" + date[1] + "&sort_by=popularity.desc").read())['results']

    sqlList = []
    count = 1

    for movie in fetch:
        details = json.loads(urllib.request.urlopen("https://api.themoviedb.org/3/movie/" + str(movie['id']) + "?api_key=ef57f4b4474cd9d6bd10f63b55c2bac9").read())
        
        sql = "INSERT INTO dbo.film (naziv,zanrId,producent,datumIzdavanja,trajanjeUMinutama,dobnoOgranicenjeId,je3D,jeSinhronizovan,jeTitlovan,opis,procenatZarade) VALUES ("

        title = details['title'].replace("'","''")
        desc =  details['overview'].replace("'","''")
   
        values = [
            "'" + title + "'",
            normalizeGenre(details['genres'][0]['name']), 
            "null" if len(details['production_companies']) == 0 else "'" + details['production_companies'][0]['name'] + "'", 
            "'" + details['release_date'] + "'",
            details['runtime'],
            1 if random.randint(0,10) < 2 else 2 if random.randint(0,10) % 5 == 0 else 3 if random.randint(0,10) <= 7  else  4,
            1 if random.randint(0,100) <= 20 else 0, 
            1 if random.randint(0,100) <= 20 else 0, 
            1,
            "'" + desc + "'",
            random.randint(0,55)
        ]

        
        for i in range(len(values)):
            sql += str(values[i]) 

            if(i < len(values) - 1):
                sql+= ","
        
        sql+=");"
        
        if(count == 5):
            break
        
        count += 1
        sqlList.append(sql)
        justInserts.append(sql)

    red = dict(dateInterval = date[0] + " " + date[1],movies = sqlList)
    final.append(red)

arr = dict(data=final)
jsonFile.write(json.dumps(arr))

finalSql = ""
for insert in justInserts:
    finalSql += insert + "\n"

sqlFile.write(finalSql)

jsonFile.close()
sqlFile.close()

