# Generated by Django 5.1.1 on 2024-12-04 17:01

import django.db.models.deletion
from django.conf import settings
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('apidjango', '0033_alter_customuser_pesquisas'),
    ]

    operations = [
        migrations.AddField(
            model_name='pesquisa',
            name='admin',
            field=models.ForeignKey(blank=True, help_text='Administrador que criou esta pesquisa', null=True, on_delete=django.db.models.deletion.SET_NULL, related_name='pesquisas_criadas', to=settings.AUTH_USER_MODEL),
        ),
    ]
