from rest_framework import  permissions, viewsets, status, views
from rest_framework.permissions import IsAuthenticated
from rest_framework_simplejwt.authentication import JWTAuthentication
from ..serializers import *
from ..models import *
from django.http import HttpResponse, JsonResponse
from rest_framework.views import APIView
from rest_framework.response import Response

class RodoviaViewSet(viewsets.ModelViewSet):

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

class SistemaDeSegurancaViewSet(viewsets.ModelViewSet):

    queryset = SistemaDeSeguranca.objects.filter(is_active=True)
    serializer_class = SistemaDeSegurancaSerializer

    authentication_classes = [JWTAuthentication]
    permission_classes = [IsAuthenticated]
    def perform_create(self, serializer):
        serializer.save(usuario_criador=self.request.user)
    def partial_update(self, request, *args, **kwargs):
        kwargs['partial'] = True
        return super().update(request, *args, **kwargs)
    
class LocadoraDeImoveisViewSet(viewsets.ModelViewSet):

    queryset = LocadorasDeImoveis.objects.filter(is_active=True)
    serializer_class = LocadorasDeImoveisSerializer

    authentication_classes = [JWTAuthentication]
    permission_classes = [IsAuthenticated]
    def perform_create(self, serializer):
        serializer.save(usuario_criador=self.request.user)
    def partial_update(self, request, *args, **kwargs):
        kwargs['partial'] = True
        return super().update(request, *args, **kwargs)

class GuiamentoEConducaoTuristicaViewSet(viewsets.ModelViewSet):

    queryset = GuiamentoEConducaoTuristica.objects.filter(is_active=True)
    serializer_class = GuiamentoEConducaoTuristicaSerializer

    authentication_classes = [JWTAuthentication]
    permission_classes = [IsAuthenticated]
    def perform_create(self, serializer):
        serializer.save(usuario_criador=self.request.user)
    def partial_update(self, request, *args, **kwargs):
        kwargs['partial'] = True
        return super().update(request, *args, **kwargs)
    
class AlimentosEBebidasViewSet(viewsets.ModelViewSet):

    queryset = AlimentosEBebidas.objects.filter(is_active=True)
    serializer_class = AlimentosEBebidasSerializer

    authentication_classes = [JWTAuthentication]
    permission_classes = [IsAuthenticated]
    def perform_create(self, serializer):
        serializer.save(usuario_criador=self.request.user)
    def partial_update(self, request, *args, **kwargs):
        kwargs['partial'] = True
        return super().update(request, *args, **kwargs)

class MeioDeHospedagemViewSet(viewsets.ModelViewSet):

    queryset = MeioDeHospedagem.objects.filter(is_active=True)
    serializer_class = MeioDeHospedagemSerializer

    authentication_classes = [JWTAuthentication]
    permission_classes = [IsAuthenticated]
    def perform_create(self, serializer):
        serializer.save(usuario_criador=self.request.user)
    def partial_update(self, request, *args, **kwargs):
        kwargs['partial'] = True
        return super().update(request, *args, **kwargs)


class InformacoesBasicasViewSet(viewsets.ModelViewSet):

    queryset = InformacaoBasicaDoMunicipio.objects.filter(is_active=True)
    serializer_class = InformacoesBasicasSerializer

    authentication_classes = [JWTAuthentication]
    permission_classes = [IsAuthenticated]
    def perform_create(self, serializer):
        serializer.save(usuario_criador=self.request.user)

class ComercioTuristicoViewSet(viewsets.ModelViewSet):
    queryset = ComercioTuristico.objects.filter(is_active=True)
    serializer_class = ComercioTuristicoSerializer

    authentication_classes = [JWTAuthentication]
    permission_classes = [IsAuthenticated]
    def perform_create(self, serializer):
        serializer.save(usuario_criador=self.request.user)
