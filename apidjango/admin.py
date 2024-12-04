from django.contrib import admin
from .models import *

class CustomUserAdmin(admin.ModelAdmin):
    ordering = ['id']

    list_display = ['id', 'username', 'CPF', 'acessLevel', 'status', 'display_pesquisas']

    def display_pesquisas(self, obj):
        # Exibe as pesquisas associadas ao usuário como uma string
        return ", ".join(str(pesquisa.id) for pesquisa in obj.pesquisas.all())
    display_pesquisas.short_description = "Pesquisas"
admin.site.register(CustomUser, CustomUserAdmin)


class RodoviaAdmin(admin.ModelAdmin):
    ordering = ['id']

    list_display = [field.name for field in Rodovia._meta.get_fields()]

admin.site.register(Rodovia, RodoviaAdmin)


class PesquisasAdmin(admin.ModelAdmin):
    ordering = ['id']

    list_display = ['id', 'admin', 'codigoIBGE', 'estado', 'municipio', 'display_usuario']

    def display_usuario(self, obj):
        return ", ".join(str(user) for user in obj.usuario.all())
    display_usuario.short_description = "Usuário"

admin.site.register(Pesquisa, PesquisasAdmin)
