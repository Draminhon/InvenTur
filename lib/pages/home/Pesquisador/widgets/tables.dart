import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventur/utils/app_constants.dart';

class Tables extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  Tables({super.key});
  TextEditingController _nomeController = new TextEditingController();
  TextEditingController _enderecoController = new TextEditingController();
  TextEditingController _whatsappController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();

  Map<String, String> getData() {
    return{
      "nome": _nomeController.text,
      "endereco": _enderecoController.text,
      "whatsapp": _whatsappController.text,
      "email": _emailController.text
    };
  }
  
    fillForm(String nome, String endereco, String whatsapp, String email){
    _nomeController.text = nome;
    _enderecoController.text = endereco;
    _whatsappController.text = whatsapp;
    _emailController.text = email;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(children: [
          Container(
            height: 190.w,
            margin: EdgeInsets.only(left: 30.w, right: 30.h, top: 50.h),
            child: TextFormField(
              controller: _nomeController,
              style: const TextStyle(
                  color: Colors.black), //String? Function(String?)

              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
            
                isDense: true,
                hintText: 'Nome',
                hintStyle: const TextStyle(color: Colors.grey),
                contentPadding: EdgeInsets.only(top: 150.h, left: 50.h),
                //errorBorder: UnderlineInputBorder()
                fillColor: Colors.white,
                filled: true,
              ),
            ),
          ),
          Row(
            children: [
              Container(
                  margin: EdgeInsets.only(left: 30.w, top: 45.h),
                  width: 168.w,
                  child: Image.asset('./assets/images/Rectangle.png')),
                  Column(children: [Container(
            height: 190.w,
            width: 1080.w,
            margin: EdgeInsets.only(left: 30.w, right: 30.h, top: 50.h),
            child: TextFormField(
              controller: _enderecoController,
              style: const TextStyle(
                  color: Colors.black), //String? Function(String?)

              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                isDense: true,
                hintText: 'Endereço',
                hintStyle: const TextStyle(color: Colors.grey),
                contentPadding: EdgeInsets.only(top: 150.h, left: 50.h),
                //errorBorder: UnderlineInputBorder()
                fillColor: Colors.white,
                filled: true,
              ),
            ),
          ),
          Container(
            height: 190.w,
            width: 1080.w,
            margin: EdgeInsets.only(left: 30.w, right: 30.h, top: 50.h),
            child: TextFormField(
              controller: _whatsappController,
              style: const TextStyle(
                  color: Colors.black), //String? Function(String?)

              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                isDense: true,
                hintText: 'Whatsapp',
                hintStyle: const TextStyle(color: Colors.grey),
                contentPadding: EdgeInsets.only(top: 150.h, left: 50.h),
                //errorBorder: UnderlineInputBorder()
                fillColor: Colors.white,
                filled: true,
              ),
            ),
          ),
          Container(
            height: 190.w,
            width: 1080.w,
            margin: EdgeInsets.only(left: 30.w, right: 30.h, top: 50.h),
            child: TextFormField(
              controller: _emailController,
              style: const TextStyle(
                  color: Colors.black), //String? Function(String?)

              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                isDense: true,
                hintText: 'Email',
                hintStyle: const TextStyle(color: Colors.grey),
                contentPadding: EdgeInsets.only(top: 150.h, left: 50.h),
                //errorBorder: UnderlineInputBorder()
                fillColor: Colors.white,
                filled: true,
              ),
            ),
          )],)
            ],
          ),
          SizedBox(height: 130.w,),
        ]));
  }
}

class Tables2 extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  
  Map<String, String> getData() {
    return{
      "email": _emailController.text,
      "servicos_especializados": _servicosEspecializadosController.text,
      "outras_informacoes": _outrasInformacoesController.text,
    };
  }

    
    fillForm(String email, String servicos, String outrasInfos,){
    _emailController.text = email;
    _servicosEspecializadosController.text = servicos;
    _outrasInformacoesController.text = outrasInfos;
  }


  Tables2({super.key});
   TextEditingController _emailController = TextEditingController();
   TextEditingController _servicosEspecializadosController = TextEditingController();
   TextEditingController _outrasInformacoesController= TextEditingController();
  @override
    Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(children: [
          Container(
            height: 190.w,
            margin: EdgeInsets.only(left: 30.w, right: 30.h, top: 50.h),
            child: TextFormField(
              controller: _emailController,
              style: const TextStyle(
                  color: Colors.black), //String? Function(String?)

              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                isDense: true,
                hintText: 'Email',
                hintStyle: const TextStyle(color: Colors.grey),
                contentPadding: EdgeInsets.only(top: 150.h, left: 50.h),
                //errorBorder: UnderlineInputBorder()
                fillColor: Colors.white,
                filled: true,
              ),
            ),
          ),
          Row(
            children: [
              Container(
                  margin: EdgeInsets.only(left: 30.w, top: 45.h),
                  width: 150.w,
                  height: 500.w,
                  child: Image.asset('./assets/images/Rectangle.png')),
                  Column(children: [Container(
            height: 190.w,
            width: 1080.w,
            margin: EdgeInsets.only(left: 30.w, right: 30.h, top: 50.h),
            child: TextFormField(
              controller: _servicosEspecializadosController,
              style: const TextStyle(
                  color: Colors.black), //String? Function(String?)

              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                isDense: true,
                hintText: 'Serviços especializados',
                hintStyle: const TextStyle(color: Colors.grey),
                contentPadding: EdgeInsets.only(top: 150.h, left: 50.h),
                //errorBorder: UnderlineInputBorder()
                fillColor: Colors.white,
                filled: true,
              ),
            ),
          ),
          Container(
            height: 190.w,
            width: 1080.w,
            margin: EdgeInsets.only(left: 30.w, right: 30.h, top: 50.h),
            child: TextFormField(
              controller: _outrasInformacoesController,
              style: const TextStyle(
                  color: Colors.black), //String? Function(String?)

              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                isDense: true,
                hintText: 'Outras informações',
                hintStyle: const TextStyle(color: Colors.grey),
                contentPadding: EdgeInsets.only(top: 150.h, left: 50.h),
                //errorBorder: UnderlineInputBorder()
                fillColor: Colors.white,
                filled: true,
              ),
            ),
          ),
       ],)
            ],
          ),
          SizedBox(height: 130.w,),
        ]));
  }
}
