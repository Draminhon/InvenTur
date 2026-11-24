from rest_framework import  permissions, viewsets, status, views
from rest_framework.permissions import IsAuthenticated
from rest_framework_simplejwt.authentication import JWTAuthentication
from ..serializers import *
from ..models import *
from django.http import HttpResponse, JsonResponse
from rest_framework.views import APIView
from rest_framework.response import Response
from ..permissoes import EscopoPesquisaMixin, equipamentos_visiveis, exigir_pesquisa_visivel
 
class RodoviaViewSet(EscopoPesquisaMixin, viewsets.ModelViewSet):

    """
    Expondo endpoints para:
      - list (GET    /rodovias/)
      - retrieve (GET    /rodovias/{pk}/)
      - create   (POST   /rodovias/)
      - update   (PUT    /rodovias/{pk}/)
      - partial  (PATCH  /rodovias/{pk}/)
      - destroy  (DELETE /rodovias/{pk}/)
    """

    queryset = Rodovia.objects.filter(is_active=True)
    serializer_class = RodoviaSerializer

    authentication_classes = [JWTAuthentication]
    permission_classes = [IsAuthenticated]

    def perform_create(self, serializer):
        serializer.save(usuario_criador=self.request.user)

    def partial_update(self, request, *args, **kwargs):
        kwargs['partial'] = True
        return super().update(request, *args, **kwargs)

class SistemaDeSegurancaViewSet(EscopoPesquisaMixin, viewsets.ModelViewSet):

    queryset = SistemaDeSeguranca.objects.filter(is_active=True)
    serializer_class = SistemaDeSegurancaSerializer

    authentication_classes = [JWTAuthentication]
    permission_classes = [IsAuthenticated]
    def perform_create(self, serializer):
        serializer.save(usuario_criador=self.request.user)
    def partial_update(self, request, *args, **kwargs):
        kwargs['partial'] = True
        return super().update(request, *args, **kwargs)
    
class LocadoraDeImoveisViewSet(EscopoPesquisaMixin, viewsets.ModelViewSet):

    queryset = LocadorasDeImoveis.objects.filter(is_active=True)
    serializer_class = LocadorasDeImoveisSerializer

    authentication_classes = [JWTAuthentication]
    permission_classes = [IsAuthenticated]
    def perform_create(self, serializer):
        serializer.save(usuario_criador=self.request.user)
    def partial_update(self, request, *args, **kwargs):
        kwargs['partial'] = True
        return super().update(request, *args, **kwargs)

class GuiamentoEConducaoTuristicaViewSet(EscopoPesquisaMixin, viewsets.ModelViewSet):

    queryset = GuiamentoEConducaoTuristica.objects.filter(is_active=True)
    serializer_class = GuiamentoEConducaoTuristicaSerializer

    authentication_classes = [JWTAuthentication]
    permission_classes = [IsAuthenticated]
    def perform_create(self, serializer):
        serializer.save(usuario_criador=self.request.user)
    def partial_update(self, request, *args, **kwargs):
        kwargs['partial'] = True
        return super().update(request, *args, **kwargs)
    
class AlimentosEBebidasViewSet(EscopoPesquisaMixin, viewsets.ModelViewSet):

    queryset = AlimentosEBebidas.objects.filter(is_active=True)
    serializer_class = AlimentosEBebidasSerializer

    authentication_classes = [JWTAuthentication]
    permission_classes = [IsAuthenticated]
    def perform_create(self, serializer):
        serializer.save(usuario_criador=self.request.user)
    def partial_update(self, request, *args, **kwargs):
        kwargs['partial'] = True
        return super().update(request, *args, **kwargs)

class MeioDeHospedagemViewSet(EscopoPesquisaMixin, viewsets.ModelViewSet):

    queryset = MeioDeHospedagem.objects.filter(is_active=True)
    serializer_class = MeioDeHospedagemSerializer

    authentication_classes = [JWTAuthentication]
    permission_classes = [IsAuthenticated]
    def perform_create(self, serializer):
        serializer.save(usuario_criador=self.request.user)
    def partial_update(self, request, *args, **kwargs):
        kwargs['partial'] = True
        return super().update(request, *args, **kwargs)


