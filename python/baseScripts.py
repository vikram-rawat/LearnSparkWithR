import pandas

def read_flights(file):
  flights = pandas.read_csv(file)
  flights = flights[flights['dest'] == "ORD"]
  flights = flights[['carrier', 'dep_delay', 'arr_delay']]
  flights = flights.dropna()
  return flights

def add_data(a , b):
  value = a + b
  value2 = a * b
  return value2
  
class student:
  school = "DPS"
  def __init__(self, name , classn , subj ):
    self.name   = name
    self.classn = classn
    self.subj = subj
  def get_name(self):
    print(self.name)
  def get_classn(self):
    print(self.classn)
  def get_subj(self):
    print(self.subj)
  @classmethod
  def info(cls):
    return cls.school
  @staticmethod
  def nothing():
    print("asdfgasdf")

s1 = student("Vikram" , "B.Com" , "Finance")
s2 = student("Manish" , "B.Tech" , "CS")

s1.school = "nothing"
s2.school
s1.school
type(s1)
s1.get_name()
s2.info()
s1.info()
s1.nothing()

add_data(21,3)
