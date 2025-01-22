import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CustomTextField extends StatelessWidget {
  final String name;
  final String? Function(String?) validat;
  final TextEditingController? controller;
  const CustomTextField(
      {super.key,
      required this.name,
      required this.validat,
      required this.getValue,
      this.controller
      });
  final Function(String) getValue;
  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.sizeOf(context);
    return Padding(
        padding: EdgeInsets.only(
          left: sizeScreen.width * 0.02,
          right: sizeScreen.width * 0.025,
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
          validator: validat,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            isDense: true,
            hintText: name,
            hintStyle: const TextStyle(color: Colors.grey),
            contentPadding: EdgeInsets.only(
                top: sizeScreen.height * 0.03, left: sizeScreen.width * 0.05),
            //errorBorder: UnderlineInputBorder()
            fillColor: Colors.white,
            filled: true,
          ),
        ));
  }
}

class CustomTextNumber extends StatelessWidget {
  const CustomTextNumber(
      {super.key, required this.getValue, required this.labelText});
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
  final dateFormat = DateFormat('yyyy-MM-dd');  // formato para enviar ao backend
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
            inputFormat.parseStrict(value); // verificar se o formato está correto
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