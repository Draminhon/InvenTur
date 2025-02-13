# Generated by Django 5.1.1 on 2025-01-16 00:38

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('apidjango', '0046_remove_sistemadeseguranca_email_and_more'),
    ]

    operations = [
        migrations.CreateModel(
            name='ContatoInfo',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('nome', models.CharField(max_length=255)),
                ('endereco', models.CharField(max_length=255)),
                ('whatsapp', models.CharField(max_length=255)),
                ('email', models.CharField(max_length=255)),
                ('sistema_de_seguranca', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='apidjango.sistemadeseguranca')),
            ],
        ),
        migrations.CreateModel(
            name='ServicoEspecializadoInfo',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('email', models.CharField(max_length=255)),
                ('servicos_especializados', models.TextField()),
                ('outras_informacoes', models.TextField()),
                ('sistema_de_seguranca', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='apidjango.sistemadeseguranca')),
            ],
        ),
    ]
