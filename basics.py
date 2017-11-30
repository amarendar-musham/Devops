import calendar
print(calendar.month(1993,11))
for i in range(1,10):
  print("{:2}{:3}{:4}".format(i,i*i,i*i*i))
a=input("enter a vowel")
if ((a=='a')|(a=='e')|(a=='i')|(a=='o')|(a=='u')) :
  print("entered is vowel")
else: 
  print("fuck you")
a,b,c=input("enter 3  digits without any separation")
if ((a>b)&(a>c)):
  print(a + " is big")
elif ((b>c)):
  print(b + " is big")
else:
  print(c + " is big")
#print("\n")
k=1
n=int(input("enter a no to print no. till that no."))
for i in range(n):
  print (i, end=", ")
  if(i!=0):
    k=k*i
print("\n" + str(k) + " is the factorial of the no. u had entered \n")
k=1
n=int(input("enter a no to print no. till that no."))
for i in range(1,n):
  print (i, end=", ")
  k=k*i
print("\n" + str(k) + " is the factorial of the no. u had entered \n")

i=0
while (i<=n):
  print(i,end=", ")
  i+=1
print("\n")
#obj=open("path to file", 'w')
#obj.write("good")
#obj.read()
#obj.close()
#import os
#os.rename("path to file","new name with pat")
#os.remove("path to file")
#os.mkdir("hii")
#os.getcwd() ## print the current working directory
#os.chdir("path to dir with escap seq "\" ") ## rmdir 

a=int(input("enter a no."))
b=int(input("enter another"))
try:
  k=a/b
except:
  print("exception raised")
else:
  print(k)
  print("first no %s is devided by second no %s \n result came up as %s"%(a,b,k)) ## to get integer use %d 
  print("first no {} is devided by second no {} \n result here is {}".format(a,b,k))