class InformacoesBasicasViewSet(EscopoPesquisaMixin, viewsets.ModelViewSet):

    queryset = InformacaoBasicaDoMunicipio.objects.filter(is_active=True)
    serializer_class = InformacoesBasicasSerializer

    authentication_classes = [JWTAuthentication]
    permission_classes = [IsAuthenticated]
    def perform_create(self, serializer):
        serializer.save(usuario_criador=self.request.user)

class ComercioTuristicoViewSet(EscopoPesquisaMixin, viewsets.ModelViewSet):
    queryset = ComercioTuristico.objects.filter(is_active=True)
    serializer_class = ComercioTuristicoSerializer

    authentication_classes = [JWTAuthentication]
    permission_classes = [IsAuthenticated]
    def perform_create(self, serializer):
        serializer.save(usuario_criador=self.request.user)
class OutromeiodehospedagemViewSet(EscopoPesquisaMixin, viewsets.ModelViewSet):
    queryset = OutrosMeiosDeHospedagem.objects.filter(is_active=True)
    serializer_class = OutrosMeiosDeHospedagemSerializer

    authentication_classes = [JWTAuthentication]
    permission_classes = [IsAuthenticated]
    def perform_create(self, serializer):
        serializer.save(usuario_criador=self.request.user)
class AgenciaDeTurismoViewSet(EscopoPesquisaMixin, viewsets.ModelViewSet):
    queryset = AgenciaDeTurismo.objects.filter(is_active=True)
    serializer_class = AgenciaDeTurismoSerializer

    authentication_classes = [JWTAuthentication]
    permission_classes = [IsAuthenticated]
    def perform_create(self, serializer):
        serializer.save(usuario_criador=self.request.user)
class TransporteTuristicoViewSet(EscopoPesquisaMixin, viewsets.ModelViewSet):
    queryset = TransporteTuristico.objects.filter(is_active=True)
    serializer_class = TransporteTuristicoSerializer
    
    authentication_classes = [JWTAuthentication]
    permission_classes = [IsAuthenticated]
    def perform_create(self, serializer):
        serializer.save(usuario_criador=self.request.user)
class EspacoParaEventosViewSet(EscopoPesquisaMixin, viewsets.ModelViewSet):
    queryset = EspacoParaEventos.objects.filter(is_active=True)
    serializer_class = EspacoParaEventosSerializer
    
    authentication_classes = [JWTAuthentication]
    permission_classes = [IsAuthenticated]
    def perform_create(self, serializer):
        serializer.save(usuario_criador=self.request.user)   
class ServicosParaEventosViewSet(EscopoPesquisaMixin, viewsets.ModelViewSet):
    queryset = ServicosParaEventos.objects.filter(is_active=True)
    serializer_class = ServicosParaEventosSerializer
    
    authentication_classes = [JWTAuthentication]
    permission_classes = [IsAuthenticated]   
    def perform_create(self, serializer):
        serializer.save(usuario_criador=self.request.user)
class ParquesViewSet(EscopoPesquisaMixin, viewsets.ModelViewSet):
    queryset = Parques.objects.filter(is_active=True)
    serializer_class = ParquesSerializer
    
    authentication_classes = [JWTAuthentication]
    permission_classes = [IsAuthenticated]
    def perform_create(self, serializer):
        serializer.save(usuario_criador=self.request.user)
class EspacosDeDiversaoECulturaViewSet(EscopoPesquisaMixin, viewsets.ModelViewSet):
    queryset = EspacosDeDiversaoECultura.objects.filter(is_active=True)
    serializer_class = EspacosDeDiversaoECulturaSerializer
    
    authentication_classes = [JWTAuthentication]
    permission_classes = [IsAuthenticated]
    def perform_create(self, serializer):
        serializer.save(usuario_criador=self.request.user)
