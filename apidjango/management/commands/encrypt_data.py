import os
import django
from django.core.management.base import BaseCommand
from apidjango.models import CustomUser, ContatoInfo, InfoGerais, AlimentosEBebidas, Rodovia, MeioDeHospedagem, InformacaoBasicaDoMunicipio, ComercioTuristico, AgenciaDeTurismo, TransporteTuristico, EspacoParaEventos, ServicosParaEventos, Parques, EspacosDeDiversaoECultura, InformacoesTuristicas, EntidadesAssociativas, InstalacoesEsportivas, UnidadesDeConservacao, EventosProgramados
from apidjango.fields import EncryptionService

class Command(BaseCommand):
    help = 'Criptografa dados existentes no banco de dados'

    def handle(self, *args, **options):
        self.stdout.write("Iniciando processo de criptografia...")
        
        # 1. CustomUser
        users = CustomUser.objects.all()
        for user in users:
            # Forçamos a atualização para que os campos sejam criptografados no save()
            # O CustomUser.save() já cuida do email_hash e cpf_hash
            user.save()
        self.stdout.write(self.style.SUCCESS(f'CustomUser: {len(users)} registros processados.'))

        # Lista de modelos que usam EncryptedCharField mas não precisam de BlindIndex manual aqui
        # (A menos que queiramos garantir que campos vazios persistam como criptografados)
        models_to_process = [
            ContatoInfo, InfoGerais, AlimentosEBebidas, Rodovia, MeioDeHospedagem,
            InformacaoBasicaDoMunicipio, ComercioTuristico, AgenciaDeTurismo,
            TransporteTuristico, EspacoParaEventos, ServicosParaEventos, Parques,
            EspacosDeDiversaoECultura, InformacoesTuristicas, EntidadesAssociativas,
            InstalacoesEsportivas, UnidadesDeConservacao, EventosProgramados
        ]

        for model in models_to_process:
            items = model.objects.all()
            for item in items:
                item.save()
            self.stdout.write(self.style.SUCCESS(f'{model.__name__}: {len(items)} registros processados.'))

        self.stdout.write(self.style.SUCCESS('Processo concluído com sucesso!'))
