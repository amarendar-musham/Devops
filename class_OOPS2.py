class student:
  def __init__ (self,name):
    self.name=name
    self.attend=0
    self.marks=[]
    print("Good Morning {}\n".format(name))
  
  def addmarks(self,ma):
    self.marks.append(ma)
  
  def attenda(self):
    self.attend += 1
  
  def avgmarks(self):
    print( sum(self.marks) / len(self.marks))
  
s1=student("amar")

print(s1.attend)
s1.attenda()
print(s1.attend)

print(s1.marks)
s1.addmarks(92)
s1.addmarks(84)
s1.addmarks(77)
s1.addmarks(72)
s1.addmarks(54)
print(s1.marks)
s1.avgmarks()
