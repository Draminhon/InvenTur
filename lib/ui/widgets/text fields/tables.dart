
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventur/ui/widgets/text%20fields/customOutro.dart';
import 'package:inventur/ui/widgets/text%20fields/customTextField.dart';
import 'package:inventur/validators/validators.dart';

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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Preencha o campo';
                }
                return null;
              },
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Preencha o campo';
                        }
                        return null;
                      },
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Preencha o campo';
                        }
                        return null;
                      },
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Preencha o campo';
                        }
                        return null;
                      },
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

class TabelaInfoGerais extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  TabelaInfoGerais({super.key});
  TextEditingController _razaoSocialController = new TextEditingController();
  TextEditingController _nomeFantasiaController = new TextEditingController();
  TextEditingController _cnpjController = new TextEditingController();
  TextEditingController _enderecoController = new TextEditingController();
  TextEditingController _telefoneController = new TextEditingController();


  

  Map<String, String> getData() {
    return {
      "razao_social": _razaoSocialController.text,
      "nome_fantasia": _nomeFantasiaController.text,
      "cnpj": _cnpjController.text,
      "endereco": _enderecoController.text,
      "telefone": _telefoneController.text
    };
  }

  fillForm(String razaoSocial, String nomeFantasia, String cnpj, String endereco, String telefone) {
    _razaoSocialController.text = razaoSocial;
    _enderecoController.text = endereco;
    _nomeFantasiaController.text = nomeFantasia;
    _cnpjController.text = cnpj;
    _telefoneController.text =  telefone;
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Preencha o campo';
                }
                return null;
              },
              controller: _razaoSocialController,
              style: const TextStyle(
                  color: Colors.black), //String? Function(String?)

              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),

                isDense: true,
                hintText: 'Razão Social',
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Preencha o campo';
                        }
                        return null;
                      },
                      controller: _nomeFantasiaController,
                      style: const TextStyle(
                          color: Colors.black), //String? Function(String?)

                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        isDense: true,
                        hintText: 'Nome Fantasia',
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
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly, Validators().cnpjFormatter],
                      keyboardType: TextInputType.numberWithOptions(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Preencha o campo';
                        }
                        return null;
                      },
                      controller: _cnpjController,
                      style: const TextStyle(
                          color: Colors.black), //String? Function(String?)

                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        isDense: true,
                        hintText: 'CNPJ',
                        
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Preencha o campo';
                        }
                        return null;
                      },
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
                      keyboardType: TextInputType.numberWithOptions(),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly, Validators().phoneFormatter],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Preencha o campo';
                        }
                        return null;
                      },
                      controller: _telefoneController,
                      style: const TextStyle(
                          color: Colors.black), //String? Function(String?)

                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        isDense: true,
                        hintText: 'Telefone',
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

class TabelaInfoGerais2 extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  TabelaInfoGerais2({super.key});
  TextEditingController _siteController = new TextEditingController();
  TextEditingController _tipoDeImoveisController = new TextEditingController();
  TextEditingController _outrasInfoController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();


  

  Map<String, String> getData() {
    return {
      "site": _siteController.text,
      "tipoImoveis": _tipoDeImoveisController.text,
      "outrasInfo": _outrasInfoController.text,
      "email": _emailController.text
    };
  }

  fillForm(String email, String site, String tipoDeImoveis, String outrasInfo) {
    _siteController.text = site;
    _tipoDeImoveisController.text = tipoDeImoveis;
    _outrasInfoController.text = outrasInfo;
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Preencha o campo';
                }
                return null;
              },
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
                  width: 168.w,
                  child: Image.asset('./assets/images/Rectangle.png')),
              Column(
                children: [
                  Container(
                    height: 190.w,
                    width: 1080.w,
                    margin: EdgeInsets.only(left: 30.w, right: 30.h, top: 50.h),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Preencha o campo';
                        }
                        return null;
                      },
                      controller: _siteController,
                      style: const TextStyle(
                          color: Colors.black), //String? Function(String?)

                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        isDense: true,
                        hintText: 'Site',
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Preencha o campo';
                        }
                        return null;
                      },
                      controller: _tipoDeImoveisController,
                      style: const TextStyle(
                          color: Colors.black), //String? Function(String?)

                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        isDense: true,
                        hintText: 'Tipo de Imóveis e Serviços Fornecidos',
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Preencha o campo';
                        }
                        return null;
                      },
                      controller: _outrasInfoController,
                      style: const TextStyle(
                          color: Colors.black), //String? Function(String?)

                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        isDense: true,
                        hintText: 'Outras Informações',
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

class TabelaGuiamentoTuristico extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  TabelaGuiamentoTuristico({super.key});
  TextEditingController _nomeCompleto = new TextEditingController();
  TextEditingController _cpfController = new TextEditingController();
  TextEditingController _enderecoController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _telefoneController = new TextEditingController();


  

  Map<String, String> getData() {
    return {
      "nome_completo": _nomeCompleto.text,
      "cpf": _cpfController.text,
      "endereco": _enderecoController.text,
      "telefone": _telefoneController.text,
      "email": _emailController.text,

    };
  }

  fillForm(String nomeCompleto, String cpf, String endereco,
      String email, String telefone) {
    _nomeCompleto.text = nomeCompleto;
    _enderecoController.text = endereco;
    _cpfController.text = cpf;
    _emailController.text = email;
    _telefoneController.text = telefone;
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Preencha o campo';
                }
                return null;
              },
              controller: _nomeCompleto,
              style: const TextStyle(
                  color: Colors.black), //String? Function(String?)

              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),

                isDense: true,
                hintText: 'Nome Completo',
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Preencha o campo';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.numberWithOptions(),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      
                      controller: _cpfController,
                      style: const TextStyle(
                          color: Colors.black), //String? Function(String?)

                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        isDense: true,
                        
                        hintText: 'CPF',
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
                      keyboardType: TextInputType.numberWithOptions(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Preencha o campo';
                        }
                        return null;
                      },
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Preencha o campo';
                        }
                        return null;
                      },
                      controller: _telefoneController,
                      style: const TextStyle(
                          color: Colors.black), //String? Function(String?)
                      keyboardType: TextInputType.numberWithOptions(),
                      inputFormatters: [Validators().phoneFormatter],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        isDense: true,
                        hintText: 'Telefones',
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Preencha o campo';
                        }
                        return null;
                      },
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

