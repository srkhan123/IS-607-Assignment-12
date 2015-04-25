


#install.packages("rmongodb")

library(rmongodb)

m <- mongo.create()

#List of databases in mongodb
mongo.get.databases(m)

#list of collections in dbbooks
mongo.get.database.collections(m, db = "dbBooks")

#number of documents in collection
mongo.count(m, ns = "dbBooks.Books")

DBNS = "dbBooks.Books"
#is mongo connected?
mongo.is.connected(m)

#look at first document
tmp = mongo.find.one(m, ns = DBNS)
tmp  #[1] "mongo.bson"

#put document in a list
tmp = mongo.bson.to.list(tmp)
class(tmp)

#Field headings
names(tmp)

#takes all records and puts in a list
find_all = mongo.find.all(m, ns = DBNS)
class(find_all) #[1] "list"
#-----------------------------------------------

library(plyr)
## create the empty data frame
bookid = data.frame(stringsAsFactors = FALSE)

#define collection
DBNS = "dbBooks.Books"

## create the cursor we will iterate over, basically a select * in SQL
cursor = mongo.find(m, DBNS)

## create the counter
#i = 1

## iterate over the cursor
while (mongo.cursor.next(cursor)) {
  # iterate and grab the next record
  tmp = mongo.bson.to.list(mongo.cursor.value(cursor))
  # make it a dataframe
  tmp.df = as.data.frame(t(unlist(tmp)), stringsAsFactors = F)
  # bind to the master dataframe
  bookid = rbind.fill(bookid, tmp.df)
  # to print a message, uncomment the next 2 lines cat('finished game ', i,
  # '\n') i = i +1
}


dim(bookid)

str(bookid)

View(bookid)


