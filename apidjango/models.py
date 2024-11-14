from django.db import models
from django.contrib.auth.models import AbstractUser
from django.core.exceptions import ValidationError
from django.core.validators import RegexValidator

 
def validate_cpf(cpf):
    cpf = ''.join(filter(str.isdigit, cpf))

    if len(cpf) != 11:
        raise ValidationError("O CPF deve ter 11 digítos")
    
    if cpf == cpf[0] * len(cpf):
        raise ValidationError("O CPF não pode ter todos os dígitos iguais")

    def calcular_digito(cpf, peso):
        soma = sum(int(d) * peso for d, peso in zip(cpf[:-2], range(peso, 1, -1)))
        resto = 11 - (soma % 11)
        return '0' if resto >= 10 else str(resto)
    
    digito1 = calcular_digito(cpf, 10)
    digito2 = calcular_digito(cpf + digito1, 11)

    if cpf[-2:] != digito1 + digito2:
        raise ValidationError("O CPF é inválido")
    
class CustomUser(AbstractUser):
    CPF = models.CharField(max_length=11, unique=True)
    username = models.CharField(
        max_length = 150,
        unique=True,
         validators=[
            RegexValidator(
                regex=r'^[\w\sáéíóúãõâêîôûçÁÉÍÓÚÃÕÂÊÎÔÛÇ]+$',
                message="O nome de usuário pode conter letras, números e espaços."
            )
        ],
    )
    acessLevel = models.CharField(max_length=22, default='Pesquisador');
    status = models.CharField(max_length=50, default='Aguardando Aprovação')
    def clean(self):
        super().clean()
        validate_cpf(self.CPF)
# Create your models here.


class Base(models.Model):
    
    criacao = models.DateField(auto_now_add=True)
    atualizacao = models.DateTimeField(auto_now = True)
    tipo_formulario = models.CharField(max_length=100)
    uf = models.CharField(max_length=255)
    regiao_turistica = models.CharField(max_length=255)
    municipio = models.CharField(max_length=255)

    tipo = models.CharField(max_length=255)
    subtipos = models.CharField(max_length=255)

    nome_oficial = models.CharField(max_length=255)
    nome_popular = models.CharField(max_length=255)



class Rodovia(Base):
    jurisdicao = models.CharField(max_length=50)
    natureza = models.CharField(max_length=50)
   
    
    tipo_de_organizacao_instituicao = models.JSONField()
    
 


    extensao_rodovia_municipio = models.DecimalField(max_digits=10, decimal_places=2)

    faixas_de_rolamento = models.CharField(max_length=50)

    pavimentacao = models.CharField(max_length=50)

    pedagio = models.CharField(max_length=10)

    municipios_vizinhos_interligados_rodovia = models.TextField()

    inicio_atividade = models.DateField()

    ##Entidade mantedora

    whatsapp = models.CharField(max_length=50)
    instagram = models.CharField(max_length=50)

    ##Sinalização

    sinalizacao_de_acesso = models.CharField(max_length=10)
    sinalizacao_turistica = models.CharField(max_length=10)

    ##Características

    posto_de_combustivel = models.JSONField()
    outros_servicos = models.JSONField()
    estruturas_ao_longo_da_via = models.JSONField()

    ##Questões ambientais/Sociais

    poluicao = models.CharField(max_length=10)
    poluicao_especificacao = models.TextField()

    lixo = models.CharField(max_length=10)
    lixo_especificacao = models.TextField()

    desmatamento = models.CharField(max_length=10)
    desmatamento_especificacao = models.TextField()

    queimadas = models.CharField(max_length=10)
    queimadas_especificacao = models.TextField()

    inseguranca = models.CharField(max_length=10)
    inseguranca_especificacao = models.TextField()

    extrativismo = models.CharField(max_length=10)
    extrativismo_especificacao = models.TextField()

    prostituicao = models.CharField(max_length=10)
    prostituicao_especificacao = models.TextField()

    ocupacao_irregular_invasao = models.CharField(max_length=10)
    ocupacao_irregular_invasao_especificacao = models.TextField()

    outras = models.CharField(max_length=10)
    outras_especificacao = models.TextField()

    ##Estado geral de conservação

    estado_geral_de_conservacao = models.CharField(max_length=20)

    ##Observações

    observacoes = models.TextField()
    referencias = models.TextField()

    nome_pesquisador = models.CharField(max_length=255)
    telefone_pesquisador = models.CharField(max_length=255)
    email_pesquisador = models.CharField(max_length=255)

    nome_coordenador = models.CharField(max_length=255)
    telefone_coordenador = models.CharField(max_length=255)
    email_coordenador = models.CharField(max_length=255)