class OutromeiodehospedagemViewSet(viewsets.ModelViewSet):
    queryset = OutrosMeiosDeHospedagem.objects.filter(is_active=True)
    serializer_class = OutrosMeiosDeHospedagemSerializer

    authentication_classes = [JWTAuthentication]
    permission_classes = [IsAuthenticated]
    def perform_create(self, serializer):
        serializer.save(usuario_criador=self.request.user)
class AgenciaDeTurismoViewSet(viewsets.ModelViewSet):
    queryset = AgenciaDeTurismo.objects.filter(is_active=True)
    serializer_class = AgenciaDeTurismoSerializer

    authentication_classes = [JWTAuthentication]
    permission_classes = [IsAuthenticated]
    def perform_create(self, serializer):
        serializer.save(usuario_criador=self.request.user)
class TransporteTuristicoViewSet(viewsets.ModelViewSet):
    queryset = TransporteTuristico.objects.filter(is_active=True)
    serializer_class = TransporteTuristicoSerializer
    
    authentication_classes = [JWTAuthentication]
    permission_classes = [IsAuthenticated]
    def perform_create(self, serializer):
        serializer.save(usuario_criador=self.request.user)
class EspacoParaEventosViewSet(viewsets.ModelViewSet):
    queryset = EspacoParaEventos.objects.filter(is_active=True)
    serializer_class = EspacoParaEventosSerializer
    
    authentication_classes = [JWTAuthentication]
    permission_classes = [IsAuthenticated]
    def perform_create(self, serializer):
        serializer.save(usuario_criador=self.request.user)   
class ServicosParaEventosViewSet(viewsets.ModelViewSet):
    queryset = ServicosParaEventos.objects.filter(is_active=True)
    serializer_class = ServicosParaEventosSerializer
    
    authentication_classes = [JWTAuthentication]
    permission_classes = [IsAuthenticated]   
    def perform_create(self, serializer):
        serializer.save(usuario_criador=self.request.user)
class ParquesViewSet(viewsets.ModelViewSet):
    queryset = Parques.objects.filter(is_active=True)
    serializer_class = ParquesSerializer
    
    authentication_classes = [JWTAuthentication]
    permission_classes = [IsAuthenticated]
    def perform_create(self, serializer):
        serializer.save(usuario_criador=self.request.user)
class EspacosDeDiversaoECulturaViewSet(viewsets.ModelViewSet):
    queryset = EspacosDeDiversaoECultura.objects.filter(is_active=True)
    serializer_class = EspacosDeDiversaoECulturaSerializer
    
    authentication_classes = [JWTAuthentication]
    permission_classes = [IsAuthenticated]
    def perform_create(self, serializer):
        serializer.save(usuario_criador=self.request.user)
class InformacoesTuristicasViewSet(viewsets.ModelViewSet):
    queryset = InformacoesTuristicas.objects.filter(is_active=True)
    serializer_class = InformacoesTuristicasSerializer
    
    authentication_classes = [JWTAuthentication]
    permission_classes = [IsAuthenticated]
    def perform_create(self, serializer):
        serializer.save(usuario_criador=self.request.user)
class EntidadesAssociativasViewSet(viewsets.ModelViewSet):
    queryset = EntidadesAssociativas.objects.filter(is_active=True)
    serializer_class = EntidadesAssociativasSerializer

    authentication_classes = [JWTAuthentication]
    permission_classes = [IsAuthenticated]
    def perform_create(self, serializer):
        serializer.save(usuario_criador=self.request.user)   
class InstalacoesEsportivasViewSet(viewsets.ModelViewSet):
    queryset = InstalacoesEsportivas.objects.filter(is_active=True)
    serializer_class = InstalacoesEsportivasSerializer

    authentication_classes = [JWTAuthentication]
    permission_classes = [IsAuthenticated]
    def perform_create(self, serializer):
        serializer.save(usuario_criador=self.request.user)
class UnidadesDeConservacaoViewSet(viewsets.ModelViewSet):
    queryset = UnidadesDeConservacao.objects.filter(is_active=True)
    serializer_class = UnidadesDeConservacaoSerializer

    authentication_classes = [JWTAuthentication]
    permission_classes = [IsAuthenticated]
    def perform_create(self, serializer):
        serializer.save(usuario_criador=self.request.user)    
