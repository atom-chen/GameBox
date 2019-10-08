# -*- coding:utf-8 -*-


import traceback
from ToolMgr import MsgBox

if __name__  == "__main__":
    try: 
        messageBox = MsgBox()
    except Exception:
        traceback.print_exc()

