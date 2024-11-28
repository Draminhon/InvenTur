from django.contrib import admin
from .models import *

 
class CustomUserAdmin(admin.ModelAdmin):
    ordering = ['id']

    def get_list_display(self, request):
        return [field.name for field in CustomUser._meta.get_fields()]

# Registre o modelo com a classe de admin personalizada
admin.site.register(CustomUser, CustomUserAdmin)

class RodoviaAdmin(admin.ModelAdmin):
    ordering = ['id']

    def get_list_display(self, request):
        return [field.name for field in Rodovia._meta.get_fields()]


admin.site.register(Rodovia, RodoviaAdmin)

class PesquisasAdmin(admin.ModelAdmin):
    ordering = ['id']
    def get_list_display(self, request):
        return [field.name for field in Pesquisa._meta.get_fields()]

admin.site.register(Pesquisa, PesquisasAdmin)

# Register your models here.
