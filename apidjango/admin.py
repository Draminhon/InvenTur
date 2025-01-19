from django.contrib import admin
from .models import *

class CustomUserAdmin(admin.ModelAdmin):
    ordering = ['id']

    list_display = ['id', 'username', 'CPF', 'acessLevel', 'status','email', 'display_pesquisas', 'is_active']

    def display_pesquisas(self, obj):
        # Exibe as pesquisas associadas ao usuário como uma string
        return ", ".join(str(pesquisa.id) for pesquisa in obj.pesquisas.all())
    display_pesquisas.short_description = "Pesquisas"
admin.site.register(CustomUser, CustomUserAdmin)

class ContatoInfoAdmin(admin.ModelAdmin):
    ordering = ['id']
    list_display = ['id', 'nome', 'endereco', 'whatsapp', 'email']
    search_fields = ['nome', 'email', 'whatsapp']
    list_filter = ['endereco']

class ServicoEspecializadoInfoAdmin(admin.ModelAdmin):
    ordering = ['id']
    list_display = ['id', 'email', 'servicos_especializados', 'outras_informacoes']
    search_fields = ['email', 'servicos_especializados']
    list_filter = ['email']

class SistemaDeSegurancaAdmin(admin.ModelAdmin):
    ordering = ['id']
    list_display = [
        'id', 'display_pesquisas', 'get_contatos_ids', 'get_servicos_ids',
        'tipo_formulario', 'uf', 'regiao_turistica', 'municipio',
        'tipo', 'observacoes', 'referencias',
        'nome_pesquisador', 'telefone_pesquisador', 'email_pesquisador',
        'nome_coordenador', 'telefone_coordenador', 'email_coordenador'
    ]
    def display_pesquisas(self, obj):
        # Exibe as pesquisas associadas ao usuário como uma string
        return str(obj.pesquisa.id) if obj.pesquisa else "Nenhuma pesquisa associada"
    display_pesquisas.short_description = "Pesquisa"    

    @admin.display(description='Contatos (IDs)')
    def get_contatos_ids(self, obj):
        return ", ".join(str(c.id) for c in obj.contatos.all())

    @admin.display(description='Serviços Especializados (IDs)')
    def get_servicos_ids(self, obj):
        return ", ".join(str(s.id) for s in obj.servicos_especializados.all())

# Registering models
admin.site.register(SistemaDeSeguranca, SistemaDeSegurancaAdmin)
admin.site.register(ContatoInfo, ContatoInfoAdmin)
admin.site.register(ServicoEspecializadoInfo, ServicoEspecializadoInfoAdmin)

class RodoviaAdmin(admin.ModelAdmin):
    ordering = ['id']
    list_display = [
        'id', 'display_pesquisas','tipo_formulario', 'uf', 'regiao_turistica', 'municipio',
        'tipo', 'subtipos', 'nome_oficial', 'nome_popular', 
        'jurisdicao', 'natureza', 'tipo_de_organizacao_instituicao', 
        'extensao_rodovia_municipio', 'faixas_de_rolamento', 'pavimentacao', 
        'pedagio', 'municipios_vizinhos_interligados_rodovia', 
        'inicio_atividade', 'whatsapp', 'instagram', 
        'sinalizacao_de_acesso', 'sinalizacao_turistica', 
        'posto_de_combustivel', 'outros_servicos', 'estruturas_ao_longo_da_via', 
        'poluicao', 'poluicao_especificacao', 'lixo', 'lixo_especificacao', 
        'desmatamento', 'desmatamento_especificacao', 'queimadas', 'queimadas_especificacao', 
        'inseguranca', 'inseguranca_especificacao', 'extrativismo', 'extrativismo_especificacao', 
        'prostituicao', 'prostituicao_especificacao', 'ocupacao_irregular_invasao', 
        'ocupacao_irregular_invasao_especificacao', 'outras', 'outras_especificacao', 
        'estado_geral_de_conservacao', 'observacoes', 'referencias', 
        'nome_pesquisador', 'telefone_pesquisador', 'email_pesquisador', 
        'nome_coordenador', 'telefone_coordenador', 'email_coordenador'
    ]
    search_fields = ['nome_oficial', 'municipio', 'uf']
    list_filter = ['jurisdicao', 'natureza', 'estado_geral_de_conservacao']
    date_hierarchy = 'inicio_atividade'

    def display_pesquisas(self, obj):
        # Exibe as pesquisas associadas ao usuário como uma string
        return str(obj.pesquisa.id) if obj.pesquisa else "Nenhuma pesquisa associada"
    display_pesquisas.short_description = "Pesquisa" 
admin.site.register(Rodovia, RodoviaAdmin)


class PesquisasAdmin(admin.ModelAdmin):
    ordering = ['id']

    list_display = ['id', 'dataInicio', 'dataTermino', 'admin', 'codigoIBGE', 'estado', 'municipio', 'display_usuario']

    def display_usuario(self, obj):
        return ", ".join(str(user) for user in obj.usuario.all())
    display_usuario.short_description = "Usuário"

admin.site.register(Pesquisa, PesquisasAdmin)
