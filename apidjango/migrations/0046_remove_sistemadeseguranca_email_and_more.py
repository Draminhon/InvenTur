# Generated by Django 5.1.1 on 2025-01-16 00:08

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('apidjango', '0045_alter_sistemadeseguranca_email_and_more'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='sistemadeseguranca',
            name='email',
        ),
        migrations.RemoveField(
            model_name='sistemadeseguranca',
            name='endereco',
        ),
        migrations.RemoveField(
            model_name='sistemadeseguranca',
            name='whatsapp',
        ),
        migrations.AlterField(
            model_name='sistemadeseguranca',
            name='nome',
            field=models.CharField(blank=True, max_length=255, null=True),
        ),
    ]
