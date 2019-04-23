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


@app.route('/')
def home_page():
    return jsonify({'Message': 'Home Page'})


@app.route('/in_stock_skis')
def get_in_stock_skis():
    db = pymysql.connect("localhost", "admin", "admin", "Ski_Clock_DB")

    skisQuery = "SELECT ski_id, length, manufacturer, model FROM SKIS WHERE skis_out = FALSE ORDER BY manufacturer ASC;"

    cursor = db.cursor()

    cursor.execute(skisQuery)
    skis = [skis[0] for skis in cursor.description]

    skiData = cursor.fetchall()
    skiList=[]
    for element in skiData:
        skiList.append(dict(zip(skis,element)))
    cursor.close()

    if skiList == []:
        noSkis = {"length": 0,
        "manufacturer": "No",
        "model": "Records",
        "ski_id": 0}
        skiList.append(noSkis)

    return jsonify(skiList)


@app.route('/currently_out_skis')
def get_currently_out_skis():
    db = pymysql.connect("localhost", "admin", "admin", "Ski_Clock_DB")

    skisQuery = "SELECT ski_id, length, manufacturer, model FROM SKIS WHERE skis_out = TRUE ORDER BY manufacturer ASC;"

    cursor = db.cursor()

    cursor.execute(skisQuery)
    skis = [skis[0] for skis in cursor.description]

    skiData = cursor.fetchall()
    skiList=[]
    for element in skiData:
        skiList.append(dict(zip(skis,element)))
    cursor.close()

    if skiList == []:
        noSkis = {"length": 0,
        "manufacturer": "No",
        "model": "Records",
        "ski_id": 0}
        skiList.append(noSkis)

    return jsonify(skiList)


@app.route('/all_skis')
def get_all_skis():
    db = pymysql.connect("localhost", "admin", "admin", "Ski_Clock_DB")

    skisQuery = "SELECT ski_id, length, manufacturer, model FROM SKIS ORDER BY manufacturer ASC;"

    cursor = db.cursor()

    cursor.execute(skisQuery)
    skis = [skis[0] for skis in cursor.description]

    skiData = cursor.fetchall()
    skiList=[]
    for element in skiData:
        skiList.append(dict(zip(skis,element)))
    cursor.close()

    if skiList == []:
        noSkis = {"length": 0,
        "manufacturer": "No",
        "model": "Records",
        "ski_id": 0}
        skiList.append(noSkis)

    return jsonify(skiList)


@app.route('/in_stock_boots')
def get_in_stock_boots():
    db = pymysql.connect("localhost", "admin", "admin", "Ski_Clock_DB")

    bootsQuery = "SELECT boot_id, size, manufacturer, model, sole_length FROM BOOTS WHERE boots_out = FALSE ORDER BY manufacturer ASC;"

    cursor = db.cursor()

    cursor.execute(bootsQuery)
    boots = [boots[0] for boots in cursor.description]

    bootsData = cursor.fetchall()
    bootsList=[]
    for element in bootsData:
        bootsList.append(dict(zip(boots,element)))
    cursor.close()

    if bootsList == []:
        noBoots = {
        "boot_id": 0,
        "manufacturer": "No",
        "model": "Records",
        "size": 0,
        "sole_length": 0
        }
        bootsList.append(noBoots)

    return jsonify(bootsList)


@app.route('/currently_out_boots')
def get_currently_out_boots():
    db = pymysql.connect("localhost", "admin", "admin", "Ski_Clock_DB")

    bootsQuery = "SELECT boot_id, size, manufacturer, model, sole_length FROM BOOTS WHERE boots_out = TRUE ORDER BY manufacturer ASC;"

    cursor = db.cursor()

    cursor.execute(bootsQuery)
    boots = [boots[0] for boots in cursor.description]

    bootsData = cursor.fetchall()
    bootsList=[]
    for element in bootsData:
        bootsList.append(dict(zip(boots,element)))
    cursor.close()

    if bootsList == []:
        noBoots = {
        "boot_id": 0,
        "manufacturer": "No",
        "model": "Records",
        "size": 0,
        "sole_length": 0
        }
        bootsList.append(noBoots)

    return jsonify(bootsList)


@app.route('/all_boots')
def get_all_boots():
    db = pymysql.connect("localhost", "admin", "admin", "Ski_Clock_DB")

    bootsQuery = "SELECT boot_id, size, manufacturer, model, sole_length FROM BOOTS ORDER BY manufacturer ASC;"

    cursor = db.cursor()

    cursor.execute(bootsQuery)
    boots = [boots[0] for boots in cursor.description]

    bootsData = cursor.fetchall()
    bootsList=[]
    for element in bootsData:
        bootsList.append(dict(zip(boots,element)))
    cursor.close()

    if bootsList == []:
        noBoots = {
        "boot_id": 0,
        "manufacturer": "No",
        "model": "Records",
        "size": 0,
        "sole_length": 0
        }
        bootsList.append(noBoots)

    return jsonify(bootsList)


@app.route('/in_stock_helmets')
def get_in_stock_helmets():
    db = pymysql.connect("localhost", "admin", "admin", "Ski_Clock_DB")

    helmetsQuery = "SELECT helmet_id, size, color FROM HELMET WHERE helmet_out = FALSE ORDER BY size ASC;"

    cursor = db.cursor()

    cursor.execute(helmetsQuery)
    helmets = [helmets[0] for helmets in cursor.description]

    helmetData = cursor.fetchall()
    helmetList=[]
    for element in helmetData:
        helmetList.append(dict(zip(helmets,element)))
    cursor.close()

    if helmetList == []:
        noHelmet = {
            "color": "Black",
            "helmet_id": 19051,
            "size": "L"
        }
        helmetList.append(noHelmet)

    return jsonify(helmetList)


