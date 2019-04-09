import logging
from flask import Flask,g, url_for, request, redirect, session, render_template, Response, request, redirect, url_for, jsonify
import pymysql
import json
import datetime
import random
import os
import re
import helperFunctions


app = Flask(__name__)
app.secret_key = os.urandom(24)

db = pymysql.connect("localhost", "admin", "admin", "Ski_Clock_DB")


@app.route('/')
def home_page():
    return jsonify({'Message': 'Home Page'})


@app.route('/in_stock_skis')
def get_in_stock_skis():

    skisQuery = "SELECT ski_id, length, manufacturer, model FROM SKIS WHERE skis_out = FALSE ORDER BY manufacturer ASC;"

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

    skisQuery = "SELECT ski_id, length, manufacturer, model FROM SKIS WHERE skis_out = TRUE ORDER BY manufacturer ASC;"

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

    skisQuery = "SELECT ski_id, length, manufacturer, model FROM SKIS ORDER BY manufacturer ASC;"

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

    bootsQuery = "SELECT boot_id, size, manufacturer, model, sole_length FROM BOOTS WHERE boots_out = FALSE ORDER BY manufacturer ASC;"

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

    bootsQuery = "SELECT boot_id, size, manufacturer, model, sole_length FROM BOOTS WHERE boots_out = TRUE ORDER BY manufacturer ASC;"

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

    bootsQuery = "SELECT boot_id, size, manufacturer, model, sole_length FROM BOOTS ORDER BY manufacturer ASC;"

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

    helmetsQuery = "SELECT helmet_id, size, color FROM HELMET WHERE helmet_out = FALSE ORDER BY size ASC;"

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

    helmetsQuery = "SELECT helmet_id, size, color FROM HELMET WHERE helmet_out = TRUE ORDER BY size ASC;"

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

    helmetsQuery = "SELECT helmet_id, size, color FROM HELMET ORDER BY size ASC;"

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

    rentalHasSkiersQuery = 'INSERT INTO RENTALS_HAS_SKIERS(skier_id, rental_id) VALUES ("{}", "{}");'.format(skierID, rentalID)
    cursor.execute(rentalHasSkiersQuery)
    db.commit()
    cursor.close()

    return jsonify("done")


@app.route('/todays_rentals')
def get_todays_rentals():
    date = datetime.datetime.now()

    today = date.strftime("%m") + "/" + date.strftime("%d") + "/" + date.strftime("%Y")
    print("TODAY: ", today)

    # rentalsQuery = 'SELECT last_name, first_name, rental_id FROM customer, rentals WHERE customer.customer_id = rentals.customer_id and rentals.date_out = "{}" Order BY customer.last_name ASC;'.format(today)
    rentalsQuery = 'SELECT last_name, first_name, rental_id, rentals.customer_id FROM customer, rentals WHERE customer.customer_id = rentals.customer_id Order BY customer.last_name ASC;'


    cursor = db.cursor()
    cursor.execute(rentalsQuery)
    rentals = [rentals[0] for rentals in cursor.description]

    rentalData = cursor.fetchall()
    rentalList=[]
    for element in rentalData:
        rentalList.append(dict(zip(rentals,element)))
    cursor.close()

    return jsonify(rentalList)

@app.route('/overdue_rentals')
def get_overdue_rentals():
    newDates = helperFunctions.get_overdue_dates()


    rentalsQuery = 'SELECT last_name, first_name, rental_id, rentals.customer_id FROM customer, rentals WHERE (customer.customer_id = rentals.customer_id AND (rentals.date_out = "{}" OR rentals.date_out = "{}" OR rentals.date_out = "{}")) Order BY customer.last_name ASC;'.format(newDates[0], newDates[1], newDates[2])

    cursor = db.cursor()
    cursor.execute(rentalsQuery)
    rentals = [rentals[0] for rentals in cursor.description]

    rentalData = cursor.fetchall()
    rentalList=[]
    for element in rentalData:
        rentalList.append(dict(zip(rentals,element)))
    cursor.close()

    return jsonify(rentalList)

@app.route('/tomorrows_rentals')
def get_tomorrows_rentals():
    tomorrow = helperFunctions.get_tomorrows_date()


    rentalsQuery = 'SELECT last_name, first_name, rental_id, rentals.customer_id FROM customer, rentals WHERE (customer.customer_id = rentals.customer_id AND (rentals.date_out = "{}")) Order BY customer.last_name ASC;'.format(tomorrow)

    cursor = db.cursor()
    cursor.execute(rentalsQuery)
    rentals = [rentals[0] for rentals in cursor.description]

    rentalData = cursor.fetchall()
    rentalList=[]
    for element in rentalData:
        rentalList.append(dict(zip(rentals,element)))
    cursor.close()

    return jsonify(rentalList)

