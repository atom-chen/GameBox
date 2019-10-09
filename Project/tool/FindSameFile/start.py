#coding:utf-8
#!/usr/bin/env python

import os
import sys
import plistlib

# 文件列表，其原理就是两个目录的文件进行比较，查找出同名文件
fileList = {} 		

def getFrames(plist):
	for k in plist:
		if k == 'frames':
			dlist = list(plist['frames'].keys())
			return dlist
	return None

# 查找同名文件
def checkSame(root, filename, name, srclist, srcIndex):
	isHave = False
	for index, filelist in enumerate(fileList.values()):
		if filelist[2] == name and index > srcIndex:
			if not isHave:
				isHave = True
				print('------------------------ SameFile ------------------------')
				print(root + '\\' + filename + '(' + name + ')')
				srclist[3] = True
			filelist[3] = True
			print(filelist[0] + '\\' + filelist[1] + '(' + filelist[2] + ')')

# 搜索文件
def searchFile(path):
	# 遍历
	for root, dirs, files in os.walk(path):
		for filename in files:
			# 分离文件名和后缀
			suffix = os.path.splitext(filename)[1]
			if suffix == '.png':
				fileList.setdefault(len(fileList.keys()), [root, filename, filename, False])
			elif suffix == '.plist':
				plist = getFrames(plistlib.readPlist(root + '\\' + filename))
				if plist is None:
					continue
				for k in plist:
					fileList.setdefault(len(fileList.keys()), [root, filename, k, False])

	
	'''
	for key, value in fileList.items():
		print('{key}:{value}'.format(key=key, value=value))
	'''
	# 查找,通过enumerate将数据组合为[index,value]的索引序列
	for index, flist in enumerate(fileList.values()):
		if flist[3] is False:
			checkSame(flist[0], flist[1], flist[2], flist, index)

if __name__ == '__main__':
	path = ''
	if len(sys.argv) == 2:
		path = sys.argv[1]
	else:
		curpath = os.getcwd() 							# 当前目录
		parentpath = os.path.dirname(curpath)			# curpath的父目录
		grandparentpath = os.path.dirname(parentpath) 	# parentpath的父目录
		path = os.path.join(grandparentpath, 'res')
	
	print(u'查找的目录为:' + path)
	if os.path.isdir(path) is False:
		print(u'目录不存在!!!')
		sys.exit()

	# 查找同名文件
	searchFile(path)