@app.route('/currently_out_helmets')
def get_currently_out_helmets():
    db = pymysql.connect("localhost", "admin", "admin", "Ski_Clock_DB")

    helmetsQuery = "SELECT helmet_id, size, color FROM HELMET WHERE helmet_out = TRUE ORDER BY size ASC;"

    cursor = db.cursor()

    cursor.execute(helmetsQuery)
    helmets = [helmets[0] for helmets in cursor.description]

    helmetData = cursor.fetchall()
    helmetList=[]
    for element in helmetData:
        helmetList.append(dict(zip(helmets,element)))
    cursor.close()

    if helmetList == []:
        noHelmet = {
            "color": "Black",
            "helmet_id": 19051,
            "size": "L"
        }
        helmetList.append(noHelmet)

    return jsonify(helmetList)


@app.route('/all_helmets')
def get_all_helmets():
    db = pymysql.connect("localhost", "admin", "admin", "Ski_Clock_DB")

    helmetsQuery = "SELECT helmet_id, size, color FROM HELMET ORDER BY size ASC;"

    cursor = db.cursor()
    cursor.execute(helmetsQuery)
    helmets = [helmets[0] for helmets in cursor.description]

    helmetData = cursor.fetchall()
    helmetList=[]
    for element in helmetData:
        helmetList.append(dict(zip(helmets,element)))
    cursor.close()

    if helmetList == []:
        noHelmet = {
            "color": "Black",
            "helmet_id": 19051,
            "size": "L"
        }
        helmetList.append(noHelmet)

    return jsonify(helmetList)


@app.route('/new_customer', methods=['Post'])
def add_new_customer():
    db = pymysql.connect("localhost", "admin", "admin", "Ski_Clock_DB")

    cusJson = request.get_json(force=True)

    fname = str(cusJson["fname"])
    lname = str(cusJson["lname"])
    address = str(cusJson["address"])
    state = str(cusJson["state"])
    zip = str(cusJson["zip"])
    city = str(cusJson["city"])
    phone = str(cusJson["phone"])
    email = str(cusJson["email"])
    days = int(str(cusJson["days"]))

    date = datetime.datetime.now()

    today = date.strftime("%m") + "/" + date.strftime("%d") + "/" + date.strftime("%Y")

    customerQuery = 'INSERT INTO CUSTOMER(first_name, last_name, address, city, state, zip_code, email, phone) VALUES ("{}", "{}", "{}", "{}", "{}", "{}", "{}", "{}");'.format(fname, lname, address, city, state, zip, email, phone)
    print(customerQuery)
    cursor = db.cursor()
    cursor.execute(customerQuery)
    db.commit()
    cursor.close()

    db = pymysql.connect("localhost", "admin", "admin", "Ski_Clock_DB")

    getCusIDQuery = 'SELECT customer_id FROM CUSTOMER ORDER BY customer_id DESC LIMIT 1;'
    cursor = db.cursor()
    cursor.execute(getCusIDQuery)
    data = cursor.fetchone()
    cusID = data[0]
    cursor.close()

    db = pymysql.connect("localhost", "admin", "admin", "Ski_Clock_DB")
    due_date = helperFunctions.get_due_date(days)
    rentalQuery = 'INSERT INTO RENTALS(customer_id, total_skiers, date_out, due_date) VALUES ("{}", 0, "{}", "{}");'.format(cusID, today, due_date)
    print(rentalQuery)
    cursor = db.cursor()
    cursor.execute(rentalQuery)
    db.commit()
    cursor.close()

    return jsonify("done")


@app.route('/new_skier', methods=['Post'])
def add_new_skier():
    db = pymysql.connect("localhost", "admin", "admin", "Ski_Clock_DB")

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
    cursor.close()

    db = pymysql.connect("localhost", "admin", "admin", "Ski_Clock_DB")

    skierQuery = 'INSERT INTO SKIER_INFO(customer_id, first_name, last_name, height, weight, age, skier_type) VALUES ("{}", "{}", "{}", "{}", "{}", "{}", "{}");'.format(cusID, fname, lname, height, weight, age, skiertype)
    # print(skierQuery)
    cursor = db.cursor()
    cursor.execute(skierQuery)
    db.commit()
    cursor.close()

    db = pymysql.connect("localhost", "admin", "admin", "Ski_Clock_DB")

    getRentalIDQuery = 'SELECT rental_id FROM RENTALS ORDER BY rental_id DESC LIMIT 1;'
    cursor = db.cursor()
    cursor.execute(getRentalIDQuery)
    data = cursor.fetchone()
    rentalID = data[0]
    cursor.close()

    db = pymysql.connect("localhost", "admin", "admin", "Ski_Clock_DB")

    getSkierIDQuery = 'SELECT skier_id FROM SKIER_INFO ORDER BY skier_id DESC LIMIT 1;'
    cursor = db.cursor()
    cursor.execute(getSkierIDQuery)
    data = cursor.fetchone()
    skierID = data[0]
    cursor.close()

    db = pymysql.connect("localhost", "admin", "admin", "Ski_Clock_DB")

    rentalHasSkiersQuery = 'INSERT INTO RENTALS_HAS_SKIERS(skier_id, rental_id) VALUES ("{}", "{}");'.format(skierID, rentalID)
    cursor = db.cursor()
    cursor.execute(rentalHasSkiersQuery)
    db.commit()
    cursor.close()

    db = pymysql.connect("localhost", "admin", "admin", "Ski_Clock_DB")
    rentalSkiersQuery = "UPDATE rentals SET total_skiers = total_skiers+1 WHERE rental_id = {}".format(rentalID)
    cursor = db.cursor()
    cursor.execute(rentalSkiersQuery)
    db.commit()
    cursor.close()

    return jsonify("done")


