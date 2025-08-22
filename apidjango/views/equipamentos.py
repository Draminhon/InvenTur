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

    def partial_update(self, request, *args, **kwargs):
        kwargs['partial'] = True
        return super().update(request, *args, **kwargs)

class SistemaDeSegurancaViewSet(viewsets.ModelViewSet):

    queryset = SistemaDeSeguranca.objects.filter(is_active=True)
    serializer_class = SistemaDeSegurancaSerializer

    authentication_classes = [JWTAuthentication]
    permission_classes = [IsAuthenticated]

    def partial_update(self, request, *args, **kwargs):
        kwargs['partial'] = True
        return super().update(request, *args, **kwargs)

class AlimentosEBebidasViewSet(viewsets.ModelViewSet):

    queryset = AlimentosEBebidas.objects.filter(is_active=True)
    serializer_class = AlimentosEBebidasSerializer

    authentication_classes = [JWTAuthentication]
    permission_classes = [IsAuthenticated]

    def partial_update(self, request, *args, **kwargs):
        kwargs['partial'] = True
        return super().update(request, *args, **kwargs)

class MeioDeHospedagemViewSet(viewsets.ModelViewSet):

    queryset = MeioDeHospedagem.objects.filter(is_active=True)
    serializer_class = MeioDeHospedagemSerializer

    authentication_classes = [JWTAuthentication]
    permission_classes = [IsAuthenticated]

    def partial_update(self, request, *args, **kwargs):
        kwargs['partial'] = True
        return super().update(request, *args, **kwargs)


class InformacoesBasicasViewSet(viewsets.ModelViewSet):

    queryset = InformacaoBasicaDoMunicipio.objects.filter(is_active=True)
    serializer_class = InformacoesBasicasSerializer

    authentication_classes = [JWTAuthentication]
    permission_classes = [IsAuthenticated]

class ComercioTuristicoViewSet(viewsets.ModelViewSet):
    queryset = ComercioTuristico.objects.filter(is_active=True)
    serializer_class = ComercioTuristicoSerializer

    authentication_classes = [JWTAuthentication]
    permission_classes = [IsAuthenticated]


class EquipamentosListView(APIView):
    def get(self, request, *args, **kwargs):
        pesquisa_id = request.query_params.get('pesquisa_id')

        if not pesquisa_id:
            raise ValidationError({"detail": "O parâmetro 'pesquisa_id' é obrigatório."})

        # Rodovias
        rodovias = Rodovia.objects.filter(pesquisa__id=pesquisa_id, is_active=True)
        rodovias_serialized = [
            {"tipo": "Rodovia", "dados": RodoviaSerializer(rodovia).data}
            for rodovia in rodovias
        ]

        # Sistemas de Segurança
        sistemas = SistemaDeSeguranca.objects.filter(pesquisa__id=pesquisa_id, is_active=True)
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

        infosBasicas = InformacaoBasicaDoMunicipio.objects.filter(pesquisa__id=pesquisa_id, is_active=True)
        infosBasicas_serialized = [
            {"tipo": "Informações Básicas do Município", "dados": InformacoesBasicasSerializer(infoBasica).data}
            for infoBasica in infosBasicas
        ]
        
        comercioTuristicos = ComercioTuristico.objects.filter(pesquisa__id=pesquisa_id, is_active=True)
        comercioTuristicos_serialized = [
            {"tipo": "Comércio Turístico", "dados": ComercioTuristicoSerializer(comercioTuristico).data}
            for comercioTuristico in comercioTuristicos
        ]
        # Combina os dados
        equipamentos = rodovias_serialized + sistemas_serialized + alimentos_serialized + hospedagens_serialized + infosBasicas_serialized + comercioTuristicos_serialized

        return Response(equipamentos)