@app.route('/skiers/<rental_id>')
def get_skeirs(rental_id):

    skiersQuery = 'SELECT * FROM skier_info INNER JOIN (SELECT skier_id FROM rentals_has_skiers WHERE rentals_has_skiers.rental_id = {})AS a ON skier_info.skier_id = a.skier_id ORDER BY first_name ASC;'.format(rental_id)

    cursor = db.cursor()
    cursor.execute(skiersQuery)
    skiers = [skiers[0] for skiers in cursor.description]

    skierData = cursor.fetchall()
    skierList = []
    for element in skierData:
        skierList.append(dict(zip(skiers, element)))
    cursor.close()

    return jsonify(skierList)


@app.route('/add_skier_equipment', methods=['POST'])
def add_skier_equipment(skier_id):

    skierJson = request.get_json(force=True)

    skier_id = skierJson["skier_id"]
    ski_id = skierJson["skier_id"]
    boot_id = skierJson["boot_id"]
    sole_length = skierJson["sole_length"]
    skier_code = skierJson["skier_code"]
    din = skierJson["din"]

    print(skier_id, ski_id, boot_id, sole_length, skier_code, din)

    return jsonify('Done')


@app.route('/get_return/<asset_id>')
def get_return(asset_id):

    returnQuery = 'SELECT * FROM skier_equipment WHERE (ski_id = {} OR boot_id = {} OR helmet_id = {}) AND current_equipment = TRUE;'.format(asset_id, asset_id, asset_id)
    cursor = db.cursor()
    cursor.execute(returnQuery)
    skiers = [skiers[0] for skiers in cursor.description]

    returnData = cursor.fetchall()
    infoList = []
    for element in returnData:
        infoList.append(dict(zip(skiers, element)))

    skier_id = infoList[0]["skier_id"]
    ski_id = infoList[0]["ski_id"]
    boot_id = infoList[0]["boot_id"]
    helmet_id = infoList[0]["helmet_id"]

    returnDict = {}

    skierQuery = 'SELECT skier_id, customer_id, first_name, last_name FROM skier_info WHERE skier_id = {};'.format(skier_id)
    cursor.execute(skierQuery)
    skier = [skier[0] for skier in cursor.description]

    skierData = cursor.fetchall()
    skierList = []
    for element in skierData:
        skierList.append(dict(zip(skier, element)))
    skierList[0]["skier_first_name"] = skierList[0].pop("first_name")
    skierList[0]["skier_last_name"] = skierList[0].pop("last_name")

    returnDict = {**returnDict, **skierList[0]}

    customer_id = skierList[0]['customer_id']
    customerQuery = 'SELECT first_name, last_name FROM customer WHERE customer_id = {};'.format(customer_id)

    cursor.execute(customerQuery)
    customer = [customer[0] for customer in cursor.description]

    customerData = cursor.fetchall()
    customerList = []
    for element in customerData:
        customerList.append(dict(zip(customer, element)))
    customerList[0]["customer_first_name"] = customerList[0].pop("first_name")
    customerList[0]["customer_last_name"] = customerList[0].pop("last_name")

    returnDict = {**returnDict, **customerList[0]}

    rentalIDQuery = 'SELECT rental_id FROM rentals WHERE (customer_id = {} AND current_rental = TRUE);'.format(customer_id)
    cursor.execute(rentalIDQuery)
    rental = [rental[0] for rental in cursor.description]

    rentalIDData = cursor.fetchall()
    rentalIDList = []
    for element in rentalIDData:
        rentalIDList.append(dict(zip(rental, element)))
    returnDict = {**returnDict, **rentalIDList[0]}

    if ski_id is not None:
        skiQuery = 'SELECT ski_id, length, manufacturer, model FROM skis WHERE ski_id = {};'.format(ski_id)
        cursor.execute(skiQuery)
        ski = [ski[0] for ski in cursor.description]

        skiData = cursor.fetchall()
        skiList = []
        for element in skiData:
            skiList.append(dict(zip(ski, element)))
        skiList[0]["ski_manufacture"] = skiList[0].pop("manufacturer")
        skiList[0]["ski_model"] = skiList[0].pop("model")

        returnDict = {**returnDict, **skiList[0]}
    else:
        noSkiDict = {'ski_id': 0,
                     'length': 0,
                     'ski_manufacturer': 'N/A',
                     'ski_model': 'N/A'}
        returnDict = {**returnDict, **noSkiDict}

    if boot_id is not None:
        bootQuery = 'SELECT boot_id, manufacturer, model, size, sole_length FROM boots WHERE boot_id = {};'.format(boot_id)
        cursor.execute(bootQuery)
        boot = [boot[0] for boot in cursor.description]

        bootData = cursor.fetchall()
        bootList = []
        for element in bootData:
            bootList.append(dict(zip(boot, element)))
        bootList[0]["boot_manufacture"] = bootList[0].pop("manufacturer")
        bootList[0]["boot_model"] = bootList[0].pop("model")
        bootList[0]["boot_size"] = bootList[0].pop("size")

        returnDict = {**returnDict, **bootList[0]}
    else:
        noBootDict = {'boot_id': 0,
                     'sole_length': 0,
                     'boot_manufacturer': 'N/A',
                     'boot_model': 'N/A',
                     'boot_size': 0.0}
        returnDict = {**returnDict, **noBootDict}

    if helmet_id is not None:
        helmetQuery = 'SELECT helmet_id, size, color FROM helmet WHERE helmet_id = {};'.format(helmet_id)
        cursor.execute(helmetQuery)
        helmet = [helmet[0] for helmet in cursor.description]

        helmetData = cursor.fetchall()
        helmetList = []
        for element in helmetData:
            helmetList.append(dict(zip(helmet, element)))
        helmetList[0]["helmet_size"] = bootList[0].pop("size")

        returnDict = {**returnDict, **helmetList[0]}
    else:
        noHelmetDict = {'helmet_id': 0,
                     'helmet_size': 'N/A',
                     'Color': 'N/A'}
        returnDict = {**returnDict, **noHelmetDict}

    cursor.close()
    return jsonify(returnDict)

