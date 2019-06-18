
#include <iostream>
#include <Python.h>
using namespace std;


extern "C"
{
#include "Python.h"
}
//调用输出"Hello Python"函数
void Hello()
{
	//调用Py_Initialize()进行初始化
	Py_Initialize();
	PyObject * pModule = NULL;
	PyObject * pFunc = NULL;
	// 调用python的文件名
	pModule = PyImport_ImportModule("_pyTest");
	// 调用的函数名
	pFunc = PyObject_GetAttrString(pModule, "Hello");//调用的函数名
	// 调用的参数，NULL默认空
	PyEval_CallObject(pFunc, NULL);
	// 释放，与Py_Initialize相对应
	Py_Finalize();
}
//调用Add函数,传两个int型参数
void Add()
{
	// 初始化python
	Py_Initialize();
	PyObject * pModule = NULL;
	PyObject * pFunc = NULL;
	pModule = PyImport_ImportModule("_pyTest");
	pFunc = PyObject_GetAttrString(pModule, "Add");
	//创建参数，函数调用的参数传递均是以元组的形式打包的,2表示参数个数
	PyObject *pArgs = PyTuple_New(2);//
	//0序号,i表示创建int型变量
	PyTuple_SetItem(pArgs, 0, Py_BuildValue("i", 6));
	PyTuple_SetItem(pArgs, 1, Py_BuildValue("i", 8));
	//返回值
	PyObject *pReturn = NULL;
	pReturn = PyEval_CallObject(pFunc, pArgs);//调用函数
	//将返回值转换为int类型
	int result;
	PyArg_Parse(pReturn, "i", &result);//i表示转换成int型变量
	cout << "6 + 8 = " << result << endl;
	Py_Finalize();
}
int main(int argc, char** argv)
{
	cout << "调用Test001.py中的Hello函数..." << endl;
	Hello();
	cout << "\n调用Test001.py中的Add函数..." << endl;
	Add();
	system("pause");
	return 0;
}