class TabelaGuiamentoTuristico2 extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  TabelaGuiamentoTuristico2({super.key});
  TextEditingController _escolaridade = new TextEditingController();
  TextEditingController _servicosEspecializados = new TextEditingController();
  TextEditingController _nCadastur = new TextEditingController();
  TextEditingController _outrosCadastros = new TextEditingController();
  TextEditingController _outrasInformacoes = new TextEditingController();


  

  Map<String, String> getData() {
    return {
      "escolaridade": _escolaridade.text,
      "servicos_especializados_formulario": _servicosEspecializados.text,
      "numero_cadastur": _nCadastur.text,
      "outras_informacoes": _outrasInformacoes.text,
      "outros_cadastros": _outrosCadastros.text,

    };
  }

  fillForm(String escolaridade, String servicosEspecializados, String numeroCadastur,
      String outrosCadastros, String outrasInformacoes) {
    _escolaridade.text = escolaridade;
    _nCadastur.text = numeroCadastur;
    _servicosEspecializados.text = servicosEspecializados;
    _outrosCadastros.text = outrosCadastros;
    _outrasInformacoes.text = outrasInformacoes;
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Preencha o campo';
                }
                return null;
              },
              controller: _escolaridade,
              style: const TextStyle(
                  color: Colors.black), //String? Function(String?)

              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),

                isDense: true,
                hintText: 'Escolaridade',
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Preencha o campo';
                        }
                        return null;
                      },
                      controller: _servicosEspecializados,
                      style: const TextStyle(
                          color: Colors.black), //String? Function(String?)

                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        isDense: true,
                        hintText: 'Serviços Especializados',
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
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly,],
                      keyboardType: TextInputType.numberWithOptions(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Preencha o campo';
                        }
                        return null;
                      },
                      controller: _nCadastur,
                      style: const TextStyle(
                          color: Colors.black), //String? Function(String?)

                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        isDense: true,
                        hintText: 'Nº do Cadastur',
                        
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Preencha o campo';
                        }
                        return null;
                      },
                      controller: _outrasInformacoes,
                      style: const TextStyle(
                          color: Colors.black), //String? Function(String?)

                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        isDense: true,
                        hintText: 'Outras Informações',
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Preencha o campo';
                        }
                        return null;
                      },
                      controller: _outrosCadastros,
                      style: const TextStyle(
                          color: Colors.black), //String? Function(String?)

                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        isDense: true,
                        hintText: 'Outros cadastros e registros (Tipo e nº)',
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

class DiasRow extends StatefulWidget {
  final String dayLabel;
  final double spacing;

  final Function(Map<String, dynamic>)? onChanged;
  final String? nome;
  Map<String, dynamic>? getValue;
  DiasRow(
      {super.key,
      required this.dayLabel,
      required this.spacing,
      this.onChanged,
      this.getValue,
      this.nome});

  @override
  State<DiasRow> createState() => _DiasRowState();
}

class _DiasRowState extends State<DiasRow> {
  Map<String, dynamic> _valoresJson = {};
  late TextEditingController _aberturaController;
  late TextEditingController _encerramentoController;

  @override
  void initState() {
    super.initState();
    _aberturaController = TextEditingController();
    _encerramentoController = TextEditingController();

    if (widget.getValue != null) {
      _aberturaController.text =
          widget.getValue!['${widget.nome} abertura'] ?? '';
      _encerramentoController.text =
          widget.getValue!['${widget.nome} encerramento'] ?? '';
    }
  }

  @override
  void dispose() {
    _aberturaController.dispose();
    _encerramentoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        textLabel(
          name: widget.dayLabel,
          textAlign: TextAlign.start,
        ),
        SizedBox(width: widget.spacing),
        Expanded(
            child: CustomTimeField(
          controller2: _aberturaController,
          label: 'abertura',
          getValue: (p0) {
            setState(() {
              _valoresJson['${widget.nome} abertura'] = p0;
            });
            widget.onChanged?.call(_valoresJson);
          },
        )),
        Expanded(
          child: CustomTimeField(
            controller2: _encerramentoController,
            label: 'encerramento',
            getValue: (p0) {
              setState(() {
                _valoresJson['${widget.nome} encerramento'] = p0;
              });
              widget.onChanged?.call(_valoresJson);
            },
          ),
        )
      ],
    );
  }
}

class TabelaHorarios extends StatefulWidget {
  final Function(Map<String, dynamic>)? onChanged;
  Map<String, dynamic>? getValue;
  TabelaHorarios({Key? key, this.onChanged, this.getValue}) : super(key: key);

  @override
  State<TabelaHorarios> createState() => _TabelaHorariosState();
}

class _TabelaHorariosState extends State<TabelaHorarios> {
  final _formKey = GlobalKey<FormState>();

  final Map<String, dynamic> _valoresJson = {};
  final days = [
    DayConfig(label: 'segunda\nfeira:', spacing: 5.w),
    DayConfig(label: 'terça\nfeira:', spacing: 95.w),
    DayConfig(label: 'quarta\nfeira:', spacing: 50.w),
    DayConfig(label: 'quinta\nfeira:', spacing: 60.w),
    DayConfig(label: 'sexta\nfeira:', spacing: 95.w),
    DayConfig(label: 'sábado:', spacing: 20.w),
    DayConfig(label: 'domingo:', spacing: 5.w)
  ];

  void _handleRowChanged(Map<String, dynamic> rowValues) {
    _valoresJson.addAll(rowValues);

    if (widget.onChanged != null) {
      widget.onChanged!(_valoresJson);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Form(
        key: _formKey,
        child: Column(
          children: [
            for (final day in days)
              DiasRow(
                getValue: widget.getValue,
                dayLabel: day.label,
                spacing: day.spacing,
                nome: day.label,
                onChanged: _handleRowChanged,
              )
          ],
        ));
  }
}

class DayConfig {
  final String label;
  final double spacing;

  // Construtor
  const DayConfig({
    required this.label,
    required this.spacing,
  });
}

class TablesInstalacoes extends StatefulWidget {
  final Map<String, dynamic>? getValue;
  final Function(Map<String, dynamic>)? onChanged;
  TablesInstalacoes({super.key, this.onChanged, this.getValue});