@app.route('/todays_rentals')
def get_todays_rentals():
    date = datetime.datetime.now()

    today = date.strftime("%m") + "/" + date.strftime("%d") + "/" + date.strftime("%Y")
    # print("TODAY: ", today)

    db = pymysql.connect("localhost", "admin", "admin", "Ski_Clock_DB")
    rentalsQuery = 'SELECT last_name, first_name, rental_id, rentals.customer_id FROM customer, rentals WHERE customer.customer_id = rentals.customer_id AND date_out = "{}" AND rentals.skiers_picked_up < rentals.total_skiers Order BY customer.last_name ASC;'.format(today)


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

    db = pymysql.connect("localhost", "admin", "admin", "Ski_Clock_DB")

    rentalsQuery = 'SELECT last_name, first_name, rental_id, rentals.customer_id FROM customer, rentals WHERE (customer.customer_id = rentals.customer_id AND (rentals.date_out = "{}" OR rentals.date_out = "{}" OR rentals.date_out = "{}") AND rentals.skiers_picked_up < rentals.total_skiers) Order BY customer.last_name ASC;'.format(newDates[0], newDates[1], newDates[2])

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

    db = pymysql.connect("localhost", "admin", "admin", "Ski_Clock_DB")

    rentalsQuery = 'SELECT last_name, first_name, rental_id, rentals.customer_id FROM customer, rentals WHERE (customer.customer_id = rentals.customer_id AND (rentals.date_out = "{}") AND rentals.skiers_picked_up < rentals.total_skiers) Order BY customer.last_name ASC;'.format(tomorrow)

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
    db = pymysql.connect("localhost", "admin", "admin", "Ski_Clock_DB")

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
def add_skier_equipment():

    db = pymysql.connect("localhost", "admin", "admin", "Ski_Clock_DB")

    skierJson = request.get_json(force=True)

    skier_id = int(str(skierJson["skier_id"]))
    ski_id = str(skierJson["ski_id"])
    boot_id = str(skierJson["boot_id"])
    helmet_id = str(skierJson["helmet_id"])
    sole_length = int(str(skierJson["sole_length"]))
    skier_code = skierJson["skier_code"]
    din = float(str(skierJson["din"]))
    rental_id = int(str(skierJson["rental_id"]))

    if helmet_id == "":
        helmet_id = "NULL"
    if boot_id == "":
        boot_id = "NULL"
    if ski_id == "":
        ski_id = "NULL"

    cursor = db.cursor()
    settingsQuery = 'UPDATE skier_settings set latest_setting = FALSE WHERE skier_id = {};'.format(skier_id)
    cursor.execute(settingsQuery)
    db.commit()
    cursor.close()

    db = pymysql.connect("localhost", "admin", "admin", "Ski_Clock_DB")

    cursor = db.cursor()
    settingsQuery = 'INSERT INTO skier_settings (skier_id, boot_sole_length, skier_code, reccomended_din, actual_din) VALUES ({}, {}, "{}", {}, {});'.format(skier_id, sole_length, skier_code, din, din)
    # print(settingsQuery)
    cursor.execute(settingsQuery)
    db.commit()
    cursor.close()

    db = pymysql.connect("localhost", "admin", "admin", "Ski_Clock_DB")
    cursor = db.cursor()
    equipmentUpdateQuery = 'UPDATE skier_equipment set current_equipment = FALSE, latest_equipment = FALSE WHERE skier_id = {};'.format(skier_id)
    # print(equipmentUpdateQuery)
    cursor.execute(equipmentUpdateQuery)
    db.commit()
    cursor.close()

    db = pymysql.connect("localhost", "admin", "admin", "Ski_Clock_DB")
    cursor = db.cursor()
    rentalPickUpUpdateQuery = 'UPDATE rentals set skiers_picked_up = skiers_picked_up+1 WHERE rental_id = {};'.format(rental_id)
    cursor.execute(rentalPickUpUpdateQuery)
    db.commit()
    cursor.close()

    db = pymysql.connect("localhost", "admin", "admin", "Ski_Clock_DB")
    cursor = db.cursor()
    equipmentQuery = 'INSERT INTO skier_equipment (skier_id, ski_id, boot_id, helmet_id) VALUES ({}, {}, {}, {});'.format(skier_id, ski_id, boot_id, helmet_id)
    # print(equipmentQuery)
    cursor.execute(equipmentQuery)
    db.commit()
    cursor.close()

    db = pymysql.connect("localhost", "admin", "admin", "Ski_Clock_DB")
    cursor = db.cursor()
    skisUpdateQuery = 'UPDATE skis set skis_out = TRUE WHERE ski_id = {};'.format(ski_id)
    cursor.execute(skisUpdateQuery)
    db.commit()
    cursor.close()

    db = pymysql.connect("localhost", "admin", "admin", "Ski_Clock_DB")
    cursor = db.cursor()
    bootsUpdateQuery = 'UPDATE boots set boots_out = TRUE WHERE boot_id = {};'.format(boot_id)
    cursor.execute(bootsUpdateQuery)
    db.commit()
    cursor.close()

    db = pymysql.connect("localhost", "admin", "admin", "Ski_Clock_DB")
    cursor = db.cursor()
    helmtUpdateQuery = 'UPDATE helmet set helmet_out = TRUE WHERE helmet_id = {};'.format(helmet_id)
    cursor.execute(helmtUpdateQuery)
    db.commit()
    cursor.close()

    return jsonify('Done')