class InformacoesTuristicasViewSet(EscopoPesquisaMixin, viewsets.ModelViewSet):
    queryset = InformacoesTuristicas.objects.filter(is_active=True)
    serializer_class = InformacoesTuristicasSerializer
    
    authentication_classes = [JWTAuthentication]
    permission_classes = [IsAuthenticated]
    def perform_create(self, serializer):
        serializer.save(usuario_criador=self.request.user)
class EntidadesAssociativasViewSet(EscopoPesquisaMixin, viewsets.ModelViewSet):
    queryset = EntidadesAssociativas.objects.filter(is_active=True)
    serializer_class = EntidadesAssociativasSerializer

    authentication_classes = [JWTAuthentication]
    permission_classes = [IsAuthenticated]
    def perform_create(self, serializer):
        serializer.save(usuario_criador=self.request.user)   
class InstalacoesEsportivasViewSet(EscopoPesquisaMixin, viewsets.ModelViewSet):
    queryset = InstalacoesEsportivas.objects.filter(is_active=True)
    serializer_class = InstalacoesEsportivasSerializer

    authentication_classes = [JWTAuthentication]
    permission_classes = [IsAuthenticated]
    def perform_create(self, serializer):
        serializer.save(usuario_criador=self.request.user)
class UnidadesDeConservacaoViewSet(EscopoPesquisaMixin, viewsets.ModelViewSet):
    queryset = UnidadesDeConservacao.objects.filter(is_active=True)
    serializer_class = UnidadesDeConservacaoSerializer

    authentication_classes = [JWTAuthentication]
    permission_classes = [IsAuthenticated]
    def perform_create(self, serializer):
        serializer.save(usuario_criador=self.request.user)    
class EventosProgramadosViewSet(EscopoPesquisaMixin, viewsets.ModelViewSet):
    queryset = EventosProgramados.objects.filter(is_active=True)
    serializer_class = EventosProgramadosSerializer

    authentication_classes = [JWTAuthentication]
    permission_classes = [IsAuthenticated]
    def perform_create(self, serializer):
        serializer.save(usuario_criador=self.request.user)    
class GastronomiaArtesanatoViewSet(EscopoPesquisaMixin, viewsets.ModelViewSet):
    queryset = GastronomiaArtesanato.objects.filter(is_active=True)
    serializer_class = GastronomiaArtesanatoSerializer

    authentication_classes = [JWTAuthentication]
    permission_classes = [IsAuthenticated]
    def perform_create(self, serializer):
        serializer.save(usuario_criador=self.request.user)
        
            
