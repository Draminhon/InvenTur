from ..models import *
from ..serializers import *
from django.http import HttpResponse, JsonResponse
import openpyxl
from datetime import date, datetime
from django.db.models import Model
import json

def process_value(value):
    # Se for callable, chama a função
    if callable(value):
        value = value()
    # Se for datetime com tzinfo, remove o tzinfo
    if isinstance(value, datetime):
        if value.tzinfo is not None:
            value = value.replace(tzinfo=None)
    # Se for uma instância de Model, converte para string
    if isinstance(value, Model):
        value = str(value)
    # Se for lista ou dict, converte para JSON
    elif isinstance(value, (list, dict)):
        value = json.dumps(value, ensure_ascii=False)
    return value

def export_pesquisa_to_excel(request, pesquisa_id):
    try:
        pesquisa = Pesquisa.objects.get(id=pesquisa_id)
    except Pesquisa.DoesNotExist:
        return HttpResponse("Pesquisa não encontrada", status=404)
    
    wb = openpyxl.Workbook()
    
    # ==============================
    # Aba para os dados da Pesquisa
    # ==============================
    dados_sheet_title = f"Dados {date.today().strftime('%d-%m-%Y')}"
    ws_pesquisa = wb.active
    ws_pesquisa.title = dados_sheet_title

    EXCLUDE_FIELDS = ['id', 'is_active', 'base_ptr', 'pesquisa']
    
    # Campos normais e ManyToMany para Pesquisa (exceto os indesejados)
    pesquisa_field_names = [field.name for field in pesquisa._meta.fields if field.name not in EXCLUDE_FIELDS]
    m2m_field_names = [field.name for field in pesquisa._meta.many_to_many if field.name not in EXCLUDE_FIELDS]
    pesquisa_field_names.extend(m2m_field_names)
    pesquisa_field_names.append("quantidadePesquisadores")
    
    ws_pesquisa.append(pesquisa_field_names)
    
    data_row = []
    for field in pesquisa._meta.fields:
        if field.name in EXCLUDE_FIELDS:
            continue
        value = getattr(pesquisa, field.name)
        data_row.append(process_value(value))
    
    for field_name in m2m_field_names:
        manager = getattr(pesquisa, field_name)
        value = ", ".join(str(obj) for obj in manager.all())
        data_row.append(value)
    
    computed_value = getattr(pesquisa, "quantidadePesquisadores")
    data_row.append(process_value(computed_value))
    
    ws_pesquisa.append(data_row)
    
    # ======================================
    # Abas para os formulários/equipamentos
    # ======================================
    sheets = []
    ab_queryset = AlimentosEBebidas.objects.filter(pesquisa=pesquisa,is_active=True)
    ss_queryset = SistemaDeSeguranca.objects.filter(pesquisa=pesquisa,is_active=True)
    rodovia_queryset = Rodovia.objects.filter(pesquisa=pesquisa,is_active=True)
    meiosHospedagem_queryset = MeioDeHospedagem.objects.filter(pesquisa=pesquisa,is_active=True)

    if ab_queryset.exists():
        sheets.append(("Alimentos e Bebidas", ab_queryset))
    if ss_queryset.exists():
        sheets.append(("Sistemas de Segurança", ss_queryset))
    if rodovia_queryset.exists():
        sheets.append(("Rodovia", rodovia_queryset))
    if meiosHospedagem_queryset.exists():
        sheets.append(("Meios de Hospedagem", meiosHospedagem_queryset))

    
    for sheet_title, queryset in sheets:
        ws = wb.create_sheet(title=sheet_title)
        model = queryset.model
        model_field_names = [field.name for field in model._meta.fields if field.name not in EXCLUDE_FIELDS]
        m2m_field_names = [field.name for field in model._meta.many_to_many if field.name not in EXCLUDE_FIELDS]
        all_field_names = model_field_names + m2m_field_names
        ws.append(all_field_names)
        
        for obj in queryset:
            row = []
            # Processa os campos normais
            for field in model._meta.fields:
                if field.name in EXCLUDE_FIELDS:
                    continue
                value = getattr(obj, field.name)
                row.append(process_value(value))
            # Processa os campos ManyToMany
            for field_name in m2m_field_names:
                manager = getattr(obj, field_name)
                if field_name in ["contatos", "servicos_especializados"]:
                    related_values = []
                    for related_obj in manager.all():
                        fields_dict = {
                            f.name: process_value(getattr(related_obj, f.name))
                            for f in related_obj._meta.fields if f.name not in EXCLUDE_FIELDS
                        }
                        related_values.append(fields_dict)
                    value = json.dumps(related_values, ensure_ascii=False)
                else:
                    value = ", ".join(str(related_obj) for related_obj in manager.all())
                row.append(value)
            ws.append(row)
    
    response = HttpResponse(
        content_type="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    )
    response["Content-Disposition"] = f'attachment; filename="pesquisa_{pesquisa.id}.xlsx"'
    wb.save(response)
    return response

