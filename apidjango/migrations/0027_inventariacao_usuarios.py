# Generated by Django 5.1.1 on 2024-11-26 17:40

import django.db.models.deletion
from django.conf import settings
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('apidjango', '0026_inventariacao_equipamento'),
    ]

    operations = [
        migrations.AddField(
            model_name='inventariacao',
            name='usuarios',
            field=models.ForeignKey(default=1, on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL),
            preserve_default=False,
        ),
    ]
