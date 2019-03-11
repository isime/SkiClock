import logging
from flask import Flask,g, url_for, request, redirect, session, render_template, Response, request, redirect, url_for, jsonify
import pymysql
import json
import datetime
import random
import MySQLdb
import os
import re

app = Flask(__name__)
app.secret_key = os.urandom(24)

db = pymysql.connect("localhost", "admin", "admin", "Ski_Clock_DB")


@app.route('/')
def home_page():
    return jsonify({'Message': 'Home Page'})


@app.route('/in_stock_skis')
def get_in_stock_skis():

    skisQuery = "SELECT ski_id, length, manufacturer, model FROM SKIS WHERE skis_out = FALSE;"

    cursor = db.cursor()

    cursor.execute(skisQuery)
    skis = [skis[0] for skis in cursor.description]

    skiData = cursor.fetchall()
    skiList=[]
    for element in skiData:
        skiList.append(dict(zip(skis,element)))
    cursor.close()

    return jsonify(skiList)


@app.route('/currently_out_skis')
def get_currently_out_skis():

    skisQuery = "SELECT ski_id, length, manufacturer, model FROM SKIS WHERE skis_out = TRUE;"

    cursor = db.cursor()

    cursor.execute(skisQuery)
    skis = [skis[0] for skis in cursor.description]

    skiData = cursor.fetchall()
    skiList=[]
    for element in skiData:
        skiList.append(dict(zip(skis,element)))
    cursor.close()

    return jsonify(skiList)


@app.route('/all_skis')
def get_all_skis():

    skisQuery = "SELECT ski_id, length, manufacturer, model FROM SKIS;"

    cursor = db.cursor()

    cursor.execute(skisQuery)
    skis = [skis[0] for skis in cursor.description]

    skiData = cursor.fetchall()
    skiList=[]
    for element in skiData:
        skiList.append(dict(zip(skis,element)))
    cursor.close()

    return jsonify(skiList)


@app.route('/in_stock_boots')
def get_in_stock_boots():

    bootsQuery = "SELECT boot_id, size, manufacturer, model, sole_length FROM BOOTS WHERE boots_out = FALSE;"

    cursor = db.cursor()

    cursor.execute(bootsQuery)
    boots = [boots[0] for boots in cursor.description]

    bootsData = cursor.fetchall()
    bootsList=[]
    for element in bootsData:
        bootsList.append(dict(zip(boots,element)))
    cursor.close()

    return jsonify(bootsList)


@app.route('/currently_out_boots')
def get_currently_out_boots():

    bootsQuery = "SELECT boot_id, size, manufacturer, model, sole_length FROM BOOTS WHERE boots_out = TRUE;"

    cursor = db.cursor()

    cursor.execute(bootsQuery)
    boots = [boots[0] for boots in cursor.description]

    bootsData = cursor.fetchall()
    bootsList=[]
    for element in bootsData:
        bootsList.append(dict(zip(boots,element)))
    cursor.close()

    return jsonify(bootsList)


@app.route('/all_boots')
def get_all_boots():

    bootsQuery = "SELECT boot_id, size, manufacturer, model, sole_length FROM BOOTS;"

    cursor = db.cursor()

    cursor.execute(bootsQuery)
    boots = [boots[0] for boots in cursor.description]

    bootsData = cursor.fetchall()
    bootsList=[]
    for element in bootsData:
        bootsList.append(dict(zip(boots,element)))
    cursor.close()

    return jsonify(bootsList)


@app.route('/in_stock_helmets')
def get_in_stock_helmets():

    helmetsQuery = "SELECT helmet_id, size, color FROM HELMET WHERE helmet_out = FALSE;"

    cursor = db.cursor()

    cursor.execute(helmetsQuery)
    helmets = [helmets[0] for helmets in cursor.description]

    helmetData = cursor.fetchall()
    helmetList=[]
    for element in helmetData:
        helmetList.append(dict(zip(helmets,element)))
    cursor.close()

    return jsonify(helmetList)


@app.route('/currently_out_helmets')
def get_currently_out_helmets():

    helmetsQuery = "SELECT helmet_id, size, color FROM HELMET WHERE helmet_out = TRUE;"

    cursor = db.cursor()

    cursor.execute(helmetsQuery)
    helmets = [helmets[0] for helmets in cursor.description]

    helmetData = cursor.fetchall()
    helmetList=[]
    for element in helmetData:
        helmetList.append(dict(zip(helmets,element)))
    cursor.close()

    return jsonify(helmetList)


