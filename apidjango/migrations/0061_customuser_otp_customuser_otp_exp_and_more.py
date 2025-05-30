# Generated by Django 5.1.5 on 2025-05-22 14:09

import django.core.validators
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('apidjango', '0060_customuser_telefone'),
    ]

    operations = [
        migrations.AddField(
            model_name='customuser',
            name='otp',
            field=models.CharField(blank=True, max_length=6, null=True),
        ),
        migrations.AddField(
            model_name='customuser',
            name='otp_exp',
            field=models.DateTimeField(blank=True, null=True),
        ),
        migrations.AddField(
            model_name='customuser',
            name='otp_verified',
            field=models.BooleanField(default=False),
        ),
        migrations.AlterField(
            model_name='customuser',
            name='username',
            field=models.CharField(max_length=150, validators=[django.core.validators.RegexValidator(message='O nome de usuário pode conter letras, números e espaços.', regex='^[\\w\\sáéíóúãõâêîôûçÁÉÍÓÚÃÕÂÊÎÔÛÇ]+$')]),
        ),
    ]
