class new:
  def firstde(self,name,age):      ##self is used to parse the class method
    self.name=name                 ## setting the data <<using at v1>>
    self.age=age
    print("{} age is {}".format(name,age))
## if u want to access methods inside class u need to create objects for that class
  
##creating a constructor method
## whenever u created a object these function will be called atomatically
  def __init__(self):
    print("Welcome to Google")

o1=new() ## here constructor method will be called
## if the constructor had some parameters u need to pass in the object itself like below
## o2 = new(google,60)
o1.firstde("amar",23)
print(o1.name) ## u can access the data means u had done the setting data to self <<v1>>
print(o1.age)