@app.route('/all_helmets')
def get_all_helmets():

    helmetsQuery = "SELECT helmet_id, size, color FROM HELMET;"

    cursor = db.cursor()
    cursor.execute(helmetsQuery)
    helmets = [helmets[0] for helmets in cursor.description]

    helmetData = cursor.fetchall()
    helmetList=[]
    for element in helmetData:
        helmetList.append(dict(zip(helmets,element)))
    cursor.close()

    return jsonify(helmetList)


@app.route('/new_customer', methods=['Post'])
def add_new_customer():

    cusJson = request.get_json(force=True)

    fname = str(cusJson["fname"])
    lname = str(cusJson["lname"])
    address = str(cusJson["address"])
    state = str(cusJson["state"])
    zip = str(cusJson["zip"])
    city = str(cusJson["city"])
    phone = str(cusJson["phone"])
    email = str(cusJson["email"])
    signature = str(cusJson["signature"])

    date = datetime.datetime.now()

    today = date.strftime("%m") + "/" + date.strftime("%d") + "/" + date.strftime("%Y")

    customerQuery = 'INSERT INTO CUSTOMER(first_name, last_name, address, city, state, zip_code, email, phone) VALUES ("{}", "{}", "{}", "{}", "{}", "{}", "{}", "{}");'.format(fname, lname, address, city, state, zip, email, phone)
    # print(customerQuery)
    cursor = db.cursor()
    cursor.execute(customerQuery)
    db.commit()

    getCusIDQuery = 'SELECT customer_id FROM CUSTOMER ORDER BY customer_id DESC LIMIT 1;'
    cursor = db.cursor()
    cursor.execute(getCusIDQuery)
    data = cursor.fetchone()
    cusID = data[0]

    rentalQuery = 'INSERT INTO RENTALS(customer_id, signature, date_out) VALUES ("{}", "{}", "{}");'.format(cusID, signature, today)
    # print(rentalQuery)
    cursor.execute(rentalQuery)
    db.commit()
    cursor.close()

    return jsonify("done")


@app.route('/new_skier', methods=['Post'])
def add_new_skier():

    skierJson = request.get_json(force=True)

    fname = str(skierJson["fname"])
    lname = str(skierJson["lname"])
    weight = int(str(skierJson["weight"]))
    heightft = int(str(skierJson["heightft"]))
    heightin = int(str(skierJson["heightin"]))
    age = int(str(skierJson["age"]))
    rawSkierType = str(skierJson["skiertype"])

    height = (heightft * 12) + heightin
    skiertype = rawSkierType[0]
    # print(skiertype)

    getCusIDQuery = 'SELECT customer_id FROM CUSTOMER ORDER BY customer_id DESC LIMIT 1;'
    cursor = db.cursor()
    cursor.execute(getCusIDQuery)
    data = cursor.fetchone()
    cusID = data[0]

    skierQuery = 'INSERT INTO SKIER_INFO(customer_id, first_name, last_name, height, weight, age, skier_type) VALUES ("{}", "{}", "{}", "{}", "{}", "{}", "{}");'.format(cusID, fname, lname, height, weight, age, skiertype)
    # print(skierQuery)
    cursor.execute(skierQuery)
    db.commit()

    getRentalIDQuery = 'SELECT rental_id FROM RENTALS ORDER BY rental_id DESC LIMIT 1;'
    cursor = db.cursor()
    cursor.execute(getRentalIDQuery)
    data = cursor.fetchone()
    rentalID = data[0]

    getSkierIDQuery = 'SELECT skier_id FROM SKIER_INFO ORDER BY skier_id DESC LIMIT 1;'
    cursor = db.cursor()
    cursor.execute(getSkierIDQuery)
    data = cursor.fetchone()
    skierID = data[0]

    rentalHasSkiersQuery = 'INSERT INTO RENTALS_HAS_SKIERS(skier_id, rental_id) VALUES ("{}", "{}");'.format(skierId, rentalID)
    cursor.execute(rentalHasSkiersQuery)
    db.commit()
    cursor.close()

    return jsonify("done")


if __name__ == "__main__":
    app.run(debug=True)