  @override
  State<TablesInstalacoes> createState() => _TablesInstalacoesState();
}

class _TablesInstalacoesState extends State<TablesInstalacoes> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> _valoresJson = {};
  Map<String, TextEditingController> controllers = {};

  void autoFillForm() {
    // Função auxiliar para preencher os controladores com os valores do JSON
    void fillIfExists(String key, dynamic value) {
      if (value != null) {
        controllers[key]?.text = value.toString();
      }
    }

    final values = widget.getValue!;
    fillIfExists('auditorio quantidade', values['auditorioQUantidade']);
    fillIfExists('auditorio area total', values['auditorioAreaTotal']);
    fillIfExists('auditorio capacidade n de pessoas',
        values['auditorioCapacidadeDePessoas']);

    fillIfExists(
        'salas modulares quantidade', values['salasModularesQuantidade']);
    fillIfExists(
        'salas modulares area total', values['salasModularesAreaTotal']);
    fillIfExists(
        'capacidade de pessoas', values['salasModularesCapacidadeDePessoas']);

    fillIfExists(
        'pavilhao de feiras quantidade', values['pavilhaoDeFeirasQuantidade']);
    fillIfExists(
        'pavilhao de feiras area total', values['pavilhaoDeFeirasAreaTotal']);
    fillIfExists('pavilhao de feiras n de pessoas',
        values['pavilhaoDeFeirasCapacidadeDePessoas']);

    fillIfExists('area de exposicao coberta quantidade',
        values['areaDeExposicaoCobertaQuantidade']);
    fillIfExists('area de exposicao coberta area total',
        values['areaDeExposicaoCobertaAreaTotal']);
    fillIfExists('area de exposicao coberta capacidade',
        values['areaDeExposicaoCobertaCapacidadeDePessoas']);

    fillIfExists('area de exposicao nao coberta quantidade',
        values['areaDeExposicaoNaoCobertaQuantidade']);
    fillIfExists('area de exposicao nao coberta area total',
        values['areaDeExposicaoNaoCobertaAreaTotal']);
    fillIfExists('area de exposicao nao coberta capacidade',
        values['areaDeExposicaoNaoCobertaCapacidadeDePessoas']);
  }

  @override
  void initState() {
    super.initState();

    List<String> keys = [
      'auditorio quantidade',
      'auditorio area total',
      'auditorio capacidade n de pessoas',
      'salas modulares quantidade',
      'salas modulares area total',
      'capacidade de pessoas',
      'pavilhao de feiras quantidade',
      'pavilhao de feiras area total',
      'pavilhao de feiras n de pessoas',
      'area de exposicao coberta quantidade',
      'area de exposicao coberta area total',
      'area de exposicao coberta capacidade',
      'area de exposicao nao coberta quantidade',
      'area de exposicao nao coberta area total',
      'area de exposicao nao coberta capacidade'
    ];

    for (var key in keys) {
      controllers[key] = TextEditingController();
    }

    if (widget.getValue != null) {
      autoFillForm();
    }
  }

  @override
  void dispose() {
    super.dispose();
    for (var controllers in controllers.values) {
      controllers.dispose();
    }
  }

  TextEditingController getController(String key) {
    controllers[key] ??= TextEditingController();
    return controllers[key]!;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                controller: getController('auditorio quantidade'),
                validat: (p0) {},
                getValue: (p0) {
                  _valoresJson['auditorioQUantidade'] = p0;
                  widget.onChanged?.call(_valoresJson);
                },
              ),
            ),
            Expanded(
              child: CustomTextField(
                name: 'área total(m²)',
                controller: getController('auditorio area total'),
                validat: (p0) {},
                getValue: (p0) {
                  _valoresJson['auditorioAreaTotal'] = p0;
                  widget.onChanged?.call(_valoresJson);
                },
              ),
            ),
            Expanded(
              child: CustomTextField(
                name: 'capacidade nºpessoas',
                controller: getController('auditorio capacidade n de pessoas'),
                validat: (p0) {},
                getValue: (p0) {
                  _valoresJson['auditorioCapacidadeDePessoas'] = p0;
                  widget.onChanged?.call(_valoresJson);
                },
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
                controller: getController('salas modulares quantidade'),
                validat: (p0) {},
                getValue: (p0) {
                  _valoresJson['salasModularesQuantidade'] = p0;
                  widget.onChanged?.call(_valoresJson);
                },
              ),
            ),
            Expanded(
              child: CustomTextField(
                name: 'área total(m²)',
                controller: getController('salas modulares area total'),
                validat: (p0) {},
                getValue: (p0) {
                  _valoresJson['salasModularesAreaTotal'] = p0;
                  widget.onChanged?.call(_valoresJson);
                },
              ),
            ),
            Expanded(
              child: CustomTextField(
                name: 'capacidade nºpessoas',
                validat: (p0) {},
                controller: getController('capacidade de pessoas'),
                getValue: (p0) {
                  _valoresJson['salasModularesCapacidadeDePessoas'] = p0;
                  widget.onChanged?.call(_valoresJson);
                },
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
                controller: getController('pavilhao de feiras quantidade'),
                getValue: (p0) {
                  _valoresJson['pavilhaoDeFeirasQuantidade'] = p0;
                  widget.onChanged?.call(_valoresJson);
                },
              ),
            ),
            Expanded(
              child: CustomTextField(
                name: 'área total(m²)',
                validat: (p0) {},
                controller: getController('pavilhao de feiras area total'),
                getValue: (p0) {
                  _valoresJson['pavilhaoDeFeirasAreaTotal'] = p0;
                  widget.onChanged?.call(_valoresJson);
                },
              ),
            ),
            Expanded(
              child: CustomTextField(
                name: 'capacidade nºpessoas',
                validat: (p0) {},
                controller: getController('pavilhao de feiras n de pessoas'),
                getValue: (p0) {
                  _valoresJson['pavilhaoDeFeirasCapacidadeDePessoas'] = p0;
                  widget.onChanged?.call(_valoresJson);
                },
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
                controller:
                    getController('area de exposicao coberta quantidade'),
                getValue: (p0) {
                  _valoresJson['areaDeExposicaoCobertaQuantidade'] = p0;
                  widget.onChanged?.call(_valoresJson);
                },
              ),
            ),
            Expanded(
              child: CustomTextField(
                name: 'área total(m²)',
                validat: (p0) {},
                controller:
                    getController('area de exposicao coberta area total'),
                getValue: (p0) {
                  _valoresJson['areaDeExposicaoCobertaAreaTotal'] = p0;
                  widget.onChanged?.call(_valoresJson);
                },
              ),
            ),
            Expanded(
              child: CustomTextField(
                name: 'capacidade nºpessoas',
                validat: (p0) {},
                controller:
                    getController('area de exposicao coberta capacidade'),
                getValue: (p0) {
                  _valoresJson['areaDeExposicaoCobertaCapacidadeDePessoas'] =
                      p0;
                  widget.onChanged?.call(_valoresJson);
                },
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
                controller:
                    getController('area de exposicao nao coberta quantidade'),
                getValue: (p0) {
                  _valoresJson['areaDeExposicaoNaoCobertaQuantidade'] = p0;
                  widget.onChanged?.call(_valoresJson);
                },
              ),
            ),
            Expanded(
              child: CustomTextField(
                name: 'área total(m²)',
                validat: (p0) {},
                controller:
                    getController('area de exposicao nao coberta area total'),
                getValue: (p0) {
                  _valoresJson['areaDeExposicaoNaoCobertaAreaTotal'] = p0;
                  widget.onChanged?.call(_valoresJson);
                },
              ),
            ),
            Expanded(
              child: CustomTextField(
                name: 'capacidade nºpessoas',
                validat: (p0) {},
                controller:
                    getController('area de exposicao nao coberta capacidade'),
                getValue: (p0) {
                  _valoresJson['areaDeExposicaoNaoCobertaCapacidadeDePessoas'] =
                      p0;
                },
              ),
            )
          ],
        ),
      ],
    );
  }
}