@app.route('/add_skier_signature', methods=['POST'])
def add_skier_signature():

    db = pymysql.connect("localhost", "admin", "admin", "Ski_Clock_DB")

    skierJson = request.get_json(force=True)

    skier_id = int(str(skierJson["skier_id"]))
    signature = str(skierJson["signature"])

    db = pymysql.connect("localhost", "admin", "admin", "Ski_Clock_DB")
    cursor = db.cursor()
    signatureQuery = 'UPDATE skier_equipment SET signature = "{}" WHERE skier_id = {} AND current_equipment = TRUE;'.format(signature, skier_id)
    cursor.execute(signatureQuery)
    db.commit()
    cursor.close()

    return jsonify('Done')

@app.route('/get_return/<asset_id>')
def get_return(asset_id):

    db = pymysql.connect("localhost", "admin", "admin", "Ski_Clock_DB")

    returnQuery = 'SELECT * FROM skier_equipment WHERE (ski_id = {} OR boot_id = {} OR helmet_id = {}) AND current_equipment = TRUE;'.format(asset_id, asset_id, asset_id)
    cursor = db.cursor()
    cursor.execute(returnQuery)
    skiers = [skiers[0] for skiers in cursor.description]

    returnData = cursor.fetchall()
    infoList = []
    for element in returnData:
        infoList.append(dict(zip(skiers, element)))
    cursor.close()

    if infoList == []:
        db = pymysql.connect("localhost", "admin", "admin", "Ski_Clock_DB")

        returnQuery = 'SELECT * FROM skier_equipment WHERE (ski_id = {} OR boot_id = {} OR helmet_id = {}) AND latest_equipment = TRUE ORDER BY skier_equipment_id DESC;'.format(asset_id, asset_id, asset_id)
        cursor = db.cursor()
        cursor.execute(returnQuery)
        skiers = [skiers[0] for skiers in cursor.description]

        returnData = cursor.fetchall()
        for element in returnData:
            infoList.append(dict(zip(skiers, element)))
        cursor.close()

    if infoList == []:
        noInfo = {
            "boot_id": asset_id,
            "boot_manufacture": "No",
            "boot_model": "Record",
            "boot_size": 1.0,
            "boots_returned": "00/00/0000",
            "color": "N/A",
            "customer_first_name": "No",
            "customer_id": 1,
            "customer_last_name": "Record",
            "helmet_id": asset_id,
            "helmet_returned": "00/00/0000",
            "helmet_size": "N/A",
            "length": 1,
            "rental_id": 1,
            "ski_id": asset_id,
            "ski_manufacture": "No",
            "ski_model": "Record",
            "skier_first_name": "Number Enterned",
            "skier_id": 1,
            "skier_last_name": str(asset_id),
            "skis_returned": "00/00/0000",
            "sole_length": 1
            }
        return jsonify(noInfo)

    skier_id = infoList[0]["skier_id"]
    print('SKIER ID: ', skier_id)
    ski_id = infoList[0]["ski_id"]
    boot_id = infoList[0]["boot_id"]
    helmet_id = infoList[0]["helmet_id"]
    skis_returned = infoList[0]["skis_returned"]
    boots_returned = infoList[0]["boots_returned"]
    helmet_returned = infoList[0]["helmet_returned"]

    if skis_returned is None:
        skis_returned = "00/00/0000"
    if boots_returned is None:
        boots_returned = "00/00/0000"
    if helmet_returned is None:
        helmet_returned = "00/00/0000"

    returnDict = {"skis_returned": skis_returned,
                 "boots_returned": boots_returned,
                 "helmet_returned": helmet_returned}
    cursor.close()

    db = pymysql.connect("localhost", "admin", "admin", "Ski_Clock_DB")

    skierQuery = 'SELECT skier_id, customer_id, first_name, last_name FROM skier_info WHERE skier_id = {};'.format(skier_id)
    cursor = db.cursor()
    cursor.execute(skierQuery)
    skier = [skier[0] for skier in cursor.description]

    skierData = cursor.fetchall()
    skierList = []
    for element in skierData:
        skierList.append(dict(zip(skier, element)))
    skierList[0]["skier_first_name"] = skierList[0].pop("first_name")
    skierList[0]["skier_last_name"] = skierList[0].pop("last_name")

    returnDict = {**returnDict, **skierList[0]}

    cursor.close()

    db = pymysql.connect("localhost", "admin", "admin", "Ski_Clock_DB")

    customer_id = skierList[0]['customer_id']
    customerQuery = 'SELECT first_name, last_name FROM customer WHERE customer_id = {};'.format(customer_id)
    cursor = db.cursor()
    cursor.execute(customerQuery)
    customer = [customer[0] for customer in cursor.description]

    customerData = cursor.fetchall()
    customerList = []
    for element in customerData:
        customerList.append(dict(zip(customer, element)))
    customerList[0]["customer_first_name"] = customerList[0].pop("first_name")
    customerList[0]["customer_last_name"] = customerList[0].pop("last_name")

    returnDict = {**returnDict, **customerList[0]}

    cursor.close()

    db = pymysql.connect("localhost", "admin", "admin", "Ski_Clock_DB")

    rentalIDQuery = 'SELECT rental_id FROM rentals WHERE (customer_id = {} AND current_rental = TRUE);'.format(customer_id)
    cursor = db.cursor()
    cursor.execute(rentalIDQuery)
    rental = [rental[0] for rental in cursor.description]

    rentalIDData = cursor.fetchall()
    rentalIDList = []
    for element in rentalIDData:
        rentalIDList.append(dict(zip(rental, element)))
    returnDict = {**returnDict, **rentalIDList[0]}

    cursor.close()

    if ski_id is not None:
        db = pymysql.connect("localhost", "admin", "admin", "Ski_Clock_DB")

        skiQuery = 'SELECT ski_id, length, manufacturer, model FROM skis WHERE ski_id = {};'.format(ski_id)
        cursor = db.cursor()
        cursor.execute(skiQuery)
        ski = [ski[0] for ski in cursor.description]

        skiData = cursor.fetchall()
        skiList = []
        for element in skiData:
            skiList.append(dict(zip(ski, element)))
        skiList[0]["ski_manufacture"] = skiList[0].pop("manufacturer")
        skiList[0]["ski_model"] = skiList[0].pop("model")

        returnDict = {**returnDict, **skiList[0]}
        cursor.close()
    else:
        noSkiDict = {'ski_id': 0,
                     'length': 0,
                     'ski_manufacturer': 'N/A',
                     'ski_model': 'N/A'}
        returnDict = {**returnDict, **noSkiDict}

    if boot_id is not None:
        db = pymysql.connect("localhost", "admin", "admin", "Ski_Clock_DB")

        bootQuery = 'SELECT boot_id, manufacturer, model, size, sole_length FROM boots WHERE boot_id = {};'.format(boot_id)
        cursor = db.cursor()
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
        cursor.close()
    else:
        noBootDict = {'boot_id': 0,
                     'sole_length': 0,
                     'boot_manufacturer': 'N/A',
                     'boot_model': 'N/A',
                     'boot_size': 0.0}
        returnDict = {**returnDict, **noBootDict}

    if helmet_id is not None:
        db = pymysql.connect("localhost", "admin", "admin", "Ski_Clock_DB")

        helmetQuery = 'SELECT helmet_id, size, color FROM helmet WHERE helmet_id = {};'.format(helmet_id)
        cursor = db.cursor()
        cursor.execute(helmetQuery)
        helmet = [helmet[0] for helmet in cursor.description]

        helmetData = cursor.fetchall()
        helmetList = []
        for element in helmetData:
            helmetList.append(dict(zip(helmet, element)))
        helmetList[0]["helmet_size"] = helmetList[0].pop("size")

        returnDict = {**returnDict, **helmetList[0]}
        cursor.close()
    else:
        noHelmetDict = {'helmet_id': 0,
                     'helmet_size': 'N/A',
                     'Color': 'N/A'}
        returnDict = {**returnDict, **noHelmetDict}

    if cursor is not None:
        cursor.close()
    return jsonify(returnDict)

