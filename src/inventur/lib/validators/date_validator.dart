import 'package:flutter/material.dart';

class DateValidator {
  String? validate({String? date}) {
    if (date == null || date.trim().isEmpty) return 'A data deve ser informada';
    
    try {
      final dataListDmY = date.split('/');
      
      final year = int.parse(dataListDmY[2]);
      final month = int.parse(dataListDmY[1]);
      final day = int.parse(dataListDmY[0]);

      if (month >= 1 && month <= 12) {
        final daysInMonth = DateUtils.getDaysInMonth(year, month);
        if (day >= 1 && day <= daysInMonth) return null;
      }
      throw Exception();

    } catch (e) {
      return 'A data é inválida';
    }
  }
}