class Controllers:
    def __init__(self, controllersId, surname, firstname, PESEL, zodiac_sign, sex,
                 startEmploymentDate, salary, endEmploymentDate=None):
        self.controllersId = controllersId
        self.surname = surname
        self.firstname = firstname
        self.PESEL = PESEL
        self.zodiac_sign = zodiac_sign
        self.sex = sex
        self.startEmploymentDate = startEmploymentDate
        self.endEmploymentDate = endEmploymentDate
        self.salary = salary

    def get_Controller(self):
        return [self.controllersId, self.surname, self.firstname, self.PESEL, self.zodiac_sign, self.sex,
                self.startEmploymentDate, self.endEmploymentDate, self.salary]