@app.route('/get_skier_return/<skier_id>')
def get_skier_return(skier_id):
    db = pymysql.connect("localhost", "admin", "admin", "Ski_Clock_DB")

    returnQuery = 'SELECT * FROM skier_equipment WHERE skier_id = {} AND current_equipment = TRUE;'.format(skier_id)
    cursor = db.cursor()
    cursor.execute(returnQuery)
    skiers = [skiers[0] for skiers in cursor.description]

    returnData = cursor.fetchall()
    infoList = []
    for element in returnData:
        infoList.append(dict(zip(skiers, element)))

    if infoList == []:
        db = pymysql.connect("localhost", "admin", "admin", "Ski_Clock_DB")

        returnQuery = 'SELECT * FROM skier_equipment WHERE skier_id = {} AND latest_equipment = TRUE ORDER BY skier_equipment_id DESC;'.format(skier_id)
        cursor = db.cursor()
        cursor.execute(returnQuery)
        skiers = [skiers[0] for skiers in cursor.description]

        returnData = cursor.fetchall()
        for element in returnData:
            infoList.append(dict(zip(skiers, element)))

    if infoList != []:
        ski_id = infoList[0]["ski_id"]
        boot_id = infoList[0]["boot_id"]
        helmet_id = infoList[0]["helmet_id"]
        skis_returned = infoList[0]["skis_returned"]
        boots_returned = infoList[0]["boots_returned"]
        helmet_returned = infoList[0]["helmet_returned"]
    else:
        noInfo = {
            "customer_first_name": "No",
            "customer_last_name": "Record",
            "rental_id": 0,
            "skier_first_name": "No",
            "skier_id": 0,
            "skier_last_name": "Record",
        }
        skis_returned = "00/00/0000"
        boots_returned = "00/00/0000"
        helmet_returned = "00/00/0000"
        ski_id = None
        boot_id = None
        helmet_id = None


    if skis_returned is None:
        skis_returned = "00/00/0000"
    if boots_returned is None:
        boots_returned = "00/00/0000"
    if helmet_returned is None:
        helmet_returned = "00/00/0000"

    returnDict = {"skis_returned": skis_returned,
                  "boots_returned": boots_returned,
                  "helmet_returned": helmet_returned}
    cursor.close()

    if ski_id is not None:
        db = pymysql.connect("localhost", "admin", "admin", "Ski_Clock_DB")

        skiQuery = 'SELECT ski_id, length, manufacturer, model FROM skis WHERE ski_id = {};'.format(ski_id)
        cursor = db.cursor()
        cursor.execute(skiQuery)
        ski = [ski[0] for ski in cursor.description]

        skiData = cursor.fetchall()
        skiList = []
        for element in skiData:
            skiList.append(dict(zip(ski, element)))
        skiList[0]["ski_manufacture"] = skiList[0].pop("manufacturer")
        skiList[0]["ski_model"] = skiList[0].pop("model")

        returnDict = {**returnDict, **skiList[0]}
        cursor.close()
    else:
        noSkiDict = {'ski_id': int(0),
                     'length': 0,
                     'ski_manufacturer': 'N/A',
                     'ski_model': 'N/A'}
        returnDict = {**returnDict, **noSkiDict}

    if boot_id is not None:
        db = pymysql.connect("localhost", "admin", "admin", "Ski_Clock_DB")

        bootQuery = 'SELECT boot_id, manufacturer, model, size, sole_length FROM boots WHERE boot_id = {};'.format(boot_id)
        cursor = db.cursor()
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
        cursor.close()
    else:
        noBootDict = {'boot_id': 0,
                     'sole_length': 0,
                     'boot_manufacturer': 'N/A',
                     'boot_model': 'N/A',
                     'boot_size': 0.0}
        returnDict = {**returnDict, **noBootDict}

    if helmet_id is not None:
        db = pymysql.connect("localhost", "admin", "admin", "Ski_Clock_DB")

        helmetQuery = 'SELECT helmet_id, size, color FROM helmet WHERE helmet_id = {};'.format(helmet_id)
        cursor = db.cursor()
        cursor.execute(helmetQuery)
        helmet = [helmet[0] for helmet in cursor.description]

        helmetData = cursor.fetchall()
        helmetList = []
        for element in helmetData:
            helmetList.append(dict(zip(helmet, element)))
        helmetList[0]["helmet_size"] = helmetList[0].pop("size")

        returnDict = {**returnDict, **helmetList[0]}
        cursor.close()
    else:
        noHelmetDict = {'helmet_id': 0,
                     'helmet_size': 'N/A',
                     'Color': 'N/A'}
        returnDict = {**returnDict, **noHelmetDict}


    if cursor is not None:
        cursor.close()
    return jsonify(returnDict)

