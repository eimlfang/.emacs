import tkinter as tk
import sys
# sys.path.append("CoreGraphics")
# sys.path.append("CoreGraphics/CGGeometry")

class UIView(tk):
    def __init__(self,x,y,width,height):
        self.x = x
        self.y = y
        self.width = width
        self.height = height
        self = tk.Tk(className="title")
        
    def center(self):
        ''' Set UIView center '''
        ws = self.winfo_screenwidth()
        hs = self.winfo_screenheight()
        x = int( (ws/2) - (self.w/2) )
        y = int( (hs/2) - (self.h/2) )
        self.geometry('{}x{}+{}+{}'.format(self.w, self.h, x, y))
        
    def loop(self):
        self.resizable(False, False)   #禁止修改窗口大小
#        self.packBtn()
        self.center()                       #窗口居中
#        self.event()
        # self.craeteButtons()
        self.mainloop()