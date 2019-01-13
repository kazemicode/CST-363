#!/usr/bin/env python3
# Sara Kazemi
# CST 363
# Homework 1 Part 2


# this file must be in the /cgi-bin/ directory of the server
import cgitb, cgi
import mysql.connector
cgitb.enable()
form = cgi.FieldStorage()  # Object that allows retrieval of input from form

#   Get input values from form
userid = form['userid'].value  # get the value assigned to the userid attribute in form
password = form['password'].value  # get the value assigned to the password attribute in form
register = False
login = False
#   Checks to see if user is attempting to login or register, based on which button was pressed
if "register" in form:
    register = True
elif "login" in form:
    login = True


# The first two print statements contain required content from cgi programs writing to HTML
print("Content-Type: text/html")    # HTML is following
print()                             # blank line required, end of headers
print("<html><body><p>")

qsql = 'select visits, password from login where userid = %s'
insert_sql = 'insert into login (userid, password, visits) values (%s, %s, 1)'
update_sql = 'update login set visits = visits + 1 where userid=%s and password=%s'

# connect to database
cnx = mysql.connector.connect(user='root',
                                password='Chibi2019!',
                                database='cst363',
                                host='127.0.0.1')

 
#  code to do SQL goes here
cursor = cnx.cursor()  # Creates a cursor object, which is used to execute a MySQL query
cursor.execute(qsql, (userid,))
row = cursor.fetchone()  # fetches the result of the SELECT clause


# Determine if user is attempting to register or login
if register:
    if row is None:
        # user does not already exist, register
        cursorb = cnx.cursor()
        cursorb.execute(insert_sql, (userid, password))
        print('Thank you for registering.  Come visit again.')
    else:
        # user is already registered using this name, reject
        print('The userid ', userid, ' is already registered.</p><br>')
        print('If this is your account, click back and enter your password to login')

elif login:
    if row is None:
        # user does not exist. Prompt user to register
        print('Userid does not exist.</p><br>')
        print('Click back and register.')
    elif row[1] == password:        # second number in tuple returned by result is password
        # retrieve number of visits value from row and increment
        visit_number = row[0] + 1  # first number in tuple returned by result is visits
        cursorc = cnx.cursor()
        cursorc.execute(update_sql, (userid, password))
        print('Welcome, ', userid, ' This is visit number ' + str(visit_number))
    else:
        # if we got here, the user exists but the password is incorrect
        print('Incorrect password for userid ', userid)


print("</body></html>")
cnx.commit()    # IMPORTANT. Must commit or else the inserts and updates will not be permanent
cnx.close()     # close the connection
