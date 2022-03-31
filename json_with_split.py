class helloworld:
    hi = {
        'hey':'hello.world',
        'bye':'good'
    }
    
    
    def __init__(self):
        pass
    
    def hello(self, a=None, b=None):
        word = 'bye'
        a = self.hi[word].split('.')[0]
        print("a = " + a)
        try:
            if self.hi[word].split('.')[1]:
                b = self.hi[word].split('.')[1]
                print("b = " + b)
        except: print("no <b>")
        
p1 = helloworld()
p1.hello()