class TabelsEquipamentoEEspaco extends StatefulWidget {
  final Map<String, dynamic>? getValue;
  final Function(Map<String, dynamic>)? onChanged;

  const TabelsEquipamentoEEspaco({
    Key? key,
    this.onChanged,
    this.getValue,
  }) : super(key: key);

  @override
  _TabelsEquipamentoEEspacoState createState() =>
      _TabelsEquipamentoEEspacoState();
}

class _TabelsEquipamentoEEspacoState extends State<TabelsEquipamentoEEspaco> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> _valoresJson = {};
  Map<String, TextEditingController> controllers = {};

  @override
  void initState() {
    super.initState();

    // Lista de chaves para os controladores
    List<String> keys = [
      'Municipal lei decreto nome',
      'entidade lei decreto municipal',
      'nome portaria',
      'entidade portaria',
      'nome norma ato',
      'entidade norma ato',
      'nomeOutrosMunicipal',
      'entidade outros',
      'EstadualDistrital lei decreto nome',
      'entidade lei decreto EstadualDistrital',
      'entidadePortariaInstrucaoEstadualDistrital',
      'entidadePortariaEstadualDistrital',
      'nomeNormaAtoEstadualDistrital',
      'entidadeNormaAtoEstadualDistrital',
      'nomeOutrosEstadualDistrital',
      'entidadeOutrosEstadualDistrital',
      'Federal lei decreto nome',
      'entidade lei decreto Federal',
      'entidadePortariaInstrucaoFederal',
      'entidadePortariaFederal',
      'nomeNormaAtoFederal',
      'entidadeNormaAtoFederal',
      'nomeOutrosFederal',
      'entidadeOutrosFederal',
      'Internacional lei decreto nome',
      'entidade lei decreto Internacional',
      'entidadePortariaInstrucaoInternacional',
      'entidadePortariaInternacional',
      'nomeNormaAtoInternacional',
      'entidadeNormaAtoInternacional',
      'nomeOutrosInternacional',
      'entidadeOutrosInternacional',
      'outras nome',
      'outras lei decreto nome',
      'entidade lei decreto Outras',
    ];

    // Inicializa os controladores para cada chave
    for (var key in keys) {
      controllers[key] = TextEditingController();
    }

    // Se houver valores para preencher, chama o autoFill
    if (widget.getValue != null) {
      autoFillForm();
    }
  }

  @override
  void dispose() {
    // Desfaz o dispose de cada controlador para evitar vazamentos de memória
    for (var controller in controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void autoFillForm() {
    // Função auxiliar para preencher os controladores com os valores do JSON
    void fillIfExists(String key, dynamic value) {
      if (value != null) {
        controllers[key]?.text = value.toString();
      }
    }

    final values = widget.getValue!;
    fillIfExists(
        'Municipal lei decreto nome', values['nomeLeiDecretoMunicipal']);
    fillIfExists('entidade lei decreto municipal',
        values['entidadeLeiDecretoMunicipal']);
    fillIfExists('nome portaria', values['entidadePortariaInstrucaoMunicipal']);
    fillIfExists('entidade portaria', values['entidadePortariaMunicipal']);
    fillIfExists('nome norma ato', values['nomeNormaAtoMunicipal']);
    fillIfExists('entidade norma ato', values['entidadeNormaAtoMunicipal']);
    fillIfExists('nomeOutrosMunicipal', values['nomeOutrosMunicipal']);
    fillIfExists('entidade outros', values['entidadeOutrosMunicipal']);

    fillIfExists('EstadualDistrital lei decreto nome',
        values['nomeLeiDecretoEstadualDistrital']);
    fillIfExists('entidade lei decreto EstadualDistrital',
        values['entidadeLeiDecretoEstadualDistrital']);
    fillIfExists('entidadePortariaInstrucaoEstadualDistrital',
        values['entidadePortariaInstrucaoEstadualDistrital']);
    fillIfExists('entidadePortariaEstadualDistrital',
        values['entidadePortariaEstadualDistrital']);
    fillIfExists('nomeNormaAtoEstadualDistrital',
        values['nomeNormaAtoEstadualDistrital']);
    fillIfExists('entidadeNormaAtoEstadualDistrital',
        values['entidadeNormaAtoEstadualDistrital']);
    fillIfExists(
        'nomeOutrosEstadualDistrital', values['nomeOutrosEstadualDistrital']);
    fillIfExists('entidadeOutrosEstadualDistrital',
        values['entidadeOutrosEstadualDistrital']);

    fillIfExists('Federal lei decreto nome', values['nomeLeiDecretoFederal']);
    fillIfExists(
        'entidade lei decreto Federal', values['entidadeLeiDecretoFederal']);
    fillIfExists('entidadePortariaInstrucaoFederal',
        values['entidadePortariaInstrucaoFederal']);
    fillIfExists('entidadePortariaFederal', values['entidadePortariaFederal']);
    fillIfExists('nomeNormaAtoFederal', values['nomeNormaAtoFederal']);
    fillIfExists('entidadeNormaAtoFederal', values['entidadeNormaAtoFederal']);
    fillIfExists('nomeOutrosFederal', values['nomeOutrosFederal']);
    fillIfExists('entidadeOutrosFederal', values['entidadeOutrosFederal']);

    fillIfExists('Internacional lei decreto nome',
        values['nomeLeiDecretoInternacional']);
    fillIfExists('entidade lei decreto Internacional',
        values['entidadeLeiDecretoInternacional']);
    fillIfExists('entidadePortariaInstrucaoInternacional',
        values['entidadePortariaInstrucaoInternacional']);
    fillIfExists('entidadePortariaInternacional',
        values['entidadePortariaInternacional']);
    fillIfExists(
        'nomeNormaAtoInternacional', values['nomeNormaAtoInternacional']);
    fillIfExists('entidadeNormaAtoInternacional',
        values['entidadeNormaAtoInternacional']);
    fillIfExists('nomeOutrosInternacional', values['nomeOutrosInternacional']);
    fillIfExists(
        'entidadeOutrosInternacional', values['entidadeOutrosInternacional']);

    fillIfExists('outras nome', values['outras nome']);
    fillIfExists('outras lei decreto nome', values['nomeLeiDecretoOutras']);
    fillIfExists(
        'entidade lei decreto Outras', values['entidadeLeiDecretoOutras']);
  }

  TextEditingController getController(String key) {
    controllers[key] ??= TextEditingController();
    return controllers[key]!;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Municipal
        textLabel(
          name: 'Municipal',
          fontWeight: FontWeight.bold,
        ),
        textLabel(name: 'lei/decreto', fontWeight: FontWeight.bold),
        CustomTextField(
          controller: getController('Municipal lei decreto nome'),
          name: 'nome/titulo/certificação/licenciamento/outro',
          validat: (p0) {},
          getValue: (p0) {
            _valoresJson['nomeLeiDecretoMunicipal'] = p0;
            widget.onChanged?.call(_valoresJson);
          },
        ),
        CustomTextField(
          controller: getController('entidade lei decreto municipal'),
          name: 'entidade declaratória/tipo de declaração',
          validat: (p0) {},
          getValue: (p0) {
            _valoresJson['entidadeLeiDecretoMunicipal'] = p0;
            widget.onChanged?.call(_valoresJson);
          },
        ),
        textLabel(
          name: 'portaria/instrução/deliberação',
          fontWeight: FontWeight.bold,
        ),
        CustomTextField(
          controller: getController('nome portaria'),
          name: 'nome/titulo/certificação/licenciamento/outro',
          validat: (p0) {},
          getValue: (p0) {
            _valoresJson['entidadePortariaInstrucaoMunicipal'] = p0;
            widget.onChanged?.call(_valoresJson);
          },
        ),
        CustomTextField(
          controller: getController('entidade portaria'),
          name: 'entidade declaratória/tipo de declaração',
          validat: (p0) {},
          getValue: (p0) {
            _valoresJson['entidadePortariaMunicipal'] = p0;
            widget.onChanged?.call(_valoresJson);
          },
        ),
        textLabel(name: 'norma/ato', fontWeight: FontWeight.bold),
        CustomTextField(
          controller: getController('nome norma ato'),
          name: 'nome/titulo/certificação/licenciamento/outro',
          validat: (p0) {},
          getValue: (p0) {
            _valoresJson['nomeNormaAtoMunicipal'] = p0;
            widget.onChanged?.call(_valoresJson);
          },
        ),
        CustomTextField(
          controller: getController('entidade norma ato'),
          name: 'entidade declaratória/tipo de declaração',
          validat: (p0) {},
          getValue: (p0) {
            _valoresJson['entidadeNormaAtoMunicipal'] = p0;
            widget.onChanged?.call(_valoresJson);
          },
        ),
        textLabel(name: 'outros', fontWeight: FontWeight.bold),
        CustomTextField(
          controller: getController('nomeOutrosMunicipal'),
          name: 'nome/titulo/certificação/licenciamento/outro',
          validat: (p0) {},
          getValue: (p0) {
            _valoresJson['nomeOutrosMunicipal'] = p0;
            widget.onChanged?.call(_valoresJson);
          },
        ),
        CustomTextField(
          controller: getController('entidade outros'),
          name: 'entidade declaratória/tipo de declaração',
          validat: (p0) {},
          getValue: (p0) {
            _valoresJson['entidadeOutrosMunicipal'] = p0;
            widget.onChanged?.call(_valoresJson);
          },
        ),

        // Estadual/Distrital
        SizedBox(height: 50),
        textLabel(
          name: 'Estadual/Distrital',
          fontWeight: FontWeight.bold,
        ),
        textLabel(name: 'lei/decreto', fontWeight: FontWeight.bold),
        CustomTextField(
          controller: getController('EstadualDistrital lei decreto nome'),
          name: 'nome/titulo/certificação/licenciamento/outro',
          validat: (p0) {},
          getValue: (p0) {
            _valoresJson['nomeLeiDecretoEstadualDistrital'] = p0;
            widget.onChanged?.call(_valoresJson);
          },
        ),
        CustomTextField(
          controller: getController('entidade lei decreto EstadualDistrital'),
          name: 'entidade declaratória/tipo de declaração',
          validat: (p0) {},
          getValue: (p0) {
            _valoresJson['entidadeLeiDecretoEstadualDistrital'] = p0;
            widget.onChanged?.call(_valoresJson);
          },
        ),
        textLabel(
          name: 'portaria/instrução/deliberação',
          fontWeight: FontWeight.bold,
        ),
        CustomTextField(
          controller:
              getController('entidadePortariaInstrucaoEstadualDistrital'),
          name: 'nome/titulo/certificação/licenciamento/outro',
          validat: (p0) {},
          getValue: (p0) {
            _valoresJson['entidadePortariaInstrucaoEstadualDistrital'] = p0;
            widget.onChanged?.call(_valoresJson);
          },
        ),
        CustomTextField(
          controller: getController('entidadePortariaEstadualDistrital'),
          name: 'entidade declaratória/tipo de declaração',
          validat: (p0) {},
          getValue: (p0) {
            _valoresJson['entidadePortariaEstadualDistrital'] = p0;
            widget.onChanged?.call(_valoresJson);
          },
        ),
        textLabel(name: 'norma/ato', fontWeight: FontWeight.bold),
        CustomTextField(
          controller: getController('nomeNormaAtoEstadualDistrital'),
          name: 'nome/titulo/certificação/licenciamento/outro',
          validat: (p0) {},
          getValue: (p0) {
            _valoresJson['nomeNormaAtoEstadualDistrital'] = p0;
            widget.onChanged?.call(_valoresJson);
          },
        ),
        CustomTextField(
          controller: getController('entidadeNormaAtoEstadualDistrital'),
          name: 'entidade declaratória/tipo de declaração',
          validat: (p0) {},
          getValue: (p0) {
            _valoresJson['entidadeNormaAtoEstadualDistrital'] = p0;
            widget.onChanged?.call(_valoresJson);
          },
        ),
        textLabel(name: 'outros', fontWeight: FontWeight.bold),
        CustomTextField(
          controller: getController('nomeOutrosEstadualDistrital'),
          name: 'nome/titulo/certificação/licenciamento/outro',
          validat: (p0) {},
          getValue: (p0) {
            _valoresJson['nomeOutrosEstadualDistrital'] = p0;
            widget.onChanged?.call(_valoresJson);
          },
        ),
        CustomTextField(
          controller: getController('entidadeOutrosEstadualDistrital'),
          name: 'entidade declaratória/tipo de declaração',
          validat: (p0) {},
          getValue: (p0) {
            _valoresJson['entidadeOutrosEstadualDistrital'] = p0;
            widget.onChanged?.call(_valoresJson);
          },
        ),

        // Federal
        SizedBox(height: 50),
        textLabel(
          name: 'Federal',
          fontWeight: FontWeight.bold,
        ),
        textLabel(name: 'lei/decreto', fontWeight: FontWeight.bold),
        CustomTextField(
          controller: getController('Federal lei decreto nome'),
          name: 'nome/titulo/certificação/licenciamento/outro',
          validat: (p0) {},
          getValue: (p0) {
            _valoresJson['nomeLeiDecretoFederal'] = p0;
            widget.onChanged?.call(_valoresJson);
          },
        ),
        CustomTextField(
          controller: getController('entidade lei decreto Federal'),
          name: 'entidade declaratória/tipo de declaração',
          validat: (p0) {},
          getValue: (p0) {
            _valoresJson['entidadeLeiDecretoFederal'] = p0;
            widget.onChanged?.call(_valoresJson);
          },
        ),
        textLabel(
          name: 'portaria/instrução/deliberação',
          fontWeight: FontWeight.bold,
        ),
        CustomTextField(
          controller: getController('entidadePortariaInstrucaoFederal'),
          name: 'nome/titulo/certificação/licenciamento/outro',
          validat: (p0) {},
          getValue: (p0) {
            _valoresJson['entidadePortariaInstrucaoFederal'] = p0;
            widget.onChanged?.call(_valoresJson);
          },
        ),
        CustomTextField(
          controller: getController('entidadePortariaFederal'),
          name: 'entidade declaratória/tipo de declaração',
          validat: (p0) {},
          getValue: (p0) {
            _valoresJson['entidadePortariaFederal'] = p0;
            widget.onChanged?.call(_valoresJson);
          },
        ),
        textLabel(name: 'norma/ato', fontWeight: FontWeight.bold),
        CustomTextField(
          controller: getController('nomeNormaAtoFederal'),
          name: 'nome/titulo/certificação/licenciamento/outro',
          validat: (p0) {},
          getValue: (p0) {
            _valoresJson['nomeNormaAtoFederal'] = p0;
            widget.onChanged?.call(_valoresJson);
          },
        ),
        CustomTextField(
          controller: getController('entidadeNormaAtoFederal'),
          name: 'entidade declaratória/tipo de declaração',
          validat: (p0) {},
          getValue: (p0) {
            _valoresJson['entidadeNormaAtoFederal'] = p0;
            widget.onChanged?.call(_valoresJson);
          },
        ),
        textLabel(name: 'outros', fontWeight: FontWeight.bold),
        CustomTextField(
          controller: getController('nomeOutrosFederal'),
          name: 'nome/titulo/certificação/licenciamento/outro',
          validat: (p0) {},
          getValue: (p0) {
            _valoresJson['nomeOutrosFederal'] = p0;
            widget.onChanged?.call(_valoresJson);
          },
        ),
        CustomTextField(
          controller: getController('entidadeOutrosFederal'),
          name: 'entidade declaratória/tipo de declaração',
          validat: (p0) {},
          getValue: (p0) {
            _valoresJson['entidadeOutrosFederal'] = p0;
            widget.onChanged?.call(_valoresJson);
          },
        ),

        // Internacional
        SizedBox(height: 50),
        textLabel(
          name: 'Internacional',
          fontWeight: FontWeight.bold,
        ),
        textLabel(name: 'lei/decreto', fontWeight: FontWeight.bold),
        CustomTextField(
          controller: getController('Internacional lei decreto nome'),
          name: 'nome/titulo/certificação/licenciamento/outro',
          validat: (p0) {},
          getValue: (p0) {
            _valoresJson['nomeLeiDecretoInternacional'] = p0;
            widget.onChanged?.call(_valoresJson);
          },
        ),
        CustomTextField(
          controller: getController('entidade lei decreto Internacional'),
          name: 'entidade declaratória/tipo de declaração',
          validat: (p0) {},
          getValue: (p0) {
            _valoresJson['entidadeLeiDecretoInternacional'] = p0;
            widget.onChanged?.call(_valoresJson);
          },
        ),
        textLabel(
          name: 'portaria/instrução/deliberação',
          fontWeight: FontWeight.bold,
        ),
        CustomTextField(
          controller: getController('entidadePortariaInstrucaoInternacional'),
          name: 'nome/titulo/certificação/licenciamento/outro',
          validat: (p0) {},
          getValue: (p0) {
            _valoresJson['entidadePortariaInstrucaoInternacional'] = p0;
            widget.onChanged?.call(_valoresJson);
          },
        ),
        CustomTextField(
          controller: getController('entidadePortariaInternacional'),
          name: 'entidade declaratória/tipo de declaração',
          validat: (p0) {},
          getValue: (p0) {
            _valoresJson['entidadePortariaInternacional'] = p0;
            widget.onChanged?.call(_valoresJson);
          },
        ),
        textLabel(name: 'norma/ato', fontWeight: FontWeight.bold),
        CustomTextField(
          controller: getController('nomeNormaAtoInternacional'),
          name: 'nome/titulo/certificação/licenciamento/outro',
          validat: (p0) {},
          getValue: (p0) {
            _valoresJson['nomeNormaAtoInternacional'] = p0;
            widget.onChanged?.call(_valoresJson);
          },
        ),
        CustomTextField(
          controller: getController('entidadeNormaAtoInternacional'),
          name: 'entidade declaratória/tipo de declaração',
          validat: (p0) {},
          getValue: (p0) {
            _valoresJson['entidadeNormaAtoInternacional'] = p0;
            widget.onChanged?.call(_valoresJson);
          },
        ),
        textLabel(name: 'outros', fontWeight: FontWeight.bold),
        CustomTextField(
          controller: getController('nomeOutrosInternacional'),
          name: 'nome/titulo/certificação/licenciamento/outro',
          validat: (p0) {},
          getValue: (p0) {
            _valoresJson['nomeOutrosInternacional'] = p0;
            widget.onChanged?.call(_valoresJson);
          },
        ),
        CustomTextField(
          controller: getController('entidadeOutrosInternacional'),
          name: 'entidade declaratória/tipo de declaração',
          validat: (p0) {},
          getValue: (p0) {
            _valoresJson['entidadeOutrosInternacional'] = p0;
            widget.onChanged?.call(_valoresJson);
          },
        ),

        // Outras
        SizedBox(height: 50),
        textLabel(
          name: 'Outras',
          fontWeight: FontWeight.bold,
        ),
        CustomTextField(
          controller: getController('outras nome'),
          name: 'insira o nome',
          validat: (p0) {},
          getValue: (p0) {
            _valoresJson['outras nome'] = p0;
            widget.onChanged?.call(_valoresJson);
          },
        ),
        CustomTextField(
          controller: getController('outras lei decreto nome'),
          name: 'nome/titulo/certificação/licenciamento/outro',
          validat: (p0) {},
          getValue: (p0) {
            _valoresJson['nomeLeiDecretoOutras'] = p0;
            widget.onChanged?.call(_valoresJson);
          },
        ),
        CustomTextField(
          controller: getController('entidade lei decreto Outras'),
          name: 'entidade declaratória/tipo de declaração',
          validat: (p0) {},
          getValue: (p0) {
            _valoresJson['entidadeLeiDecretoOutras'] = p0;
            widget.onChanged?.call(_valoresJson);
          },
        ),
      ],
    );
  }
}