@app.route('/return_skier_equipment', methods=['Post'])
def return_skier_equipment():
    today = helperFunctions.get_today_string()

    skierJson = request.get_json(force=True)

    skier_id = int(str(skierJson["skier_id"]))
    ski_id = int(str(skierJson["ski_id"]))
    skis_returned = helperFunctions.check_equipment_return(str(skierJson["skis_back"]))
    skis_already = helperFunctions.check_equipment_return(str(skierJson["skis_already"]))
    boot_id = int(str(skierJson["boot_id"]))
    boots_returned = helperFunctions.check_equipment_return(str(skierJson["boots_back"]))
    boots_already = helperFunctions.check_equipment_return(str(skierJson["boots_already"]))
    helmet_id = int(str(skierJson["helmet_id"]))
    helmet_returned = helperFunctions.check_equipment_return(str(skierJson["helmet_back"]))
    helmet_already = helperFunctions.check_equipment_return(str(skierJson["helmet_already"]))
    rental_id = int(str(skierJson['rental_id']))

    if not skis_already:
        if skis_returned:
            db = pymysql.connect("localhost", "admin", "admin", "Ski_Clock_DB")
            today = helperFunctions.get_today_string()
            skierEquipmentQuery = 'UPDATE skier_equipment set skis_returned = "{}" WHERE skier_id = {} AND current_equipment = TRUE;'.format(today,skier_id)
            cursor = db.cursor()
            cursor.execute(skierEquipmentQuery)
            db.commit()
            if ski_id != 0:
                db = pymysql.connect("localhost", "admin", "admin", "Ski_Clock_DB")
                skisQuery = 'UPDATE skis SET skis_out = FALSE WHERE ski_id = {};'.format(ski_id)
                cursor = db.cursor()
                cursor.execute(skisQuery)
                db.commit()

    if not boots_already:
        if boots_returned:
            db = pymysql.connect("localhost", "admin", "admin", "Ski_Clock_DB")
            today = helperFunctions.get_today_string()
            skierEquipmentQuery = 'UPDATE skier_equipment set boots_returned = "{}" WHERE skier_id = {} AND current_equipment = TRUE;'.format(today, skier_id)
            cursor = db.cursor()
            cursor.execute(skierEquipmentQuery)
            db.commit()
            if boot_id != 0:
                db = pymysql.connect("localhost", "admin", "admin", "Ski_Clock_DB")
                bootsQuery = 'UPDATE boots SET boots_out = FALSE WHERE boot_id = {};'.format(boot_id)
                cursor = db.cursor()
                cursor.execute(bootsQuery)
                db.commit()

    if not helmet_already:
        if helmet_returned:
            db = pymysql.connect("localhost", "admin", "admin", "Ski_Clock_DB")
            skierEquipmentQuery = 'UPDATE skier_equipment set helmet_returned = "{}" WHERE skier_id = {} AND current_equipment = TRUE;'.format(today, skier_id)
            print(skierEquipmentQuery)
            cursor = db.cursor()
            cursor.execute(skierEquipmentQuery)
            db.commit()
            if helmet_id != 0:
                db = pymysql.connect("localhost", "admin", "admin", "Ski_Clock_DB")
                helmetQuery = 'UPDATE helmet SET helmet_out = FALSE WHERE helmet_id = {};'.format(helmet_id)
                cursor.execute(helmetQuery)
                db.commit()

    if skis_returned and boots_returned and helmet_returned:
        db = pymysql.connect("localhost", "admin", "admin", "Ski_Clock_DB")
        skierEquipmentQuery = 'UPDATE skier_equipment set current_equipment = FALSE WHERE skier_id = {} AND current_equipment = TRUE;'.format(skier_id)
        cursor = db.cursor()
        cursor.execute(skierEquipmentQuery)
        db.commit()
        cursor.close()

        db = pymysql.connect("localhost", "admin", "admin", "Ski_Clock_DB")
        updateSkiersReturnedQuey = 'UPDATE rentals set skiers_returned = skiers_returned + 1 WHERE rental_id = {} AND skiers_returned < skiers_picked_up;'.format(rental_id)
        cursor = db.cursor()
        cursor.execute(updateSkiersReturnedQuey)
        db.commit()
        cursor.close()

    db = pymysql.connect("localhost", "admin", "admin", "Ski_Clock_DB")
    setDateIn = 'UPDATE rentals set date_in = "{}" WHERE total_skiers = skiers_returned AND rental_id = {};'.format(today, rental_id)
    cursor = db.cursor()
    cursor.execute(setDateIn)
    db.commit()
    cursor.close()

    return jsonify("done")


