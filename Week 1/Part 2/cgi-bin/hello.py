#!/usr/bin/env python3 


# this file must be in the /cgi-bin/ directory of the server
import cgitb , cgi
import mysql.connector
cgitb.enable()
form = cgi.FieldStorage()  # Object that allows retrieval of input from form
#
#  code to get input values goes here
#

first_name = form['first_name'].value  # get the value assigned to the first_name attribute in form
last_name = form['last_name'].value  # get the value assigned to the last_name attribute in form

# The first two print statements contain required content from cgi programs writing to HTML
print("Content-Type: text/html")    # HTML is following
print()                             # blank line required, end of headers
print("<html><body>")
print("<p>Hello ",first_name, last_name,"</p><br>")
qsql = 'select visits from name where first = %s and last = %s' # assigns
insert_sql = 'insert into name (first, last, visits) values (%s, %s, 1)'
update_sql = 'update name set visits = visits + 1 where first=%s and last=%s'

# connect to database
cnx = mysql.connector.connect(user='root',
                                password='Chibi2019!',
                                database='cst363',
                                host='127.0.0.1')

 
#  code to do SQL goes here
cursor = cnx.cursor()  # Creates a cursor object, which is used to execute a MySQL query
cursor.execute(qsql, (first_name, last_name))   # takes the SELECT clause and tuple
                                                # specifiying the strings for first and last
row = cursor.fetchone() # fetches the result of the SELECT clause

 
if row is None: 
    # must be first visit, insert row
    cursorb = cnx.cursor()
    cursorb.execute(insert_sql, (first_name, last_name))
    print('Thank you for registering.  Come visit again.')
else:
    # retrieve number of visits value from row and increment
    visit_number = row[0] + 1   # get the first number from the tuple returned by result
    cursorc = cnx.cursor()
    cursorc.execute(update_sql, (first_name, last_name))

    print('Thank you for visiting again.  This is visit number '+str(visit_number))
print("</body></html>")
cnx.commit()    # IMPORTANT. Must commit or else the inserts and updates will not be permanent
cnx.close()     # close the connection
