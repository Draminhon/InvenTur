import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/customOutro.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/customTextField.dart';
import 'package:inventur/utils/app_constants.dart';

class Tables extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  Tables({super.key});
  TextEditingController _nomeController = new TextEditingController();
  TextEditingController _enderecoController = new TextEditingController();
  TextEditingController _whatsappController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();

  Map<String, String> getData() {
    return {
      "nome": _nomeController.text,
      "endereco": _enderecoController.text,
      "whatsapp": _whatsappController.text,
      "email": _emailController.text
    };
  }

  fillForm(String nome, String endereco, String whatsapp, String email) {
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
              Column(
                children: [
                  Container(
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
                  )
                ],
              )
            ],
          ),
          SizedBox(
            height: 130.w,
          ),
        ]));
  }
}

class Tables2 extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  Map<String, String> getData() {
    return {
      "email": _emailController.text,
      "servicos_especializados": _servicosEspecializadosController.text,
      "outras_informacoes": _outrasInformacoesController.text,
    };
  }

  fillForm(
    String email,
    String servicos,
    String outrasInfos,
  ) {
    _emailController.text = email;
    _servicosEspecializadosController.text = servicos;
    _outrasInformacoesController.text = outrasInfos;
  }

  Tables2({super.key});
  TextEditingController _emailController = TextEditingController();
  TextEditingController _servicosEspecializadosController =
      TextEditingController();
  TextEditingController _outrasInformacoesController = TextEditingController();
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
              Column(
                children: [
                  Container(
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
                ],
              )
            ],
          ),
          SizedBox(
            height: 130.w,
          ),
        ]));
  }
}

class TabelaHorarios extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            Row(
              children: [
                textLabel(
                  name: 'segunda\nfeira:',
                  textAlign: TextAlign.start,
                ),
                Expanded(
                  child: CustomTextField(
                    name: 'abertura',
                    validat: (p0) {},
                    getValue: (p0) {},
                  ),
                ),
                Expanded(
                  child: CustomTextField(
                    name: 'encerramento',
                    validat: (p0) {},
                    getValue: (p0) {},
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                textLabel(
                  name: 'terça\nfeira:',
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  width: 95.w,
                ),
                Expanded(
                  child: CustomTextField(
                    name: 'abertura',
                    validat: (p0) {},
                    getValue: (p0) {},
                  ),
                ),
                Expanded(
                  child: CustomTextField(
                    name: 'encerramento',
                    validat: (p0) {},
                    getValue: (p0) {},
                  ),
                )
              ],
            ),
            Row(
              children: [
                textLabel(
                  name: 'quarta\nfeira:',
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  width: 50.w,
                ),
                Expanded(
                  child: CustomTextField(
                    name: 'abertura',
                    validat: (p0) {},
                    getValue: (p0) {},
                  ),
                ),
                Expanded(
                  child: CustomTextField(
                    name: 'encerramento',
                    validat: (p0) {},
                    getValue: (p0) {},
                  ),
                )
              ],
            ),
            Row(
              children: [
                textLabel(
                  name: 'quinta\nfeira:',
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  width: 60.w,
                ),
                Expanded(
                  child: CustomTextField(
                    name: 'abertura',
                    validat: (p0) {},
                    getValue: (p0) {},
                  ),
                ),
                Expanded(
                  child: CustomTextField(
                    name: 'encerramento',
                    validat: (p0) {},
                    getValue: (p0) {},
                  ),
                )
              ],
            ),
            Row(
              children: [
                textLabel(
                  name: 'sexta\nfeira:',
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  width: 95.w,
                ),
                Expanded(
                  child: CustomTextField(
                    name: 'abertura',
                    validat: (p0) {},
                    getValue: (p0) {},
                  ),
                ),
                Expanded(
                  child: CustomTextField(
                    name: 'encerramento',
                    validat: (p0) {},
                    getValue: (p0) {},
                  ),
                )
              ],
            ),
            Row(
              children: [
                textLabel(
                  name: 'sábado:',
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  width: 20.w,
                ),
                Expanded(
                  child: CustomTextField(
                    name: 'abertura',
                    validat: (p0) {},
                    getValue: (p0) {},
                  ),
                ),
                Expanded(
                  child: CustomTextField(
                    name: 'encerramento',
                    validat: (p0) {},
                    getValue: (p0) {},
                  ),
                )
              ],
            ),
            Row(
              children: [
                textLabel(
                  name: 'domingo:',
                  textAlign: TextAlign.start,
                ),
                Expanded(
                  child: CustomTextField(
                    name: 'abertura',
                    validat: (p0) {},
                    getValue: (p0) {},
                  ),
                ),
                Expanded(
                  child: CustomTextField(
                    name: 'encerramento',
                    validat: (p0) {},
                    getValue: (p0) {},
                  ),
                )
              ],
            )
          ],
        ));
  }
}

