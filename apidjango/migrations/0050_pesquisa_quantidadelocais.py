# Generated by Django 5.1.1 on 2025-01-17 03:23

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('apidjango', '0049_remove_pesquisa_quantidadelocais'),
    ]

    operations = [
        migrations.AddField(
            model_name='pesquisa',
            name='quantidadeLocais',
            field=models.IntegerField(default=10),
        ),
    ]
