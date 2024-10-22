from django.contrib import admin
from .models import CustomUser


class CustomUserAdmin(admin.ModelAdmin):
    list_display = ['username', 'email', 'CPF', 'is_staff', 'is_active']  # Campos exibidos na lista
    search_fields = ['username', 'email', 'CPF']  # Campos usados na pesquisa
    list_filter = ['is_staff', 'is_active']  # Filtros na barra lateral
    ordering = ['username']  # Ordem de exibição

# Registre o modelo com a classe de admin personalizada
admin.site.register(CustomUser, CustomUserAdmin)

# Register your models here.
