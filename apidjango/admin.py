from django.contrib import admin
from .models import CustomUser, Rodovia

 
class CustomUserAdmin(admin.ModelAdmin):
    list_display = ['id','username', 'email', 'CPF', 'is_staff', 'is_active']  # Campos exibidos na lista
    search_fields = ['username', 'email', 'CPF']  # Campos usados na pesquisa
    list_filter = ['is_staff', 'is_active']  # Filtros na barra lateral
    ordering = ['username']  # Ordem de exibição

# Registre o modelo com a classe de admin personalizada
admin.site.register(CustomUser, CustomUserAdmin)

class RodoviaAdmin(admin.ModelAdmin):
    ordering = ['id']

    def get_list_display(self, request):
        return [field.name for field in Rodovia._meta.get_fields()]


admin.site.register(Rodovia, RodoviaAdmin)



# Register your models here.
