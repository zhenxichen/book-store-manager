from django.shortcuts import render
from django.http import HttpResponse
from django.utils import timezone
from depot import models
import json
import random

# Create your views here.

def purchase(request):
	# 实现进货功能(即库存补充以及新增商品)
	ISBN = request.POST.get('ISBN')		#ISBN
	title = request.POST.get('title')	#书名
	author = request.POST.get('author')	#作者
	number = request.POST.get('number') #进货数量
	price = request.POST.get('price')	#价格
	Type = request.POST.get('type')		#类型：书籍/报刊

	lines = models.Book.objects.filter(isbn= ISBN)
	if len(lines) == 0:
		#无现有库存，添加该书信息
		models.Book.objects.create(isbn=ISBN, title=title, author=author, \
		type=Type, number= number, price=price)
	else:
		#已有库存，只需修改库存数量
		number_before = lines[0].number
		newNum = number_before + int(number)
		lines.update(number= newNum)
	return HttpResponse("success")

def depot(request):
	# 实现查看库存功能
	books = models.Book.objects.all()
	bookList = []
	for line in books:
		bookInfo = { }
		bookInfo['ISBN'] = line.isbn
		bookInfo['title'] = line.title
		bookInfo['author'] = line.author
		bookInfo['type'] = line.type
		bookInfo['number'] = line.number
		bookInfo['price'] = line.price
		bookList.append(bookInfo)
	depotInfo = {
		'bookList': bookList
	}
	depotStr = str(depotInfo)
	return HttpResponse(depotStr)

def querysell(request):
	# 查询零售订单记录
	# 需要返回订单号, 客户姓名, 客户id, 订单时间, 操作员姓名, 金额
	sells = models.Order.objects.all()
	sellList = []
	for line in sells:
		sellInfo = { }
		sellInfo['OrderID'] = line.orderid
		cid = line.cid
		sellInfo['CustomerID'] = cid
		customer = models.Customer.objects.filter(cid= cid)
		sellInfo['CustomerName'] = customer.name
		sellInfo['time'] = line.time
		oid = line.operatorid
		operator = models.Operator.objects.filter(username= oid)
		sellInfo['operator'] = operator.name
		sellInfo['amount'] = line.amount
		sellList.append(sellInfo)
	info = {
		'sellList': sellList
	}
	infoStr = str(info)
	return HttpResponse(infoStr)

def recordsell(request):
	# 记录零售数据
	cid = request.POST.get('CustomerID')
	#查询cid是否存在
	customer = models.Customer.objects.filter(cid= cid)
	if len(customer) == 0:
		return HttpResponse("Customer Not Found.")
	oid = request.POST.get('OperatorID')
	isbnList = request.POST.getlist('isbn[]')
	amount = request.POST.get('amount')
	currTime = timezone.localtime(timezone.now())
	randNum = random.randint(0, 9)
	orderid = currTime.strftime('%Y%m%d%H%M%S') + str(randNum)
	for isbn in isbnList:
		book = models.Book.objects.filter(isbn= isbn)
		if len(book) == 0:
			return HttpResponse("Wrong ISBN")	#ISBN号码错误
		number = book[0].number - 1
		book.update(number= number)
		models.Sell.objects.create(isbn=isbn, cid=cid, orderid=orderid, \
		operatorid=oid, time=currTime)
	models.Order.objects.create(orderid=orderid, operatorid= oid, amount=amount, \
	cid=cid, time=currTime)
	return HttpResponse("Finish")

def newCustomer(request):
	#顾客注册
	cid = request.POST.get('CustomerID')
	customer = models.Customer.objects.filter(cid= cid)
	name = request.POST.get('name')
	address = request.POST.get('address')
	if len(customer) == 0:
		#若不存在该账号, 则新建
		if address == '':
			models.Customer.objects.create(cid= cid, name= name)
		else:
			models.Customer.objects.create(cid=cid, name=name, address=address)
	else:
		#若已存在账号, 则提示
		return HttpResponse("ID existed")
	return HttpResponse("success")

def signup(request):
	#操作员注册账号
	username = request.POST.get('username')
	password = request.POST.get('password')
	name = request.POST.get('name')
	check = models.Operator.objects.filter(username= username)
	if len(check) == 0:
		#当前用户名无重复
		models.Operator.objects.create(username=username, password=password, name=name)
	else:
		#若用户名重复
		return HttpResponse("Username existed")
	return HttpResponse("success")

def login(request):
	username = request.POST.get('username')
	password = request.POST.get('password')
	check = models.Operator.objects.filter(username= username)
	if len(check) == 0:
		return HttpResponse("Username Not Exist")
	else:
		UserInfo = check[0]
		if password == UserInfo.password:
			#密码匹配
			retInfo = { }
			retInfo['username'] = username
			retInfo['name'] = UserInfo.name
			return HttpResponse(str(retInfo))
		else:
			#密码不匹配
			return HttpResponse("Wrong Password.")





	




