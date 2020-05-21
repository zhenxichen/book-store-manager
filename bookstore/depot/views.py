from django.shortcuts import render
from django.http import HttpResponse
from depot import models

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