class EventosProgramadosViewSet(viewsets.ModelViewSet):
    queryset = EventosProgramados.objects.filter(is_active=True)
    serializer_class = EventosProgramadosSerializer

    authentication_classes = [JWTAuthentication]
    permission_classes = [IsAuthenticated]
    def perform_create(self, serializer):
        serializer.save(usuario_criador=self.request.user)    
class GastronomiaArtesanatoViewSet(viewsets.ModelViewSet):
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
            raise ValidationError({"detail": "O parâmetro 'pesquisa_id' é obrigatório."})

        filtros = {
            'pesquisa_id': pesquisa_id,
            'is_active': True
        }
        

        
        # Rodovias
        rodovias = Rodovia.objects.filter(**filtros)
        rodovias_serialized = [
            {"tipo": "Rodovia", "dados": RodoviaSerializer(rodovia).data}
            for rodovia in rodovias
        ]

        # Sistemas de Segurança
        sistemas = SistemaDeSeguranca.objects.filter(pesquisa__id=pesquisa_id,
                                                     is_active=True)
        sistemas_serialized = [
            {"tipo": "SistemaDeSeguranca", "dados": SistemaDeSegurancaSerializer(sistema).data}
            for sistema in sistemas
        ]
        # alimentos e bebidas
        alimentos = AlimentosEBebidas.objects.filter(pesquisa__id=pesquisa_id, is_active=True)
        alimentos_serialized = [
            {"tipo": "AlimentosEBebidas", "dados": AlimentosEBebidasSerializer(alimento).data}
            for alimento in alimentos
        ]
        # meios de hospedagem
        hospedagens =  MeioDeHospedagem.objects.filter(pesquisa__id=pesquisa_id, is_active=True)
        hospedagens_serialized = [
            {"tipo": "Meios de Hospedagem", "dados": MeioDeHospedagemSerializer(hospedagem).data}
            for hospedagem in hospedagens
        ]        

        #info basicas do municipio
 
        infosBasicas = InformacaoBasicaDoMunicipio.objects.filter(pesquisa__id=pesquisa_id,
                                                                  is_active=True)
        infosBasicas_serialized = [
            {"tipo": "Informações Básicas do Município", "dados": InformacoesBasicasSerializer(infoBasica).data}
            for infoBasica in infosBasicas
        ]
        
        comercioTuristicos = ComercioTuristico.objects.filter(pesquisa__id=pesquisa_id, 
                                                              is_active=True)
        comercioTuristicos_serialized = [
            {"tipo": "Comércio Turístico", "dados": ComercioTuristicoSerializer(comercioTuristico).data}
            for comercioTuristico in comercioTuristicos
        ]

        locadoraImoveis = LocadorasDeImoveis.objects.filter(pesquisa__id=pesquisa_id, is_active=True)
        locadoraImoveis_serialized = [
            {"tipo": "Locadora de Imóveis", "dados": LocadorasDeImoveisSerializer(locadoraImovel).data}
            for locadoraImovel in locadoraImoveis
        ]

        outrosMeios = OutrosMeiosDeHospedagem.objects.filter(pesquisa__id=pesquisa_id, is_active=True)
        outrosMeios_serialized = [
            {"tipo": "Outros Tipos de Acomodação", "dados": OutrosMeiosDeHospedagemSerializer(outroMeioHospedagem).data}
            for outroMeioHospedagem in outrosMeios
        ]

        agenciasTurismo = AgenciaDeTurismo.objects.filter(pesquisa__id=pesquisa_id, is_active=True)
        agenciasTurismo_serialized = [
            {"tipo": "Agência de Turismo", "dados": AgenciaDeTurismoSerializer(agenciaDeTurismo).data}
            for agenciaDeTurismo in agenciasTurismo
        ]
        
        transportesTuristicos = TransporteTuristico.objects.filter(pesquisa__id=pesquisa_id, is_active=True)
        transportesTuristicos_serialized = [
            {"tipo": "Transporte Turistico", "dados": TransporteTuristicoSerializer(transporteTuristico).data}
            for transporteTuristico in transportesTuristicos
        ]
        
        espacosParaEventos = EspacoParaEventos.objects.filter(pesquisa__id=pesquisa_id, is_active=True)
        espacosParaEventos_serialized = [
            {"tipo": "Espaço para Eventos", "dados": EspacoParaEventosSerializer(espacoParaEvento).data}
            for espacoParaEvento in espacosParaEventos
        ]
        
        servicosParaEventos = ServicosParaEventos.objects.filter(pesquisa__id=pesquisa_id, is_active=True)
        servicosParaEventos__serialized = [
            {"tipo": "Serviços para Eventos", "dados": ServicosParaEventosSerializer(servicoParaEvento).data}
            for servicoParaEvento in servicosParaEventos
        ]
        
        parques = Parques.objects.filter(pesquisa__id=pesquisa_id,is_active=True)
        parques__serialized = [
            {"tipo": "Parques", "dados": ParquesSerializer(parque).data}
            for parque in parques
        ]
        
        espacosParaDiversao = EspacosDeDiversaoECultura.objects.filter(pesquisa__id=pesquisa_id, is_active=True)
        espacosParaDiversao__serialized = [
            {"tipo": "Espaços Para Diversão e Cultura", "dados": EspacosDeDiversaoECulturaSerializer(espacoParaDiversao).data}
            for espacoParaDiversao in espacosParaDiversao
        ]
        
        informacoesTuristicas = InformacoesTuristicas.objects.filter(pesquisa__id=pesquisa_id, is_active=True)
        informacoesTuristicas__serialized = [
            {"tipo": "Informações Turisticas", "dados": InformacoesTuristicasSerializer(informacaoTuristica).data}
            for informacaoTuristica in informacoesTuristicas
        ]
        
        entidadesAssociativas = EntidadesAssociativas.objects.filter(pesquisa__id=pesquisa_id, is_active=True)
        entidadesAssociativas__serialized = [
            {"tipo": "Entidades Associativas e Similares", "dados": EntidadesAssociativasSerializer(entidadeAssociativa).data}
            for entidadeAssociativa in entidadesAssociativas
        ]
        
        guiamentosTuristicos = GuiamentoEConducaoTuristica.objects.filter(pesquisa__id=pesquisa_id, is_active=True)
        guiamentosTuristicos_serialized = [
            {"tipo": "Guiamento e Condução Turística", "dados": GuiamentoEConducaoTuristicaSerializer(locadoraImovel).data}
            for locadoraImovel in guiamentosTuristicos
        ]
        
        intalacoesEsportivas = InstalacoesEsportivas.objects.filter(pesquisa__id=pesquisa_id, is_active=True)
        instalacoesEsportivas_serialized = [
            {"tipo": "Instalações Esportivas", "dados": InstalacoesEsportivasSerializer(instalacaoEsportiva).data}
            for instalacaoEsportiva in intalacoesEsportivas
        ]
        
        unidadesConservacao = UnidadesDeConservacao.objects.filter(pesquisa__id=pesquisa_id, is_active=True)
        unidadesConservacao_serialized = [
            {"tipo": "Unidades De Conservação", "dados": UnidadesDeConservacaoSerializer(unidadeConservacao).data}
            for unidadeConservacao in unidadesConservacao
        ]
        
        eventosProgramadoss = EventosProgramados.objects.filter(pesquisa__id=pesquisa_id, is_active=True)
        eventosProgramadoss_serialized = [
            {"tipo": "Eventos Programados", "dados": EventosProgramadosSerializer(eventoProgramado).data}
            for eventoProgramado in eventosProgramadoss
        ]
        
        gastronomiaArtesanatos = GastronomiaArtesanato.objects.filter(pesquisa__id=pesquisa_id,is_active=True)
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