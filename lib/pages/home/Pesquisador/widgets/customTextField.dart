import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CustomTimeField extends StatefulWidget {
  final String label;
  final String? hint;
  final String? initialTime;
  final bool required;
  final ValueChanged<String>? onChanged;
  TextEditingController? controller2;

  CustomTimeField({
    super.key,
    required this.label,
    this.controller2,
    this.hint,
    this.initialTime,
    this.required = false,
    this.onChanged, required this.getValue,
  });
  final Function(String) getValue;

  @override
  State<CustomTimeField> createState() => _CustomTimeFieldState();
}

class _CustomTimeFieldState extends State<CustomTimeField> {
  late TextEditingController _controller;
  final _timeRegex = RegExp(r'^([0-1]?[0-9]|2[0-3]):[0-5][0-9]$');

  @override
  void initState() {
    super.initState();
   _controller = widget.controller2 ?? TextEditingController(text: widget.initialTime);
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );

    if (picked != null) {
      final formattedTime =
          '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
      _controller.text = formattedTime;
      widget.onChanged?.call(formattedTime);
      widget.getValue(formattedTime);
    }
  }



  @override
  Widget build(BuildContext context) {
    return Padding(
              padding: EdgeInsets.only(
          left: 25.w,
          right: 25.w,
          top: 25.w,
        ),

      child: TextFormField(
        
        controller: _controller,
        decoration: InputDecoration(
                      border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              isDense: true,
              hintStyle: const TextStyle(color: Colors.grey),
              //errorBorder: UnderlineInputBorder()
              fillColor: Colors.white,
              filled: true,
          labelText: widget.label,
          hintText: widget.hint ?? 'HH:mm',
        ),
        keyboardType: TextInputType.datetime,
        inputFormatters: [
          LengthLimitingTextInputFormatter(5),
          FilteringTextInputFormatter.allow(RegExp(r'[0-9:]')),
          _TimeInputFormatter(),
        ],
        onChanged: (newValue){
          setState(() {
                      widget.getValue(newValue);

          });
        },
        onTap: _selectTime,
      ),
    );
  }
}

class _TimeInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    final buffer = StringBuffer();

    for (int i = 0; i < text.length; i++) {
      if (i == 2) buffer.write(':');
      if (i >= 4) break;
      buffer.write(text[i]);
    }

    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String name;
  final String? Function(String?) validat;
  final TextEditingController? controller;
  const CustomTextField(
      {super.key,
      required this.name,
      required this.validat,
      required this.getValue,
      this.getChanged,
      this.controller});
  final Function(String) getValue;
  
  final Function(String)? getChanged;
  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.sizeOf(context);
    return Padding(
        padding: EdgeInsets.only(
          left: 25.w,
          right: 25.w,
          top: sizeScreen.height * 0.023,
        ),

        //height: sizeScreen.height * 0.07,
        // child: Padding(
        //   padding: EdgeInsets.only(
        //     left: sizeScreen.width * 0.02, right: sizeScreen.width * 0.02, top: sizeScreen.height * 0.01),
        child: TextFormField(
          controller: controller,
          style:
              const TextStyle(color: Colors.black), //String? Function(String?)
          onSaved: (newValue) {
            getValue(newValue!);
          },
          // onChanged: (newValue){
          //   getChanged!(newValue);
          // },
          validator: validat,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            isDense: true,
            hintText: name,
            hintStyle: const TextStyle(color: Colors.grey),
            //errorBorder: UnderlineInputBorder()
            fillColor: Colors.white,
            filled: true,
          ),
        ));
  }
}

class CustomTextNumber extends StatelessWidget {
    final TextEditingController? controller;

  const CustomTextNumber(
      {super.key, required this.getValue, required this.labelText, this.controller});
  final Function(String) getValue;
  final String labelText;
  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.sizeOf(context);

    return Padding(
        padding: EdgeInsets.only(
          left: sizeScreen.width * 0.02,
          right: sizeScreen.width * 0.02,
          top: sizeScreen.height * 0.023,
        ),

        // child: Padding(
        //   padding: EdgeInsets.only(
        //     left: sizeScreen.width * 0.02, right: sizeScreen.width * 0.02, top: sizeScreen.height * 0.01),
        child: TextFormField(
          controller: controller,
          inputFormatters: [
            FilteringTextInputFormatter.deny(RegExp('[a-zA-Z]')),
            MaskTextInputFormatter(mask: '(##) # ####-####')
          ],
          // validator: (value) {
          //   if(value == null || value.isEmpty ){
          //     return 'Por favor, insira uma data';
          //   }
          //   try{
          //     DateTime.parse(value);
          //   }catch(e){
          //     return 'Insira uma data válida\n no formado DD/MM/AAAA';
          //   }
          //   return null;

          // },
          onSaved: (newValue) {
            getValue(newValue!);
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            hintText: labelText,
            fillColor: Colors.white,
            filled: true,
            hintStyle: const TextStyle(color: Colors.grey),
            contentPadding: EdgeInsets.only(
                top: sizeScreen.height * 0.03, left: sizeScreen.width * 0.05),
          ),
        ));
  }
}

class CustomTextDate extends StatelessWidget {
  final TextEditingController? dateController;
  CustomTextDate({super.key, required this.getValue, this.dateController});

  final Function(String) getValue;
  final dateFormat = DateFormat('yyyy-MM-dd'); // formato para enviar ao backend
  final inputFormat = DateFormat('dd/MM/yyyy'); // formato de entrada do usuário

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.sizeOf(context);

    return Padding(
      padding: EdgeInsets.only(
        left: sizeScreen.width * 0.02,
        right: sizeScreen.width * 0.02,
        top: sizeScreen.height * 0.023,
      ),
      child: TextFormField(
        controller: dateController,
        inputFormatters: [
          FilteringTextInputFormatter.deny(RegExp('[a-zA-Z]')),
          MaskTextInputFormatter(mask: '##/##/####'),
        ],
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, insira uma data';
          }
          try {
            inputFormat
                .parseStrict(value); // verificar se o formato está correto
          } catch (e) {
            return 'Insira uma data válida no formato DD/MM/AAAA';
          }
          return null;
        },
        onSaved: (newValue) {
          if (newValue != null && newValue.isNotEmpty) {
            // Convertendo para o formato 'yyyy-MM-dd' antes de enviar ao servidor
            final parsedDate = inputFormat.parse(newValue);
            final formattedDate = dateFormat.format(parsedDate);
            getValue(formattedDate); // Enviando a data convertida
          }
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: '__/__/____',
          fillColor: Colors.white,
          filled: true,
          hintStyle: const TextStyle(color: Colors.grey),
          contentPadding: EdgeInsets.only(
            top: sizeScreen.height * 0.03,
            left: sizeScreen.width * 0.05,
          ),
        ),
      ),
    );
  }
}
