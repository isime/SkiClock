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

@app.route('/in_stock')
def get_in_stock_equipment():

    skisQuery = "SELECT ski_id, length, manufacturer, model FROM SKIS WHERE skis_out = FALSE;"
    bootsQuery = "SELECT boot_id, size, manufacturer, model, sole_length FROM BOOTS WHERE boots_out = FALSE;"
    helmetsQuery = "SELECT helmet_id, size, color FROM HELMET WHERE helmet_out = FALSE;"

    cursor = db.cursor()

    cursor.execute(skisQuery)
    skis = [skis[0] for skis in cursor.description]

    skiData = cursor.fetchall()
    skiList=[]
    for element in skiData:
        skiList.append(dict(zip(skis,element)))

    cursor.execute(bootsQuery)
    boots = [boots[0] for boots in cursor.description]

    bootsData = cursor.fetchall()
    bootsList=[]
    for element in bootsData:
        bootsList.append(dict(zip(boots,element)))

    cursor.execute(helmetsQuery)
    helmets = [helmets[0] for helmets in cursor.description]

    helmetData = cursor.fetchall()
    helmetList=[]
    for element in helmetData:
        helmetList.append(dict(zip(helmets,element)))

    return jsonify(skiList)

    # return jsonify({"skis": skiList, "boots": bootsList, "helmets": helmetList})


@app.route('/all_equipment')
def get_all_equipment():

    skisQuery = "SELECT ski_id, length, manufacturer, model FROM SKIS;"
    bootsQuery = "SELECT boot_id, size, manufacturer, model, sole_length FROM BOOTS;"
    helmetsQuery = "SELECT helmet_id, size, color FROM HELMET;"

    cursor = db.cursor()

    cursor.execute(skisQuery)
    skis = [skis[0] for skis in cursor.description]

    skiData = cursor.fetchall()
    skiList=[]
    for element in skiData:
        skiList.append(dict(zip(skis,element)))

    cursor.execute(bootsQuery)
    boots = [boots[0] for boots in cursor.description]

    bootsData = cursor.fetchall()
    bootsList=[]
    for element in bootsData:
        bootsList.append(dict(zip(boots,element)))

    cursor.execute(helmetsQuery)
    helmets = [helmets[0] for helmets in cursor.description]

    helmetData = cursor.fetchall()
    helmetList=[]
    for element in helmetData:
        helmetList.append(dict(zip(helmets,element)))


    return jsonify(skiList)
    # return jsonify({"skis": skiList, "boots": bootsList, "helmets": helmetList})



if __name__ == "__main__":
    app.run(debug=True)