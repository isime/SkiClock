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


def get_yesterday():
    date = datetime.datetime.now()

    month = int(date.strftime("%m"))
    day = int(date.strftime("%d"))
    year = int(date.strftime("%Y"))

    today = {"month": month, "day": day, "year": year}
    yesterday = get_one_day_back(today)
    yesterdayString = yesterday["string"]

    return yesterdayString


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


def get_due_date(days):
    date = datetime.datetime.now()

    hour = int(date.strftime("%H"))
    month = int(date.strftime("%m"))
    day = int(date.strftime("%d"))
    year = int(date.strftime("%Y"))
    am = True

    if hour >= 12:
        am = False

    due_date = {"month": month, "day": day, "year": year}
    if am:
        i = 1
    else:
        i = 0
    while i < days:
        due_date = get_one_day_forward(due_date)
        i += 1

    due_date_string = get_date_string(due_date)

    return due_date_string


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


def get_today_string():
    date = datetime.datetime.now()
    month = date.strftime("%m")
    day = date.strftime("%d")
    year = date.strftime("%Y")
    today = month + "/" + day + "/" + year

    return today


def check_equipment_return(equipment):
    if equipment == 'true':
        returned = True
    else:
        returned = False

    return returned


def get_skier_code(height, weight, age, skier_type):
    skier_code_key = 1
    skier_code_dict = {1: "A", 2: "B", 3: "C", 4: "D", 5: "E", 6: "F",
                       7: "G", 8: "H", 9: "I", 10: "J", 11: "K", 12: "L",
                       13: "M", 14: "N", 15: "O", 16: "P"}
    weight_dict = {1: [22, 29], 2: [30, 38], 3: [39, 47], 4: [48, 56], 5: [57, 66],
                   6: [67, 78], 7: [79, 91], 8: [92, 107], 9: [108, 125], 10: [126, 147],
                   11: [148, 174], 12: [175, 209], 13: [210, 500]}
    height_dict = {8: [0, 58], 9: [59, 61], 10: [62, 65], 11: [66, 70], 12: [71, 76], 13: [77, 150]}

    for i in range(1, 16):
        if weight_dict[i][0] <= weight <= weight_dict[i][1]:
            skier_code_key = i
            break
        if i > 7:
            if height_dict[i][0] <= height <= height_dict[i][1]:
                skier_code_key = i
                break

    if age <= 9 or age >= 50:
        skier_code_key -= 1

    skier_code_key += (skier_type-1)

    return skier_code_dict[skier_code_key]


def get_din(skier_code, sole_length):
    sole_dict = {1: [0, 250], 2: [251, 270], 3: [271, 290], 4: [291, 310], 5: [311, 330], 6: [331, 500]}
    index = 1
    for i in range(1, 6):
        if sole_dict[i][0] <= sole_length <= sole_dict[i][1]:
            index = i
            break
    din = 0

    if skier_code == "A":
        din = 0.75
    elif skier_code == "B":
        b_dict = {1: 1, 2: 1, 3: 0.75, 4: 1.25, 5: 1.5, 6: 1.75}
        din = b_dict[index]
    elif skier_code == "C":
        c_dict = {1: 1.5, 2: 1.25, 3: 1.0, 4: 1.25, 5: 1.5, 6: 1.75}
        din = c_dict[index]
    elif skier_code == "D":
        d_dict = {1: 1.75, 2: 1.5, 3: 1.5, 4: 1.25, 5: 1.5, 6: 1.75}
        din = d_dict[index]
    elif skier_code == "E":
        e_dict = {1: 2.25, 2: 2.0, 3: 1.75, 4: 1.5, 5: 1.5, 6: 1.75}
        din = e_dict[index]
    elif skier_code == "F":
        f_dict = {1: 2.75, 2: 2.5, 3: 2.25, 4: 2.0, 5: 1.75, 6: 1.75}
        din = f_dict[index]
    elif skier_code == "G":
        g_dict = {1: 3.50, 2: 3.0, 3: 2.75, 4: 2.5, 5: 2.25, 6: 2.0}
        din = g_dict[index]
    elif skier_code == "H":
        h_dict = {1: 3.5, 2: 3.5, 3: 3.0, 4: 3.0, 5: 2.75, 6: 2.5}
        din = h_dict[index]
    elif skier_code == "I":
        i_dict = {1: 4.5, 2: 4.5, 3: 4.0, 4: 3.5, 5: 3.5, 6: 3.0}
        din = i_dict[index]
    elif skier_code == "J":
        j_dict = {1: 5.5, 2: 5.5, 3: 5.0, 4: 4.5, 5: 4.0, 6: 3.5}
        din = j_dict[index]
    elif skier_code == "K":
        k_dict = {1: 6.5, 2: 6.5, 3: 6.0, 4: 5.5, 5: 5.0, 6: 4.5}
        din = k_dict[index]
    elif skier_code == "L":
        l_dict = {1: 7.5, 2: 7.5, 3: 7.0, 4: 6.50, 5: 6.0, 6: 5.5}
        din = l_dict[index]
    elif skier_code == "M":
        m_dict = {1: 8.5, 2: 8.5, 3: 8.5, 4: 8.0, 5: 7.0, 6: 6.5}
        din = m_dict[index]
    elif skier_code == "N":
        n_dict = {1: 10.0, 2: 10.0, 3: 10.0, 4: 9.5, 5: 8.5, 6: 8.0}
        din = n_dict[index]
    elif skier_code == "O":
        o_dict = {1: 11.5, 2: 11.5, 3: 11.5, 4: 11.0, 5: 10.0, 6: 9.5}
        din = o_dict[index]
    elif skier_code == "P":
        p_dict = {1: 13.0, 2: 13.0, 3: 13.0, 4: 13.0, 5: 12.0, 6: 11.5}
        din = p_dict[index]

    return din


if __name__ == "__main__":
    skier_code = get_skier_code(71, 215, 20, 3)
    sole_length = 325
    print(skier_code, sole_length)
    print(get_din(skier_code, sole_length))

