# Generated by Django 5.1.1 on 2024-11-26 17:26

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('apidjango', '0023_customuser_pesquisas_pesquisa_usuario'),
    ]

    operations = [
        migrations.AddField(
            model_name='base',
            name='pesquisa',
            field=models.ForeignKey(default=1, on_delete=django.db.models.deletion.CASCADE, to='apidjango.pesquisa'),
            preserve_default=False,
        ),
    ]
