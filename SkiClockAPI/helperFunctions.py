import datetime


def get_overdue_dates():
    datesList = []

    date = datetime.datetime.now()

    month = int(date.strftime("%m"))
    day = int(date.strftime("%d"))
    year = int(date.strftime("%Y"))

    today = {"month": month, "day": day, "year": year}

    oneDay = get_one_day_back(today)

    datesList.append(oneDay["string"])

    twoDays = get_one_day_back(oneDay)
    datesList.append(twoDays["string"])

    threeDays = get_one_day_back(twoDays)
    datesList.append(threeDays["string"])
    print(datesList)

    return datesList


def get_one_day_back(date):
    shortMonths = [4, 6, 9, 11]
    month = date["month"]
    day = date["day"]
    year = date["year"]

    if day == 1:
        if month == 1:
            newMonth = 12
            newYear = year - 1
            newDay = 31
        else:
            newYear = year
            newMonth = month - 1
            if newMonth == 2:
                newDay = 28
            elif newMonth in shortMonths:
                newDay = 30
            else:
                newDay = 31
    else:
        newDay = day - 1
        newMonth = month
        newYear = year



    dateDict = {"month": newMonth, "day": newDay, "year": newYear}
    dateString = get_date_string(dateDict)
    dateDict['string'] = dateString

    return dateDict


def get_date_string(date):
    month = date["month"]
    day = date["day"]
    year = date["year"]

    if month < 10:
        stringMonth = '0' + str(month)
    else:
        stringMonth = str(month)
    if day < 10:
        stringDay = '0' + str(day)
    else:
        stringDay = str(day)

    dateString = stringMonth + '/' + stringDay + '/' + str(year)

    return dateString


def get_tomorrows_date():
    date = datetime.datetime.now()

    month = int(date.strftime("%m"))
    day = int(date.strftime("%d"))
    year = int(date.strftime("%Y"))

    today = {"month": month, "day": day, "year": year}
    tomorrow = get_one_day_forward(today)
    tomorrowString = get_date_string(tomorrow)

    return tomorrowString


def get_one_day_forward(today):
    shortMonths = [4, 6, 9, 11]
    month = today['month']
    day = today['day']
    year = today['year']

    if day >= 28:
        if month == 2:
            newMonth = 3
            newDay = 1
            newYear = year
        elif month in shortMonths and day == 30:
            newMonth = month + 1
            newDay = 1
            newYear = year
        elif day == 31:
            if month == 12:
                newMonth = 1
                newDay = 1
                newYear = year + 1
            else:
                newMonth = month + 1
                newDay = 1
        else:
            newMonth = month
            newDay = day + 1
    else:
        newMonth = month
        newDay = day + 1
        newYear = year

    tomorrow = {"month": newMonth, "day": newDay, "year": newYear}

    return tomorrow