class Drivers:
    def __init__(self, surname, firstname, PESEL, zodiac_sign, sex, startEmploymentDate, endEmploymentDate=None):
        self.surname = surname
        self.firstname = firstname
        self.PESEL = PESEL
        self.zodiac_sign = zodiac_sign
        self.sex = sex
        self.startEmploymentDate = startEmploymentDate
        self.endEmploymentDate = endEmploymentDate

    def getDriver(self):
        return [self.surname, self.firstname, self.PESEL, self.zodiac_sign, self.sex,
                self.startEmploymentDate, self.endEmploymentDate]