@app.route('/overdue_returns')
def get_overdue_returns():
    db = pymysql.connect("localhost", "admin", "admin", "Ski_Clock_DB")
    cursor = db.cursor()
    yesterday = helperFunctions.get_yesterday()
    updateOverdueQuery = 'update rentals set overdue = TRUE where due_date = "{}" AND skiers_picked_up = total_skiers;'.format(yesterday)
    cursor.execute(updateOverdueQuery)
    db.commit()
    cursor.close()

    db = pymysql.connect("localhost", "admin", "admin", "Ski_Clock_DB")

    # rentalsQuery = 'SELECT last_name, first_name, rental_id, rentals.customer_id FROM customer, rentals WHERE (customer.customer_id = rentals.customer_id AND (rentals.overdue = TRUE)) Order BY customer.last_name ASC;'
    rentalsQuery = 'SELECT last_name, first_name, rental_id, rentals.customer_id FROM customer, rentals WHERE (customer.customer_id = rentals.customer_id AND (rentals.overdue = TRUE AND rentals.skiers_picked_up > 0 AND rentals.skiers_returned < rentals.skiers_picked_up)) Order BY customer.last_name ASC;'

    cursor = db.cursor()
    cursor.execute(rentalsQuery)
    rentals = [rentals[0] for rentals in cursor.description]

    rentalData = cursor.fetchall()
    rentalList=[]
    for element in rentalData:
        rentalList.append(dict(zip(rentals,element)))
    cursor.close()

    return jsonify(rentalList)

@app.route('/todays_returns')
def get_todays_returns():
    today = helperFunctions.get_today_string()
    db = pymysql.connect("localhost", "admin", "admin", "Ski_Clock_DB")

    rentalsQuery = 'SELECT last_name, first_name, rental_id, rentals.customer_id FROM customer, rentals WHERE (customer.customer_id = rentals.customer_id AND (rentals.due_date = "{}" AND rentals.skiers_picked_up > 0 AND rentals.skiers_returned < rentals.skiers_picked_up)) Order BY customer.last_name ASC;'.format(today)

    cursor = db.cursor()
    cursor.execute(rentalsQuery)
    rentals = [rentals[0] for rentals in cursor.description]

    rentalData = cursor.fetchall()
    rentalList=[]
    for element in rentalData:
        rentalList.append(dict(zip(rentals,element)))
    cursor.close()

    if rentalList == []:
        noReturns = {
        "customer_id": 0,
        "first_name": "No",
        "last_name": "Record",
        "rental_id": 0
        }
        return jsonify(noReturns)

    return jsonify(rentalList)

@app.route('/tomorrows_returns')
def get_tomorrows_returns():
    tomorrow = helperFunctions.get_tomorrows_date()
    db = pymysql.connect("localhost", "admin", "admin", "Ski_Clock_DB")

    rentalsQuery = 'SELECT last_name, first_name, rental_id, rentals.customer_id FROM customer, rentals WHERE (customer.customer_id = rentals.customer_id AND (rentals.due_date = "{}" AND rentals.skiers_picked_up > 0 AND rentals.skiers_returned < rentals.skiers_picked_up)) Order BY customer.last_name ASC;'.format(tomorrow)

    cursor = db.cursor()
    cursor.execute(rentalsQuery)
    rentals = [rentals[0] for rentals in cursor.description]

    rentalData = cursor.fetchall()
    rentalList=[]
    for element in rentalData:
        rentalList.append(dict(zip(rentals,element)))
    cursor.close()

    if rentalList == []:
        noReturns = {
        "customer_id": 0,
        "first_name": "No",
        "last_name": "Record",
        "rental_id": 0
        }
        return jsonify(noReturns)

    return jsonify(rentalList)

@app.route('/customer_skiers/<customer_id>')
def get_customer_skiers(customer_id):
    db = pymysql.connect("localhost", "admin", "admin", "Ski_Clock_DB")

    skiersQuery = 'SELECT skier_id, first_name, last_name, height, weight, age, skier_type FROM skier_info WHERE customer_id = {} ORDER BY first_name ASC;'.format(customer_id)

    cursor = db.cursor()
    cursor.execute(skiersQuery)
    skiers = [skiers[0] for skiers in cursor.description]

    skierData = cursor.fetchall()
    skierList = []
    for element in skierData:
        skierList.append(dict(zip(skiers, element)))
    cursor.close()

    if skierList == []:
        noSkiers = {
            "age": 0,
            "first_name": "No",
            "height": 0,
            "last_name": "Record",
            "skier_id": 0,
            "skier_type": 0,
            "weight": 0
        }
        return jsonify(noSkiers)

    return jsonify(skierList)

@app.route('/customer_rental_skiers/<rental_id>')
def get_customer_rental_skiers(rental_id):
    db = pymysql.connect("localhost", "admin", "admin", "Ski_Clock_DB")

    skiersQuery = 'SELECT skier_info.skier_id, first_name, last_name, height, weight, age, skier_type FROM skier_info INNER JOIN (SELECT skier_id FROM rentals_has_skiers WHERE rentals_has_skiers.rental_id = {})AS a ON skier_info.skier_id = a.skier_id ORDER BY first_name ASC;'.format(
        rental_id)
    cursor = db.cursor()
    cursor.execute(skiersQuery)
    skiers = [skiers[0] for skiers in cursor.description]

    skierData = cursor.fetchall()
    skierList = []
    for element in skierData:
        skierList.append(dict(zip(skiers, element)))
    cursor.close()

    if skierList == []:
        noSkiers = {
            "age": 0,
            "first_name": "No",
            "height": 0,
            "last_name": "Record",
            "skier_id": 0,
            "skier_type": 0,
            "weight": 0
        }
        return jsonify(noSkiers)

    return jsonify(skierList)


