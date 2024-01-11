from math import floor

import pandas
import random
import openpyxl
import csv
import datetime
from classes.Bus import Bus

busesModels = ["Mercedes-Benz Citaro", "Volvo 9700", "Scania Interlink", "Neoplan Skyliner", "Setra S 431 DT",
               "MAN Lion's Coach", "Van Hool TX", "Irizar i6", "Temsa MD9", "Iveco Crossway", "BYD K9",
               "Solaris Urbino", "MCI J4500", "Nova Bus LFS", "Prevost X3-45", "Alexander Dennis",
               "Optare Versa", "Wright StreetDeck", "New Flyer Xcelsior", "Gillig Low Floor"]


def generateBuses(amount):  # amount must be between 0 and 10000
    with open("./csvs/Buses.csv", mode='w', newline='') as csv_file:
        writer = csv.writer(csv_file)
        for i in range(amount):
            bus = []
            bus.append(i + 1)  # bus number
            bus.append(random.randint(40, 100))  # capacity
            bus.append(random.randint(1980, 2010))  # year of production
            bus.append(random.choice(busesModels))  # bus model
            writer.writerow(bus)


def getStopsList():
    stopsNames = pandas.read_csv("./csvs/BusStops.csv", delimiter=';', encoding='utf-8')
    return stopsNames.iloc[:, 0].tolist()


# this weird function is made for randomizing how to divide time left, for a defined amount of periods of time
# so when we have 20min and 4 stops left, it will not divide it into {5, 5, 5, 5}, but more likely something like
# {5, 7, 3, 5}
def getRandomizedTime(time, denominator):
    avg = time / denominator
    if denominator == 1 or time == 0:
        return time
    elif time > 100:
        return random.randint(floor(avg) - 2, floor(avg) + 3)
    elif time > 35:
        return random.randint(floor(avg) - 1, floor(avg) + 2)
    return random.randint(floor(avg), floor(avg) + 1)


def ifEmployeeWasEmployedThen(excel, time, id):
    row = excel[id]
    startYear = int(row.startEmploymentDate[0:4])
    startMonth = int(row.startEmploymentDate[5:7])

    if startYear > time.year:
        return False
    if startYear == time.year and startMonth > time.month:
        return False

    if row.endEmploymentDate is None:
        return True

    endYear = int(row.endEmploymentDate[0:4])
    endMonth = int(row.endEmploymentDate[5:7])

    if endYear > time.year:
        return True
    if endYear == time.year and endMonth > time.month:
        return True
    return False


def changeNums(controllersExcel, driversExcel):
    numOfControllers = len(controllersExcel)
    numOfDrivers = len(driversExcel)

    with open("./csvs/Buses.csv", "r") as file:
        csv_reader = csv.reader(file)
        numOfBuses = sum(1 for row in csv_reader)

    return numOfControllers, numOfBuses, numOfDrivers

def setFilesPath(alter):
    if alter:
        return "./csvs_patchset2/Courses.csv", "./csvs_patchset2/Rides.csv", "./csvs_patchset2/Controls.csv"
    else:
        return "./csvs/Courses.csv", "./csvs/Rides.csv", "./csvs/Controls.csv"


def generateCoursesAndRides(beginning, ending, amount, numOfControllers, numOfBuses, controllersExcel, driversExcel, numOfDrivers, alt=False):
    deltaTime = (ending - beginning + 1) * 365 * 24 * 60 / amount  # difference between start of each route
    actualTime = datetime.datetime(beginning, 1, 1, 0, 0, 0)
    stopsList = getStopsList()
    controlerCounter = 0
    driverCounter = 0
    courseNumberOffset = 0  # used for consistency in id's

    coursesPath, ridesPath, controlesPath = setFilesPath(alt)

    if alt:
        numOfControllers, numOfBuses, numOfDrivers = changeNums(controllersExcel, driversExcel)
        with open("./csvs/Courses.csv", "r") as file:
            csv_reader = csv.reader(file)
            courseNumberOffset = sum(1 for row in csv_reader)

    with open(coursesPath, mode='w', newline='') as coursesFile:
        courseWriter = csv.writer(coursesFile)

        with open(ridesPath, mode='w', newline='') as ridesFile:
            ridesWriter = csv.writer(ridesFile)

            with open(controlesPath, mode='w', newline='') as controlsFile:
                controlsWriter = csv.writer(controlsFile)

                for courseNumber in range(amount):
                    course = []
                    course.append(courseNumber + courseNumberOffset)  # course id
                    plannedDuration = random.randint(80, 110)
                    course.append(plannedDuration)  # planned duration of journey
                    course.append(actualTime)  # start of journey
                    delay = random.randint(0, 20)
                    course.append(
                        actualTime + datetime.timedelta(
                            minutes=(plannedDuration + delay)))  # when the course actually ended
                    actualTime = actualTime + datetime.timedelta(minutes=deltaTime)  # incremented date of start
                    course.append(((courseNumber + courseNumberOffset) % 10) + 1)  # route number

                    while True:
                        if ifEmployeeWasEmployedThen(driversExcel, course[2], driverCounter % numOfDrivers):
                            course.append(driversExcel[driverCounter % numOfDrivers].PESEL)  # driver's id
                            break
                        else:
                            driverCounter += 1

                    course.append(random.randint(1, numOfBuses))  # bus id -> randomized

                    driverCounter += 1
                    courseWriter.writerow(course)

                    time = course[2]  # time variable for iterating and inserting data, at this point its moment when course started
                    durationLeft = plannedDuration  # helpers for inserting
                    delayLeft = delay  # and calculating how much time is left
                    for stopNumber in range(19):  # 20 - 1 = 19 -> number of rides in each course
                        ride = []
                        ride.append((courseNumber + courseNumberOffset) * 19 + stopNumber)  # ride ID

                        ridePlannedDuration = getRandomizedTime(durationLeft,
                                                                19 - stopNumber)  # randomizing ride duration
                        durationLeft -= ridePlannedDuration
                        ride.append(ridePlannedDuration)

                        rideDelay = getRandomizedTime(delayLeft, 19 - stopNumber)
                        delayLeft -= rideDelay

                        ride.append(time)  # real departure time
                        time = time + datetime.timedelta(minutes=(ridePlannedDuration + rideDelay))
                        ride.append(time)  # real arrival time

                        ride.append(stopsList[((courseNumber + courseNumberOffset) % 10) + 10 * stopNumber])  # bus stop of departure
                        ride.append(stopsList[((courseNumber + courseNumberOffset) % 10) + 10 * (stopNumber + 1)])  # bus stop of arrival
                        ride.append((courseNumber + courseNumberOffset))  # FK course id

                        ridesWriter.writerow(ride)

                        controlProbability = 0.24
                        if controlProbability > random.random():
                            control = []
                            control.append(ride[0])  # ride's id

                            while True:
                                if ifEmployeeWasEmployedThen(controllersExcel, time, controlerCounter % numOfControllers):
                                    break
                                else:
                                    controlerCounter += 1

                            control.append(controlerCounter % numOfControllers)  # controler's id

                            control.append(random.randint(10, 40))  # number of correct tickets
                            control.append(random.randint(0, floor(control[2] / 2)))  # number of no tickets
                            control.append(random.randint(0, floor(control[2] / 3)))  # number of no documents

                            controlerCounter += 1
                            controlsWriter.writerow(control)