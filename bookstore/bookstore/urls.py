"""bookstore URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path
from depot import views

urlpatterns = [
    path('api/admin/', admin.site.urls),
    path('api/purchase/', views.purchase),
    path('api/depot/', views.depot),
    path('api/recordsell/', views.recordsell),
    path('api/newCustomer/', views.newCustomer),
    path('api/signup/', views.signup),
    path('api/login/', views.login),
    path('api/querysell/', views.querysell),
    path('api/recordrent/', views.recordrent),
    path('api/recordret/', views.recordret),
    path('api/queryrent/', views.queryrent),
    path('api/querybook/', views.querybook)
]
