## <<v1>> not completed

class person:
  def __init__ (self,name,age):
    self.name=name
    self.age=age
    print("name is {} ; and age is {} \n".format(self.name,self.age))

o1=person("ad",3)
## inheritance
class teacher(person):
  def printing(self,name,age):
     person.__init(self,name,age)

## here no def is defined in teacher class
## inheritance happened
## calling the def in parent class 
## person.__init does that

ot=teacher("google",66)


#### another script----- OVERLOADING
## __str__ is used to print the object directly <<v1>>
## u can print it by print(object)
class parent:
  def __init__(self,name,age):
    self.name=name
    self.age=age
  def __str__(self):
    print("name is: {} \n age is: {}".format(self.name,self.age))
p1=parent("amar",11)

class child(parent):
  def __init__(self,name,age,sub):
    parent.__init__(self,name,age)
    self.sub=sub
  def __str__(self):
    parent.__str__(self)
    print("\n sub: {}".format(self.sub))
k1=child("amar",22,"science")
print(k1) ### <<v1>>
