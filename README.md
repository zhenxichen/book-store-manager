# 某书店书刊出租和零售管理系统

## 数据库
+ **book: 记录书本或报刊的基本信息**
  + ISBN: 书本的ISBN号码
  + title: 书本的标题
  + author: 书本的作者
  + type: 书本的类型（0为报刊, 1为书籍）
  + number: 书本库存
  + price: 书本售价
+ **customer: 记录顾客信息**
  + cid: 顾客id(纯数字)
  + name: 顾客姓名
  + address: 顾客地址(可不填)
+ **operator: 记录操作员信息**
  + username: 操作员用户名(登录用)
  + password: 操作员账号的密码
  + name: 操作员姓名
+ **order: 记录出售订单信息**
  + OrderID: 订单号
  + OperatorID: 操作员ID(对应operator表的username列)
  + amount: 订单金额
  + cid: 顾客ID
  + time: 订单时间
+ **rent: 记录出借订单信息** (每本书分开记录)
  + OrderID: 订单号
  + OperatorID: 操作员ID
  + ISBN: 书本的ISBN号
  + rent_time: 借出时间
  + return_date: 返还时间（若为NULL即未还）
  + due_date: 返还期限
  + cid: 顾客ID
+ **sell: 记录每本书的出售情况** (每本书分开记录)
  + key: 自增列，无特殊意义
  + ISBN: 书本ISBN号
  + cid: 顾客ID
  + OrderID: 订单号(书本是在哪个订单被卖出的)
  + OperatorID: 操作员ID
  + time: 出售时间

## 服务端API
1. Purchase<br>