@app.route('/get_skier_info/<skier_id>')
def get_skier_info(skier_id):
    db = pymysql.connect("localhost", "admin", "admin", "Ski_Clock_DB")

    returnQuery = 'SELECT ski_id, boot_id FROM skier_equipment WHERE skier_id = {} AND latest_equipment = TRUE;'.format(skier_id)
    cursor = db.cursor()
    cursor.execute(returnQuery)
    skiers = [skiers[0] for skiers in cursor.description]

    returnData = cursor.fetchall()
    infoList = []
    for element in returnData:
        infoList.append(dict(zip(skiers, element)))
    if infoList == []:
        noEquipmentDict = {'ski_id': 0,
                     'length': 0,
                     'ski_manufacturer': 'N/A',
                     'ski_model': 'N/A',
                     'boot_id': 0,
                     'sole_length': 0,
                     'boot_manufacturer': 'N/A',
                     'boot_model': 'N/A',
                     'boot_size': 0.0
                    }
        return jsonify(noEquipmentDict)

    ski_id = infoList[0]["ski_id"]
    boot_id = infoList[0]["boot_id"]

    returnDict = {}
    cursor.close()

    if ski_id is not None:
        db = pymysql.connect("localhost", "admin", "admin", "Ski_Clock_DB")

        skiQuery = 'SELECT ski_id, length, manufacturer, model FROM skis WHERE ski_id = {};'.format(ski_id)
        cursor = db.cursor()
        cursor.execute(skiQuery)
        ski = [ski[0] for ski in cursor.description]

        skiData = cursor.fetchall()
        skiList = []
        for element in skiData:
            skiList.append(dict(zip(ski, element)))
        skiList[0]["ski_manufacture"] = skiList[0].pop("manufacturer")
        skiList[0]["ski_model"] = skiList[0].pop("model")

        returnDict = {**returnDict, **skiList[0]}
        cursor.close()
    else:
        noSkiDict = {'ski_id': 0,
                     'length': 0,
                     'ski_manufacturer': 'N/A',
                     'ski_model': 'N/A'}
        returnDict = {**returnDict, **noSkiDict}

    if boot_id is not None:
        db = pymysql.connect("localhost", "admin", "admin", "Ski_Clock_DB")

        bootQuery = 'SELECT boot_id, manufacturer, model, size, sole_length FROM boots WHERE boot_id = {};'.format(boot_id)
        cursor = db.cursor()
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
        cursor.close()
    else:
        noBootDict = {'boot_id': 0,
                     'sole_length': 0,
                     'boot_manufacturer': 'N/A',
                     'boot_model': 'N/A',
                     'boot_size': 0.0}
        returnDict = {**returnDict, **noBootDict}

    if cursor is not None:
        cursor.close()
    return jsonify(returnDict)


@app.route('/customer_new_skier', methods=['Post'])
def customer_new_skier():
    db = pymysql.connect("localhost", "admin", "admin", "Ski_Clock_DB")

    skierJson = request.get_json(force=True)

    fname = str(skierJson["fname"])
    lname = str(skierJson["lname"])
    weight = int(str(skierJson["weight"]))
    heightft = int(str(skierJson["heightft"]))
    heightin = int(str(skierJson["heightin"]))
    age = int(str(skierJson["age"]))
    rawSkierType = str(skierJson["skiertype"])
    customer_id = str(skierJson["customer_id"])

    height = (heightft * 12) + heightin
    skiertype = rawSkierType[0]

    db = pymysql.connect("localhost", "admin", "admin", "Ski_Clock_DB")

    skierQuery = 'INSERT INTO SKIER_INFO(customer_id, first_name, last_name, height, weight, age, skier_type) VALUES ("{}", "{}", "{}", "{}", "{}", "{}", "{}");'.format(customer_id, fname, lname, height, weight, age, skiertype)
    cursor = db.cursor()
    cursor.execute(skierQuery)
    db.commit()
    cursor.close()

    return jsonify("done")

@app.route('/customer_rentals/<customer_id>')
def get_customer_rentals(customer_id):
    db = pymysql.connect("localhost", "admin", "admin", "Ski_Clock_DB")

    rentalsQuery = 'SELECT rental_id, date_out, due_date, date_in FROM rentals WHERE customer_id = {};'.format(customer_id)

    cursor = db.cursor()
    cursor.execute(rentalsQuery)
    rentals = [rentals[0] for rentals in cursor.description]

    rentalData = cursor.fetchall()
    rentalList=[]
    for element in rentalData:
        rentalList.append(dict(zip(rentals,element)))
    cursor.close()

    if rentalList == []:
        noRentals = {
            "date_in": "No Record",
            "date_out": "No Record",
            "due_date": "No Record",
            "rental_id": 0
        }
        return jsonify(noRentals)

    return jsonify(rentalList)

@app.route('/get_skier_code_din/<height>/<weight>/<age>/<skier_type>/<sole_length>')
def get_skier_code_din(height, weight, age, skier_type, sole_length):
    skier_code = helperFunctions.get_skier_code(int(height), int(weight), int(age), int(skier_type))
    din = helperFunctions.get_din(skier_code, int(sole_length))

    infoDict = {"skier_code": skier_code, "din": str(din)}

    return jsonify(infoDict)


if __name__ == "__main__":
    app.run(host='0.0.0.0', debug=True)