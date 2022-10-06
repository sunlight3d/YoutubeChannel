import mysql.connector
from flask import Flask
import json

app = Flask(__name__)
#run app:
#python3 -m flask run
#Define root route
@app.route('/')
def hello_world():
    return 'Hello World !!!'

#Get list of products
@app.route('/products')
def get_products():
    database = mysql.connector.connect(
        host="mysql-flask-app-container",
        user="root",
        password="Abc@123456789",
        database="ProductManagement"
    )
    cursor = database.cursor()
    cursor.execute("SELECT * FROM tblProduct")
    row_headers=[x[0] for x in cursor.description]
    products = cursor.fetchall()
    json_data=[]
    for product in products:
        json_data.append(dict(zip(row_headers,product)))
    cursor.close()
    return json.dumps(json_data) #convert to JSON

#use this function to create Database 
@app.route('/initdb')
def initdb():
    database = mysql.connector.connect(
        host="mysql-flask-app-container",
        user="root",
        password="Abc@123456789"        
    )
    cursor = database.cursor()
    cursor.execute("DROP DATABASE IF EXISTS ProductManagement")
    cursor.execute("CREATE DATABASE ProductManagement")
    cursor.close()    
    return 'init Database' #Good     
#write a function to create tables
@app.route('/init_tables')
def init_tables():
    database = mysql.connector.connect(
        host="mysql-flask-app-container",
        user="root",
        password="Abc@123456789",
        database="ProductManagement"
    )
    cursor = database.cursor()

    cursor.execute("DROP TABLE IF EXISTS tblProduct")
    cursor.execute("""CREATE TABLE tblProduct """
    """(id INT PRIMARY KEY AUTO_INCREMENT,"""
    """name VARCHAR(255),""" 
    """description VARCHAR(255))""")
    cursor.close()    
    return "init_tables"


"""
INSERT INTO tblProduct(name, description) VALUES
('macboook pro m1', 'please buy'),
('iphone 13', 'please buy and buy');
"""    