class TableMtur extends StatefulWidget {
  final String? associacao_e_sindicato;
  final Map<String, dynamic>? getValues;
  final Function(Map<String, dynamic>)? onChanged;

  const TableMtur({
    Key? key,
    this.associacao_e_sindicato,
    this.onChanged,
    this.getValues,
  }) : super(key: key);

  @override
  _TableMturState createState() => _TableMturState();
}

class _TableMturState extends State<TableMtur> {
  Map<String, dynamic> _valoresJson = {};
  Map<String, TextEditingController> controllers = {};

  @override
  void initState() {
    super.initState();
    // Inicializa os controladores
    controllers['CADASTUR'] = TextEditingController();
    controllers['MTUR Outros'] = TextEditingController();
    controllers['associação e sindicatos do setor de alimentação'] =
        TextEditingController();
    controllers['associações de turismo'] = TextEditingController();
    controllers['associações comerciais'] = TextEditingController();
    controllers['guias turisticos'] = TextEditingController();
    controllers['outros'] = TextEditingController();

    // Se houver valores iniciais, preenche os campos
    if (widget.getValues != null) {
      autoFillForm();
    }
  }

  @override
  void dispose() {
    // Dispose dos controladores para evitar vazamentos de memória
    for (var controller in controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void autoFillForm() {
    // Exemplo de debug
    print(widget.getValues!['CADASTUR']);

    // Função auxiliar para preencher os controladores se a chave existir
    void fillIfExists(String key, String value) {
      if (controllers.containsKey(key)) {
        controllers[key]!.text = value;
      }
    }

    // Preenche os controladores com os valores recebidos
    fillIfExists('CADASTUR', widget.getValues!['CADASTUR'] ?? '');
    fillIfExists('MTUR Outros', widget.getValues!['MturOutros'] ?? '');
    fillIfExists(
      'associação e sindicatos do setor de alimentação',
      widget.getValues![
              'categoriaAssociacoesESindicatosDoSetorDeAlimentacao'] ??
          '',
    );
    fillIfExists(
      'associações de turismo',
      widget.getValues!['categoriaAssociacoesDeTurismo'] ?? '',
    );
    fillIfExists(
      'associações comerciais',
      widget.getValues!['categoriaAssociacoesComerciais'] ?? '',
    );
    fillIfExists(
      'guias turisticos',
      widget.getValues!['categoriaGuiasTuristicos'] ?? '',
    );
    fillIfExists(
      'outros',
      widget.getValues!['categoriaOutros'] ?? '',
    );
  }

  TextEditingController getController(String key) {
    controllers[key] ??= TextEditingController();
    return controllers[key]!;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        textLabel(
          name: "MTur",
          fontWeight: FontWeight.bold,
        ),
        CustomTextField(
          controller: getController('CADASTUR'),
          name: "CADASTUR",
          validat: (p0) {},
          getValue: (p0) {
            _valoresJson['CADASTUR'] = p0;
            widget.onChanged?.call(_valoresJson);
          },
        ),
        CustomTextField(
          controller: getController('MTUR Outros'),
          name: "outros",
          validat: (p0) {},
          getValue: (p0) {
            _valoresJson['MturOutros'] = p0;
            widget.onChanged?.call(_valoresJson);
          },
        ),
        textLabel(
          name: (widget.associacao_e_sindicato?.isEmpty ?? true)
              ? 'associações e sindicatos do setor de hospedagem'
              : widget.associacao_e_sindicato!,
          fontWeight: FontWeight.bold,
        ),
        CustomTextField(
          controller:
              getController('associação e sindicatos do setor de alimentação'),
          name: "categoria/tipo/classificação/número",
          validat: (p0) {},
          getValue: (p0) {
            _valoresJson[
                'categoriaAssociacoesESindicatosDoSetorDeAlimentacao'] = p0;
            widget.onChanged?.call(_valoresJson);
          },
        ),
        textLabel(
          name: "associações de turismo",
          fontWeight: FontWeight.bold,
        ),
        CustomTextField(
          controller: getController('associações de turismo'),
          name: "categoria/tipo/classificação/número",
          validat: (p0) {},
          getValue: (p0) {
            _valoresJson['categoriaAssociacoesDeTurismo'] = p0;
            widget.onChanged?.call(_valoresJson);
          },
        ),
        textLabel(
          name: "associações comerciais",
          fontWeight: FontWeight.bold,
        ),
        CustomTextField(
          controller: getController('associações comerciais'),
          name: "categoria/tipo/classificação/número",
          validat: (p0) {},
          getValue: (p0) {
            _valoresJson['categoriaAssociacoesComerciais'] = p0;
            widget.onChanged?.call(_valoresJson);
          },
        ),
        textLabel(
          name: "guias turísticos",
          fontWeight: FontWeight.bold,
        ),
        CustomTextField(
          controller: getController('guias turisticos'),
          name: "categoria/tipo/classificação/número",
          validat: (p0) {},
          getValue: (p0) {
            _valoresJson['categoriaGuiasTuristicos'] = p0;
            widget.onChanged?.call(_valoresJson);
          },
        ),
        textLabel(
          name: "outros",
          fontWeight: FontWeight.bold,
        ),
        CustomTextField(
          controller: getController('outros'),
          name: "categoria/tipo/classificação/número",
          validat: (p0) {},
          getValue: (p0) {
            _valoresJson['categoriaOutros'] = p0;
            widget.onChanged?.call(_valoresJson);
          },
        ),
      ],
    );
  }
}

