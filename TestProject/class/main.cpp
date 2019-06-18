
#include <iostream>
#include <Python.h>
using namespace std;


extern "C"
{
#include "Python.h"
}
//�������"Hello Python"����
void Hello()
{
	//����Py_Initialize()���г�ʼ��
	Py_Initialize();
	PyObject * pModule = NULL;
	PyObject * pFunc = NULL;
	// ����python���ļ���
	pModule = PyImport_ImportModule("_pyTest");
	// ���õĺ�����
	pFunc = PyObject_GetAttrString(pModule, "Hello");//���õĺ�����
	// ���õĲ�����NULLĬ�Ͽ�
	PyEval_CallObject(pFunc, NULL);
	// �ͷţ���Py_Initialize���Ӧ
	Py_Finalize();
}
//����Add����,������int�Ͳ���
void Add()
{
	// ��ʼ��python
	Py_Initialize();
	PyObject * pModule = NULL;
	PyObject * pFunc = NULL;
	pModule = PyImport_ImportModule("_pyTest");
	pFunc = PyObject_GetAttrString(pModule, "Add");
	//�����������������õĲ������ݾ�����Ԫ�����ʽ�����,2��ʾ��������
	PyObject *pArgs = PyTuple_New(2);//
	//0���,i��ʾ����int�ͱ���
	PyTuple_SetItem(pArgs, 0, Py_BuildValue("i", 6));
	PyTuple_SetItem(pArgs, 1, Py_BuildValue("i", 8));
	//����ֵ
	PyObject *pReturn = NULL;
	pReturn = PyEval_CallObject(pFunc, pArgs);//���ú���
	//������ֵת��Ϊint����
	int result;
	PyArg_Parse(pReturn, "i", &result);//i��ʾת����int�ͱ���
	cout << "6 + 8 = " << result << endl;
	Py_Finalize();
}
int main(int argc, char** argv)
{
	cout << "����Test001.py�е�Hello����..." << endl;
	Hello();
	cout << "\n����Test001.py�е�Add����..." << endl;
	Add();
	system("pause");
	return 0;
}