class EquipamentosListView(APIView):
    
    
    def get(self, request, *args, **kwargs):
        pesquisa_id = request.query_params.get('pesquisa_id')
        user = request.user
        if not pesquisa_id:
            # Resposta 400 (antes levantava o ValidationError do Django, que o DRF não trata: virava erro 500)
            return Response({"detail": "O parâmetro 'pesquisa_id' é obrigatório."}, status=400)
        # Só pesquisas no escopo do usuário (admin: as que criou; pesquisador: as da equipe); senão 404
        pesquisa_id = exigir_pesquisa_visivel(user, pesquisa_id)

        filtros = {
            'pesquisa_id': pesquisa_id,
            'is_active': True
        }
        

        
        # Rodovias
        rodovias = equipamentos_visiveis(Rodovia.objects.all(), user).filter(**filtros)
        rodovias_serialized = [
            {"tipo": "Rodovia", "dados": RodoviaSerializer(rodovia).data}
            for rodovia in rodovias
        ]

        # Sistemas de Segurança
        sistemas = equipamentos_visiveis(SistemaDeSeguranca.objects.all(), user).filter(pesquisa__id=pesquisa_id,
                                                     is_active=True)
        sistemas_serialized = [
            {"tipo": "SistemaDeSeguranca", "dados": SistemaDeSegurancaSerializer(sistema).data}
            for sistema in sistemas
        ]
        # alimentos e bebidas
        alimentos = equipamentos_visiveis(AlimentosEBebidas.objects.all(), user).filter(pesquisa__id=pesquisa_id, is_active=True)
        alimentos_serialized = [
            {"tipo": "AlimentosEBebidas", "dados": AlimentosEBebidasSerializer(alimento).data}
            for alimento in alimentos
        ]
        # meios de hospedagem
        hospedagens =  equipamentos_visiveis(MeioDeHospedagem.objects.all(), user).filter(pesquisa__id=pesquisa_id, is_active=True)
        hospedagens_serialized = [
            {"tipo": "Meios de Hospedagem", "dados": MeioDeHospedagemSerializer(hospedagem).data}
            for hospedagem in hospedagens
        ]        

        #info basicas do municipio
 
        infosBasicas = equipamentos_visiveis(InformacaoBasicaDoMunicipio.objects.all(), user).filter(pesquisa__id=pesquisa_id,
                                                                  is_active=True)
        infosBasicas_serialized = [
            {"tipo": "Informações Básicas do Município", "dados": InformacoesBasicasSerializer(infoBasica).data}
            for infoBasica in infosBasicas
        ]
        
        comercioTuristicos = equipamentos_visiveis(ComercioTuristico.objects.all(), user).filter(pesquisa__id=pesquisa_id, 
                                                              is_active=True)
        comercioTuristicos_serialized = [
            {"tipo": "Comércio Turístico", "dados": ComercioTuristicoSerializer(comercioTuristico).data}
            for comercioTuristico in comercioTuristicos
        ]

        locadoraImoveis = equipamentos_visiveis(LocadorasDeImoveis.objects.all(), user).filter(pesquisa__id=pesquisa_id, is_active=True)
        locadoraImoveis_serialized = [
            {"tipo": "Locadora de Imóveis", "dados": LocadorasDeImoveisSerializer(locadoraImovel).data}
            for locadoraImovel in locadoraImoveis
        ]

        outrosMeios = equipamentos_visiveis(OutrosMeiosDeHospedagem.objects.all(), user).filter(pesquisa__id=pesquisa_id, is_active=True)
        outrosMeios_serialized = [
            {"tipo": "Outros Tipos de Acomodação", "dados": OutrosMeiosDeHospedagemSerializer(outroMeioHospedagem).data}
            for outroMeioHospedagem in outrosMeios
        ]

        agenciasTurismo = equipamentos_visiveis(AgenciaDeTurismo.objects.all(), user).filter(pesquisa__id=pesquisa_id, is_active=True)
        agenciasTurismo_serialized = [
            {"tipo": "Agência de Turismo", "dados": AgenciaDeTurismoSerializer(agenciaDeTurismo).data}
            for agenciaDeTurismo in agenciasTurismo
        ]
        
        transportesTuristicos = equipamentos_visiveis(TransporteTuristico.objects.all(), user).filter(pesquisa__id=pesquisa_id, is_active=True)
        transportesTuristicos_serialized = [
            {"tipo": "Transporte Turistico", "dados": TransporteTuristicoSerializer(transporteTuristico).data}
            for transporteTuristico in transportesTuristicos
        ]
        
        espacosParaEventos = equipamentos_visiveis(EspacoParaEventos.objects.all(), user).filter(pesquisa__id=pesquisa_id, is_active=True)
        espacosParaEventos_serialized = [
            {"tipo": "Espaço para Eventos", "dados": EspacoParaEventosSerializer(espacoParaEvento).data}
            for espacoParaEvento in espacosParaEventos
        ]
        
        servicosParaEventos = equipamentos_visiveis(ServicosParaEventos.objects.all(), user).filter(pesquisa__id=pesquisa_id, is_active=True)
        servicosParaEventos__serialized = [
            {"tipo": "Serviços para Eventos", "dados": ServicosParaEventosSerializer(servicoParaEvento).data}
            for servicoParaEvento in servicosParaEventos
        ]
        
        parques = equipamentos_visiveis(Parques.objects.all(), user).filter(pesquisa__id=pesquisa_id,is_active=True)
        parques__serialized = [
            {"tipo": "Parques", "dados": ParquesSerializer(parque).data}
            for parque in parques
        ]
        
        espacosParaDiversao = equipamentos_visiveis(EspacosDeDiversaoECultura.objects.all(), user).filter(pesquisa__id=pesquisa_id, is_active=True)
        espacosParaDiversao__serialized = [
            {"tipo": "Espaços Para Diversão e Cultura", "dados": EspacosDeDiversaoECulturaSerializer(espacoParaDiversao).data}
            for espacoParaDiversao in espacosParaDiversao
        ]
        
        informacoesTuristicas = equipamentos_visiveis(InformacoesTuristicas.objects.all(), user).filter(pesquisa__id=pesquisa_id, is_active=True)
        informacoesTuristicas__serialized = [
            {"tipo": "Informações Turisticas", "dados": InformacoesTuristicasSerializer(informacaoTuristica).data}
            for informacaoTuristica in informacoesTuristicas
        ]
        
        entidadesAssociativas = equipamentos_visiveis(EntidadesAssociativas.objects.all(), user).filter(pesquisa__id=pesquisa_id, is_active=True)
        entidadesAssociativas__serialized = [
            {"tipo": "Entidades Associativas e Similares", "dados": EntidadesAssociativasSerializer(entidadeAssociativa).data}
            for entidadeAssociativa in entidadesAssociativas
        ]
        
        guiamentosTuristicos = equipamentos_visiveis(GuiamentoEConducaoTuristica.objects.all(), user).filter(pesquisa__id=pesquisa_id, is_active=True)
        guiamentosTuristicos_serialized = [
            {"tipo": "Guiamento e Condução Turística", "dados": GuiamentoEConducaoTuristicaSerializer(locadoraImovel).data}
            for locadoraImovel in guiamentosTuristicos
        ]
        
        intalacoesEsportivas = equipamentos_visiveis(InstalacoesEsportivas.objects.all(), user).filter(pesquisa__id=pesquisa_id, is_active=True)
        instalacoesEsportivas_serialized = [
            {"tipo": "Instalações Esportivas", "dados": InstalacoesEsportivasSerializer(instalacaoEsportiva).data}
            for instalacaoEsportiva in intalacoesEsportivas
        ]
        
        unidadesConservacao = equipamentos_visiveis(UnidadesDeConservacao.objects.all(), user).filter(pesquisa__id=pesquisa_id, is_active=True)
        unidadesConservacao_serialized = [
            {"tipo": "Unidades De Conservação", "dados": UnidadesDeConservacaoSerializer(unidadeConservacao).data}
            for unidadeConservacao in unidadesConservacao
        ]
        
        eventosProgramadoss = equipamentos_visiveis(EventosProgramados.objects.all(), user).filter(pesquisa__id=pesquisa_id, is_active=True)
        eventosProgramadoss_serialized = [
            {"tipo": "Eventos Programados", "dados": EventosProgramadosSerializer(eventoProgramado).data}
            for eventoProgramado in eventosProgramadoss
        ]
        
        gastronomiaArtesanatos = equipamentos_visiveis(GastronomiaArtesanato.objects.all(), user).filter(pesquisa__id=pesquisa_id,is_active=True)
        gastronomiaArtesanatos_serialized = [
            {"tipo": "Gastronomia e Artesanatos", "dados": GastronomiaArtesanatoSerializer(gastronomiaArtesanato).data}
            for gastronomiaArtesanato in gastronomiaArtesanatos
        ]
        # Combina os dados
        equipamentos = (
            rodovias_serialized +
            sistemas_serialized +
            alimentos_serialized +
            hospedagens_serialized +
            infosBasicas_serialized +
            comercioTuristicos_serialized +
            locadoraImoveis_serialized +
            outrosMeios_serialized +
            agenciasTurismo_serialized +
            transportesTuristicos_serialized +
            espacosParaEventos_serialized +
            servicosParaEventos__serialized +
            parques__serialized +
            espacosParaDiversao__serialized +
            informacoesTuristicas__serialized +
            entidadesAssociativas__serialized +
            guiamentosTuristicos_serialized +
            instalacoesEsportivas_serialized +
            unidadesConservacao_serialized +
            eventosProgramadoss_serialized +
            gastronomiaArtesanatos_serialized
            )

        return Response(equipamentos)