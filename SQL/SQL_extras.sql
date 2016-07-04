
########################################################################


#Using MySQLdump
#lock the tables you are backing up before running mysqldump

LOCK TABLES tab1 READ, tab2 READ ...;

UNLOCK TABLES;



#Dumping the publications database to a file
mysqldump -u user -p password publications > publications.sql



#Backing up a single table
mysqldump -u user -p password publications classics > classics.sql


#Backing up all tables
mysqldump -u user -p password --all-databases > all_databases.sql


########################################################################

#Restoring from a Back up File

#Restoring an entire set of databases
mysqldump -u user -p password < all_databases.sql


#Restoring the publication datase
mysqldump -u user -D publications < publications.sql


#Restoring the classics table
mysqldump -u user -D publications < classics.sql



########################################################################

# Generate XML output from a query
mysql -u user -p password --xml publications


#Dumping data in csv format
mysqldump -u user -p password --no-create-info --tab=c:/temp
 --fields-terminated-by=',' publications