@app.route('/get_skier_return/<skier_id>/<customer_id>')
def get_skier_return(skier_id, customer_id):

    returnQuery = 'SELECT * FROM skier_equipment WHERE skier_id = {} AND current_equipment = TRUE;'.format(skier_id)
    cursor = db.cursor()
    cursor.execute(returnQuery)
    skiers = [skiers[0] for skiers in cursor.description]

    returnData = cursor.fetchall()
    infoList = []
    for element in returnData:
        infoList.append(dict(zip(skiers, element)))

    skier_id = infoList[0]["skier_id"]
    ski_id = infoList[0]["ski_id"]
    boot_id = infoList[0]["boot_id"]
    helmet_id = infoList[0]["helmet_id"]

    returnDict = {}

    if ski_id is not None:
        skiQuery = 'SELECT ski_id, length, manufacturer, model FROM skis WHERE ski_id = {};'.format(ski_id)
        cursor.execute(skiQuery)
        ski = [ski[0] for ski in cursor.description]

        skiData = cursor.fetchall()
        skiList = []
        for element in skiData:
            skiList.append(dict(zip(ski, element)))
        skiList[0]["ski_manufacture"] = skiList[0].pop("manufacturer")
        skiList[0]["ski_model"] = skiList[0].pop("model")

        returnDict = {**returnDict, **skiList[0]}
    else:
        noSkiDict = {'ski_id': 0,
                     'length': 0,
                     'ski_manufacturer': 'N/A',
                     'ski_model': 'N/A'}
        returnDict = {**returnDict, **noSkiDict}

    if boot_id is not None:
        bootQuery = 'SELECT boot_id, manufacturer, model, size, sole_length FROM boots WHERE boot_id = {};'.format(boot_id)
        cursor.execute(bootQuery)
        boot = [boot[0] for boot in cursor.description]

        bootData = cursor.fetchall()
        bootList = []
        for element in bootData:
            bootList.append(dict(zip(boot, element)))
        bootList[0]["boot_manufacture"] = bootList[0].pop("manufacturer")
        bootList[0]["boot_model"] = bootList[0].pop("model")
        bootList[0]["boot_size"] = bootList[0].pop("size")

        returnDict = {**returnDict, **bootList[0]}
    else:
        noBootDict = {'boot_id': 0,
                     'sole_length': 0,
                     'boot_manufacturer': 'N/A',
                     'boot_model': 'N/A',
                     'boot_size': 0.0}
        returnDict = {**returnDict, **noBootDict}

    if helmet_id is not None:
        helmetQuery = 'SELECT helmet_id, size, color FROM helmet WHERE helmet_id = {};'.format(helmet_id)
        cursor.execute(helmetQuery)
        helmet = [helmet[0] for helmet in cursor.description]

        helmetData = cursor.fetchall()
        helmetList = []
        for element in helmetData:
            helmetList.append(dict(zip(helmet, element)))
        helmetList[0]["helmet_size"] = bootList[0].pop("size")

        returnDict = {**returnDict, **helmetList[0]}
    else:
        noHelmetDict = {'helmet_id': 0,
                     'helmet_size': 'N/A',
                     'Color': 'N/A'}
        returnDict = {**returnDict, **noHelmetDict}

    cursor.close()
    return jsonify(returnDict)


if __name__ == "__main__":
    app.run(debug=True)