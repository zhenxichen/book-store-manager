# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey and OneToOneField has `on_delete` set to the desired behavior
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models


class Book(models.Model):
    isbn = models.CharField(db_column='ISBN', primary_key=True, max_length=20)  # Field name made lowercase.
    title = models.CharField(max_length=30)
    author = models.CharField(max_length=30)
    type = models.IntegerField()
    number = models.IntegerField()
    price = models.FloatField()

    class Meta:
        managed = True
        db_table = 'book'


class Customer(models.Model):
    cid = models.IntegerField(primary_key=True)
    name = models.CharField(max_length=12)
    address = models.CharField(max_length=50, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'customer'


class Operator(models.Model):
    username = models.CharField(primary_key=True, max_length=12)
    password = models.CharField(max_length=30)
    name = models.CharField(max_length=10)

    class Meta:
        managed = False
        db_table = 'operator'


class Rent(models.Model):
    orderid = models.CharField(db_column='OrderID', primary_key=True, max_length=20)  # Field name made lowercase.
    operatorid = models.CharField(db_column='OperatorID', max_length=12)  # Field name made lowercase.
    isbn = models.CharField(db_column='ISBN', max_length=20)  # Field name made lowercase.
    rent_time = models.DateTimeField()
    return_date = models.DateField(db_column='Return_date', blank=True, null=True)  # Field name made lowercase.
    due_date = models.DateTimeField()
    cid = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'rent'


class Sell(models.Model):
    orderid = models.CharField(db_column='OrderID', primary_key=True, max_length=20)  # Field name made lowercase.
    operatorid = models.CharField(db_column='OperatorID', max_length=12)  # Field name made lowercase.
    amount = models.FloatField()
    cid = models.IntegerField()
    time = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'sell'