class TablesInstalacoes extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          textLabel(
            name: 'Auditório',
            fontWeight: FontWeight.bold,
          ),
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  name: 'quantidade',
                  validat: (p0) {},
                  getValue: (p0) {},
                ),
              ),
              Expanded(
                child: CustomTextField(
                  name: 'área total(m²)',
                  validat: (p0) {},
                  getValue: (p0) {},
                ),
              ),
              Expanded(
                child: CustomTextField(
                  name: 'capacidade nºpessoas',
                  validat: (p0) {},
                  getValue: (p0) {},
                ),
              )
            ],
          ),
          textLabel(
            name: 'Salas modulares',
            fontWeight: FontWeight.bold,
          ),
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  name: 'quantidade',
                  validat: (p0) {},
                  getValue: (p0) {},
                ),
              ),
              Expanded(
                child: CustomTextField(
                  name: 'área total(m²)',
                  validat: (p0) {},
                  getValue: (p0) {},
                ),
              ),
              Expanded(
                child: CustomTextField(
                  name: 'capacidade nºpessoas',
                  validat: (p0) {},
                  getValue: (p0) {},
                ),
              )
            ],
          ),
          textLabel(
            name: 'Pavilhão de Feiras',
            fontWeight: FontWeight.bold,
          ),
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  name: 'quantidade',
                  validat: (p0) {},
                  getValue: (p0) {},
                ),
              ),
              Expanded(
                child: CustomTextField(
                  name: 'área total(m²)',
                  validat: (p0) {},
                  getValue: (p0) {},
                ),
              ),
              Expanded(
                child: CustomTextField(
                  name: 'capacidade nºpessoas',
                  validat: (p0) {},
                  getValue: (p0) {},
                ),
              )
            ],
          ),
          textLabel(
            name: 'Área de exposição coberta',
            fontWeight: FontWeight.bold,
          ),
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  name: 'quantidade',
                  validat: (p0) {},
                  getValue: (p0) {},
                ),
              ),
              Expanded(
                child: CustomTextField(
                  name: 'área total(m²)',
                  validat: (p0) {},
                  getValue: (p0) {},
                ),
              ),
              Expanded(
                child: CustomTextField(
                  name: 'capacidade nºpessoas',
                  validat: (p0) {},
                  getValue: (p0) {},
                ),
              )
            ],
          ),
          textLabel(
            name: 'Área de exposição não coberta',
            fontWeight: FontWeight.bold,
          ),
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  name: 'quantidade',
                  validat: (p0) {},
                  getValue: (p0) {},
                ),
              ),
              Expanded(
                child: CustomTextField(
                  name: 'área total(m²)',
                  validat: (p0) {},
                  getValue: (p0) {},
                ),
              ),
              Expanded(
                child: CustomTextField(
                  name: 'capacidade nºpessoas',
                  validat: (p0) {},
                  getValue: (p0) {},
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class TabelsEquipamentoEEspaco extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Form(
      key: _formKey,
      child: Column(
        children: [

    //Municipal

          textLabel(
            name: 'Municipal',
            fontWeight: FontWeight.bold,
          ),
          textLabel(name: 'lei/decreto', fontWeight: FontWeight.bold),
          CustomTextField(
            name: 'nome/titulo/certificação/licenciamento/outro',
            validat: (p0) {},
            getValue: (p0) {},
          ),
          CustomTextField(
            name: 'entidade declaratória/tipo de declaração',
            validat: (p0) {},
            getValue: (p0) {},
          ),
          textLabel(
              name: 'portaria/instrução/deliberação',
              fontWeight: FontWeight.bold),
          CustomTextField(
            name: 'nome/titulo/certificação/licenciamento/outro',
            validat: (p0) {},
            getValue: (p0) {},
          ),
          CustomTextField(
            name: 'entidade declaratória/tipo de declaração',
            validat: (p0) {},
            getValue: (p0) {},
          ),
          textLabel(name: 'norma/ato', fontWeight: FontWeight.bold),
          CustomTextField(
            name: 'nome/titulo/certificação/licenciamento/outro',
            validat: (p0) {},
            getValue: (p0) {},
          ),
          CustomTextField(
            name: 'entidade declaratória/tipo de declaração',
            validat: (p0) {},
            getValue: (p0) {},
          ),
          textLabel(name: 'outros', fontWeight: FontWeight.bold),
          CustomTextField(
            name: 'nome/titulo/certificação/licenciamento/outro',
            validat: (p0) {},
            getValue: (p0) {},
          ),
          CustomTextField(
            name: 'entidade declaratória/tipo de declaração',
            validat: (p0) {},
            getValue: (p0) {},
          ),

    //Estadual/Distrital


          textLabel(
            name: 'Estadual/Distrital',
            fontWeight: FontWeight.bold,
          ),
          textLabel(name: 'lei/decreto', fontWeight: FontWeight.bold),
          CustomTextField(
            name: 'nome/titulo/certificação/licenciamento/outro',
            validat: (p0) {},
            getValue: (p0) {},
          ),
          CustomTextField(
            name: 'entidade declaratória/tipo de declaração',
            validat: (p0) {},
            getValue: (p0) {},
          ),
          textLabel(
              name: 'portaria/instrução/deliberação',
              fontWeight: FontWeight.bold),
          CustomTextField(
            name: 'nome/titulo/certificação/licenciamento/outro',
            validat: (p0) {},
            getValue: (p0) {},
          ),
          CustomTextField(
            name: 'entidade declaratória/tipo de declaração',
            validat: (p0) {},
            getValue: (p0) {},
          ),
          textLabel(name: 'norma/ato', fontWeight: FontWeight.bold),
          CustomTextField(
            name: 'nome/titulo/certificação/licenciamento/outro',
            validat: (p0) {},
            getValue: (p0) {},
          ),
          CustomTextField(
            name: 'entidade declaratória/tipo de declaração',
            validat: (p0) {},
            getValue: (p0) {},
          ),
          textLabel(name: 'outros', fontWeight: FontWeight.bold),
          CustomTextField(
            name: 'nome/titulo/certificação/licenciamento/outro',
            validat: (p0) {},
            getValue: (p0) {},
          ),
          CustomTextField(
            name: 'entidade declaratória/tipo de declaração',
            validat: (p0) {},
            getValue: (p0) {},
          ),

        //Federal

          textLabel(
            name: 'Federal',
            fontWeight: FontWeight.bold,
          ),
          textLabel(name: 'lei/decreto', fontWeight: FontWeight.bold),
          CustomTextField(
            name: 'nome/titulo/certificação/licenciamento/outro',
            validat: (p0) {},
            getValue: (p0) {},
          ),
          CustomTextField(
            name: 'entidade declaratória/tipo de declaração',
            validat: (p0) {},
            getValue: (p0) {},
          ),
          textLabel(
              name: 'portaria/instrução/deliberação',
              fontWeight: FontWeight.bold),
          CustomTextField(
            name: 'nome/titulo/certificação/licenciamento/outro',
            validat: (p0) {},
            getValue: (p0) {},
          ),
          CustomTextField(
            name: 'entidade declaratória/tipo de declaração',
            validat: (p0) {},
            getValue: (p0) {},
          ),
          textLabel(name: 'norma/ato', fontWeight: FontWeight.bold),
          CustomTextField(
            name: 'nome/titulo/certificação/licenciamento/outro',
            validat: (p0) {},
            getValue: (p0) {},
          ),
          CustomTextField(
            name: 'entidade declaratória/tipo de declaração',
            validat: (p0) {},
            getValue: (p0) {},
          ),
          textLabel(name: 'outros', fontWeight: FontWeight.bold),
          CustomTextField(
            name: 'nome/titulo/certificação/licenciamento/outro',
            validat: (p0) {},
            getValue: (p0) {},
          ),
          CustomTextField(
            name: 'entidade declaratória/tipo de declaração',
            validat: (p0) {},
            getValue: (p0) {},
          ),

          //Estadual/Distrital - Internacional


          textLabel(
            name: 'Estadual/Distrital - Internacional',
            fontWeight: FontWeight.bold,
          ),
          textLabel(name: 'lei/decreto', fontWeight: FontWeight.bold),
          CustomTextField(
            name: 'nome/titulo/certificação/licenciamento/outro',
            validat: (p0) {},
            getValue: (p0) {},
          ),
          CustomTextField(
            name: 'entidade declaratória/tipo de declaração',
            validat: (p0) {},
            getValue: (p0) {},
          ),
          textLabel(
              name: 'portaria/instrução/deliberação',
              fontWeight: FontWeight.bold),
          CustomTextField(
            name: 'nome/titulo/certificação/licenciamento/outro',
            validat: (p0) {},
            getValue: (p0) {},
          ),
          CustomTextField(
            name: 'entidade declaratória/tipo de declaração',
            validat: (p0) {},
            getValue: (p0) {},
          ),
          textLabel(name: 'norma/ato', fontWeight: FontWeight.bold),
          CustomTextField(
            name: 'nome/titulo/certificação/licenciamento/outro',
            validat: (p0) {},
            getValue: (p0) {},
          ),
          CustomTextField(
            name: 'entidade declaratória/tipo de declaração',
            validat: (p0) {},
            getValue: (p0) {},
          ),
          textLabel(name: 'outros', fontWeight: FontWeight.bold),
          CustomTextField(
            name: 'instrumento (n.º)',
            validat: (p0) {},
            getValue: (p0) {},
          ),
          CustomTextField(
            name: 'nome/titulo/certificação/licenciamento/outro',
            validat: (p0) {},
            getValue: (p0) {},
          ),
          CustomTextField(
            name: 'entidade declaratória/tipo de declaração',
            validat: (p0) {},
            getValue: (p0) {},
          ),
        ],
      ),
    );
  }
}