class TabelaGastronomiaArtesanato2 extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  TabelaGastronomiaArtesanato2({super.key});
  TextEditingController _anoAtividade = new TextEditingController();
  TextEditingController _premiacao = new TextEditingController();
  TextEditingController _outrasInformacoes = new TextEditingController();


  

  Map<String, String> getData() {
    return {
      "ano_inicio_atividade": _anoAtividade.text,
      "premiacao": _premiacao.text,
      "outras_informacoes": _outrasInformacoes.text,
    };
  }

  fillForm(String anoAtividade, String premiacao, String outrasInfo,
      ) {
    _anoAtividade.text = anoAtividade;
    _premiacao.text = premiacao;
    _outrasInformacoes.text = outrasInfo;
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Preencha o campo';
                }
                return null;
              },
              controller: _anoAtividade,
              style: const TextStyle(
                  color: Colors.black), //String? Function(String?)

              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),

                isDense: true,
                hintText: 'Ano de Inicio da Atividade',
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Preencha o campo';
                        }
                        return null;
                      },
                      
                      controller: _premiacao,
                      style: const TextStyle(
                          color: Colors.black), //String? Function(String?)

                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        isDense: true,
                        
                        hintText: 'Premiação',
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
                      keyboardType: TextInputType.numberWithOptions(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Preencha o campo';
                        }
                        return null;
                      },
                      controller: _outrasInformacoes,
                      style: const TextStyle(
                          color: Colors.black), //String? Function(String?)

                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        isDense: true,
                        hintText: 'Outras Informações',
                        
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
class TabelaGastronomiaArtesanato extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  TabelaGastronomiaArtesanato({super.key});
  TextEditingController _nomeCompleto = new TextEditingController();
  TextEditingController _atelieAberto = new TextEditingController();
  TextEditingController _enderecoController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _telefoneController = new TextEditingController();


  

  Map<String, String> getData() {
    return {
      "nome_completo": _nomeCompleto.text,
      "atelie_aberto": _atelieAberto.text,
      "endereco": _enderecoController.text,
      "telefone": _telefoneController.text,
      "email": _emailController.text,

    };
  }

  fillForm(String nomeCompleto, String atelieAberto, String endereco,
      String email, String telefone) {
    _nomeCompleto.text = nomeCompleto;
    _enderecoController.text = endereco;
    _atelieAberto.text = atelieAberto;
    _emailController.text = email;
    _telefoneController.text = telefone;
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Preencha o campo';
                }
                return null;
              },
              controller: _nomeCompleto,
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Preencha o campo';
                        }
                        return null;
                      },
                     
                      controller: _enderecoController,
                      style: const TextStyle(
                          color: Colors.black), //String? Function(String?)

                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        isDense: true,
                        
                        hintText: 'Endereço Completo do Ateliê',
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
                      keyboardType: TextInputType.numberWithOptions(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Preencha o campo';
                        }
                        return null;
                      },
                      controller: _atelieAberto,
                      style: const TextStyle(
                          color: Colors.black), //String? Function(String?)

                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        isDense: true,
                        hintText: 'Ateliê Aberto a Visitação',
                        
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Preencha o campo';
                        }
                        return null;
                      },
                      controller: _telefoneController,
                      style: const TextStyle(
                          color: Colors.black), //String? Function(String?)
                      keyboardType: TextInputType.numberWithOptions(),
                      inputFormatters: [Validators().phoneFormatter],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        isDense: true,
                        hintText: 'Telefones',
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Preencha o campo';
                        }
                        return null;
                      },
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