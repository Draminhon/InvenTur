import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/customOutro.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/customTextField.dart';

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

class DiasRow extends StatefulWidget {
  final String dayLabel;
  final double spacing;

  final Function(Map<String, dynamic>)? onChanged;
  final String? nome;
  DiasRow(
      {super.key,
      required this.dayLabel,
      required this.spacing,
      this.onChanged,
      this.nome});

  @override
  State<DiasRow> createState() => _DiasRowState();
}

class _DiasRowState extends State<DiasRow> {
  Map<String, dynamic> _valoresJson = {};

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
  TabelaHorarios({Key? key, this.onChanged}) : super(key: key);

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

class TablesInstalacoes extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  TablesInstalacoes({super.key});

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
    final Function(Map<String, dynamic>)? onChanged;
  

  Map<String, dynamic> _valoresJson = {};
  Map<String, dynamic> get valoresJson => _valoresJson;
  Map<String, TextEditingController> controllers = {};
  TabelsEquipamentoEEspaco({super.key, this.onChanged}){

      controllers.forEach((key, value) {
        print(key);
        controllers[key] = TextEditingController();
      });
    }




  void autoFillForm() {
    // Verifica se o controlador existe no Map antes de preencher
    void fillIfExists(String key, String value) {

      getController(key).text = value;

    }
fillIfExists('Municipal lei decreto nome', 'Lei Municipal Exemplo');
  fillIfExists('entidade lei decreto municipal', 'Prefeitura Municipal');
  fillIfExists('nome portaria', 'Portaria Municipal Exemplo');
  fillIfExists('entidade portaria', 'Secretaria Municipal');
  fillIfExists('nome norma ato', 'Norma Municipal Exemplo');
  fillIfExists('entidade norma ato', 'Câmara Municipal');
  fillIfExists('nomeOutrosMunicipal', 'Outros Exemplo Municipal');
  fillIfExists('entidade outros', 'Entidade Municipal');

  fillIfExists('EstadualDistrital lei decreto nome', 'Lei Estadual/Distrital Exemplo');
  fillIfExists('entidade lei decreto EstadualDistrital', 'Governo Estadual');
  fillIfExists('entidadePortariaInstrucaoEstadualDistrital', 'Portaria Estadual Exemplo');
  fillIfExists('entidadePortariaEstadualDistrital', 'Secretaria Estadual');
  fillIfExists('nomeNormaAtoEstadualDistrital', 'Norma Estadual Exemplo');
  fillIfExists('entidadeNormaAtoEstadualDistrital', 'Assembleia Legislativa');
  fillIfExists('nomeOutrosEstadualDistrital', 'Outros Exemplo Estadual');
  fillIfExists('entidadeOutrosEstadualDistrital', 'Entidade Estadual');

  fillIfExists('Federal lei decreto nome', 'Lei Federal Exemplo');
  fillIfExists('entidade lei decreto Federal', 'Governo Federal');
  fillIfExists('entidadePortariaInstrucaoFederal', 'Portaria Federal Exemplo');
  fillIfExists('entidadePortariaFederal', 'Ministério Federal');
  fillIfExists('nomeNormaAtoFederal', 'Norma Federal Exemplo');
  fillIfExists('entidadeNormaAtoFederal', 'Congresso Nacional');
  fillIfExists('nomeOutrosFederal', 'Outros Exemplo Federal');
  fillIfExists('entidadeOutrosFederal', 'Entidade Federal');

  fillIfExists('Internacional lei decreto nome', 'Lei Internacional Exemplo');
  fillIfExists('entidade lei decreto Internacional', 'Organização Internacional');
  fillIfExists('entidadePortariaInstrucaoInternacional', 'Portaria Internacional Exemplo');
  fillIfExists('entidadePortariaInternacional', 'Entidade Internacional');
  fillIfExists('nomeNormaAtoInternacional', 'Norma Internacional Exemplo');
  fillIfExists('entidadeNormaAtoInternacional', 'Organização Internacional');
  fillIfExists('nomeOutrosInternacional', 'Outros Exemplo Internacional');
  fillIfExists('entidadeOutrosInternacional', 'Entidade Internacional');

  fillIfExists('outras nome', 'Outras Exemplo');
  fillIfExists('outras lei decreto nome', 'Lei/Decreto Outras Exemplo');
  fillIfExists('entidade lei decreto Outras', 'Entidade Outras');
  }

  TextEditingController getController(String key) {
    controllers[key] ??= TextEditingController();
    return controllers[key]!;
  }

  @override
  Widget build(BuildContext context) {
    autoFillForm();
    // TODO: implement build
    return  Column(
        children: [
          //Municipal

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
              onChanged?.call(_valoresJson);
            },
          ),
          CustomTextField(
            controller: getController('entidade lei decreto municipal'),
            name: 'entidade declaratória/tipo de declaração',
            validat: (p0) {},
            getValue: (p0) {
              _valoresJson['entidadeLeiDecretoMunicipal'] = p0;
              onChanged?.call(_valoresJson);
            },
          ),
          textLabel(
              name: 'portaria/instrução/deliberação',
              fontWeight: FontWeight.bold),
          CustomTextField(
            controller: getController('nome portaria'),
            name: 'nome/titulo/certificação/licenciamento/outro',
            validat: (p0) {},
            getValue: (p0) {
              _valoresJson['entidadePortariaInstrucaoMunicipal'] = p0;
              onChanged?.call(_valoresJson);
            },
          ),
          CustomTextField(
            controller: getController('entidade portaria'),
            name: 'entidade declaratória/tipo de declaração',
            validat: (p0) {},
            getValue: (p0) {
              _valoresJson['entidadePortariaMunicipal'] = p0;
              onChanged?.call(_valoresJson);
            },
          ),
          textLabel(name: 'norma/ato', fontWeight: FontWeight.bold),
          CustomTextField(
            controller: getController('nome norma ato'),
            name: 'nome/titulo/certificação/licenciamento/outro',
            validat: (p0) {},
            getValue: (p0) {
              _valoresJson['nomeNormaAtoMunicipal'] = p0;
              onChanged?.call(_valoresJson);
            },
          ),
          CustomTextField(
            controller: getController('entidade norma ato'),
            name: 'entidade declaratória/tipo de declaração',
            validat: (p0) {},
            getValue: (p0) {
              _valoresJson['entidadeNormaAtoMunicipal'] = p0;
              onChanged?.call(_valoresJson);
            },
          ),
          textLabel(name: 'outros', fontWeight: FontWeight.bold),
          CustomTextField(
            controller: getController('nomeOutrosMunicipal'),
            name: 'nome/titulo/certificação/licenciamento/outro',
            validat: (p0) {},
            getValue: (p0) {
              _valoresJson['nomeOutrosMunicipal'] = p0;
              onChanged?.call(_valoresJson);
            },
          ),
          CustomTextField(
            controller: getController('entidade outros'),
            name: 'entidade declaratória/tipo de declaração',
            validat: (p0) {},
            getValue: (p0) {
              _valoresJson['entidadeOutrosMunicipal'] = p0;
              onChanged?.call(_valoresJson);
            },
          ),

          //Estadual/Distrital
SizedBox(height: 50.h,),
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
              onChanged?.call(_valoresJson);
            },
          ),
          CustomTextField(
            controller: getController('entidade lei decreto EstadualDistrital'),
            name: 'entidade declaratória/tipo de declaração',
            validat: (p0) {},
            getValue: (p0) {
              _valoresJson['entidadeLeiDecretoEstadualDistrital'] = p0;
              onChanged?.call(_valoresJson);
            },
          ),
          textLabel(
              name: 'portaria/instrução/deliberação',
              fontWeight: FontWeight.bold),
          CustomTextField(
            controller: getController('nome portaria'),
            name: 'nome/titulo/certificação/licenciamento/outro',
            validat: (p0) {},
            getValue: (p0) {
              _valoresJson['entidadePortariaInstrucaoEstadualDistrital'] = p0;
              onChanged?.call(_valoresJson);
            },
          ),
          CustomTextField(
            controller: getController('entidade portaria'),
            name: 'entidade declaratória/tipo de declaração',
            validat: (p0) {},
            getValue: (p0) {
              _valoresJson['entidadePortariaEstadualDistrital'] = p0;
              onChanged?.call(_valoresJson);
            },
          ),
          textLabel(name: 'norma/ato', fontWeight: FontWeight.bold),
          CustomTextField(
            controller: getController('nome norma ato'),
            name: 'nome/titulo/certificação/licenciamento/outro',
            validat: (p0) {},
            getValue: (p0) {
              _valoresJson['nomeNormaAtoEstadualDistrital'] = p0;
              onChanged?.call(_valoresJson);
            },
          ),
          CustomTextField(
            controller: getController('entidade norma ato'),
            name: 'entidade declaratória/tipo de declaração',
            validat: (p0) {},
            getValue: (p0) {
              _valoresJson['entidadeNormaAtoEstadualDistrital'] = p0;
              onChanged?.call(_valoresJson);
            },
          ),
          textLabel(name: 'outros', fontWeight: FontWeight.bold),
          CustomTextField(
            controller: getController('nomeOutrosEstadualDistrital'),
            name: 'nome/titulo/certificação/licenciamento/outro',
            validat: (p0) {},
            getValue: (p0) {
              _valoresJson['nomeOutrosEstadualDistrital'] = p0;
              onChanged?.call(_valoresJson);
            },
          ),
          CustomTextField(
            controller: getController('entidade outros'),
            name: 'entidade declaratória/tipo de declaração',
            validat: (p0) {},
            getValue: (p0) {
              _valoresJson['entidadeOutrosEstadualDistrital'] = p0;
              onChanged?.call(_valoresJson);
            },
          ),

          //Federal
           SizedBox(height: 50.h),
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
              onChanged?.call(_valoresJson);
            },
          ),
          CustomTextField(
            controller: getController('entidade lei decreto Federal'),
            name: 'entidade declaratória/tipo de declaração',
            validat: (p0) {},
            getValue: (p0) {
              _valoresJson['entidadeLeiDecretoFederal'] = p0;
              onChanged?.call(_valoresJson);
            },
          ),
          textLabel(
              name: 'portaria/instrução/deliberação',
              fontWeight: FontWeight.bold),
          CustomTextField(
            controller: getController('nome portaria'),
            name: 'nome/titulo/certificação/licenciamento/outro',
            validat: (p0) {},
            getValue: (p0) {
              _valoresJson['entidadePortariaInstrucaoFederal'] = p0;
              onChanged?.call(_valoresJson);
            },
          ),
          CustomTextField(
            controller: getController('entidade portaria'),
            name: 'entidade declaratória/tipo de declaração',
            validat: (p0) {},
            getValue: (p0) {
              _valoresJson['entidadePortariaFederal'] = p0;
              onChanged?.call(_valoresJson);
            },
          ),
          textLabel(name: 'norma/ato', fontWeight: FontWeight.bold),
          CustomTextField(
            controller: getController('nome norma ato'),
            name: 'nome/titulo/certificação/licenciamento/outro',
            validat: (p0) {},
            getValue: (p0) {
              _valoresJson['nomeNormaAtoFederal'] = p0;
              onChanged?.call(_valoresJson);
            },
          ),
          CustomTextField(
            controller: getController('entidade norma ato'),
            name: 'entidade declaratória/tipo de declaração',
            validat: (p0) {},
            getValue: (p0) {
              _valoresJson['entidadeNormaAtoFederal'] = p0;
              onChanged?.call(_valoresJson);
            },
          ),
          textLabel(name: 'outros', fontWeight: FontWeight.bold),
          CustomTextField(
            controller: getController('nomeOutrosFederal'),
            name: 'nome/titulo/certificação/licenciamento/outro',
            validat: (p0) {},
            getValue: (p0) {
              _valoresJson['nomeOutrosFederal'] = p0;
              onChanged?.call(_valoresJson);
            },
          ),
          CustomTextField(
            controller: getController('entidade outros'),
            name: 'entidade declaratória/tipo de declaração',
            validat: (p0) {},
            getValue: (p0) {
              _valoresJson['entidadeOutrosFederal'] = p0;
              onChanged?.call(_valoresJson);
            },
          ),
          //Estadual/Distrital - Internacional


  SizedBox(height: 50.h,),
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
              onChanged?.call(_valoresJson);
            },
          ),
          CustomTextField(
            controller: getController('entidade lei decreto Internacional'),
            name: 'entidade declaratória/tipo de declaração',
            validat: (p0) {},
            getValue: (p0) {
              _valoresJson['entidadeLeiDecretoInternacional'] = p0;
              onChanged?.call(_valoresJson);
            },
          ),
          textLabel(
              name: 'portaria/instrução/deliberação',
              fontWeight: FontWeight.bold),
          CustomTextField(
            controller: getController('nome portaria'),
            name: 'nome/titulo/certificação/licenciamento/outro',
            validat: (p0) {},
            getValue: (p0) {
              _valoresJson['entidadePortariaInstrucaoInternacional'] = p0;
              onChanged?.call(_valoresJson);
            },
          ),
          CustomTextField(
            controller: getController('entidade portaria'),
            name: 'entidade declaratória/tipo de declaração',
            validat: (p0) {},
            getValue: (p0) {
              _valoresJson['entidadePortariaInternacional'] = p0;
              onChanged?.call(_valoresJson);
            },
          ),
          textLabel(name: 'norma/ato', fontWeight: FontWeight.bold),
          CustomTextField(
            controller: getController('nome norma ato'),
            name: 'nome/titulo/certificação/licenciamento/outro',
            validat: (p0) {},
            getValue: (p0) {
              _valoresJson['nomeNormaAtoInternacional'] = p0;
              onChanged?.call(_valoresJson);
            },
          ),
          CustomTextField(
            controller: getController('entidade norma ato'),
            name: 'entidade declaratória/tipo de declaração',
            validat: (p0) {},
            getValue: (p0) {
              _valoresJson['entidadeNormaAtoInternacional'] = p0;
              onChanged?.call(_valoresJson);
            },
          ),
          textLabel(name: 'outros', fontWeight: FontWeight.bold),
          CustomTextField(
            controller: getController('nomeOutrosInternacional'),
            name: 'nome/titulo/certificação/licenciamento/outro',
            validat: (p0) {},
            getValue: (p0) {
              _valoresJson['nomeOutrosInternacional'] = p0;
              onChanged?.call(_valoresJson);
            },
          ),
          CustomTextField(
            controller: getController('entidade outros'),
            name: 'entidade declaratória/tipo de declaração',
            validat: (p0) {},
            getValue: (p0) {
              _valoresJson['entidadeOutrosInternacional'] = p0;
              onChanged?.call(_valoresJson);
            },
          ),



      //Outras


      SizedBox(height: 50.h,),
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
              onChanged?.call(_valoresJson);
            },
          ),
          CustomTextField(
            controller: getController('outras lei decreto nome'),
            name: 'nome/titulo/certificação/licenciamento/outro',
            validat: (p0) {},
            getValue: (p0) {
              _valoresJson['nomeLeiDecretoOutras'] = p0;
              onChanged?.call(_valoresJson);
            },
          ),
          CustomTextField(
            controller: getController('entidade lei decreto Outras'),
            name: 'entidade declaratória/tipo de declaração',
            validat: (p0) {},
            getValue: (p0) {
              _valoresJson['entidadeLeiDecretoOutras'] = p0;
              onChanged?.call(_valoresJson);
            },
          ),

        ],
      );
  }
}

class TableMtur extends StatelessWidget {
  String? associacao_e_sindicato;
  Map<String, dynamic> _valoresJson = {};
  final Function(Map<String, dynamic>)? onChanged;
  Map<String, dynamic> get valoresJson => _valoresJson;
  Map<String, TextEditingController> controllers = {};

  TableMtur({super.key, this.associacao_e_sindicato, this.onChanged}) {
    // Inicialize todos os controladores aqui
    controllers['CADASTUR'] = TextEditingController();
    controllers['MTUR Outros'] = TextEditingController();
    controllers['associação e sindicatos do setor de alimentação'] =
        TextEditingController();
    controllers['associações de turismo'] = TextEditingController();
    controllers['associações comerciais'] = TextEditingController();
    controllers['guias turisticos'] = TextEditingController();
    controllers['outros'] = TextEditingController();
  }

  void autoFillForm() {
    // Verifica se o controlador existe no Map antes de preencher
    void fillIfExists(String key, String value) {
      if (controllers.containsKey(key)) {
        controllers[key]!.text = value;
      }
    }

    // Preenche os valores dos controladores
    fillIfExists('CADASTUR', 'CADASTUR exemplo');
    fillIfExists('MTUR Outros', 'mtur EXEMPLO');
    fillIfExists('associação e sindicatos do setor de alimentação',
        'associações exemplo');
    fillIfExists('associações de turismo', 'associações de turismo exemplo');
    fillIfExists('associações comerciais', 'associaçoes comerciais exemplo');
    fillIfExists('guias turisticos', 'guias turisticos exemplo');
    fillIfExists('outros', 'outros exemplo');
  }

  TextEditingController getController(String key) {
    controllers[key] ??= TextEditingController();
    return controllers[key]!;
  }

  @override
  Widget build(BuildContext context) {
    autoFillForm();
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
            onChanged?.call(_valoresJson);
          },
        ),
        CustomTextField(
          controller: getController('MTUR Outros'),
          name: "outros",
          validat: (p0) {},
          getValue: (p0) {
            _valoresJson['MturOutros'] = p0;
            onChanged?.call(_valoresJson);
          },
        ),
        textLabel(
          name: associacao_e_sindicato?.isEmpty ?? true
              ? 'associações e sindicatos do setor de hospedagem'
              : associacao_e_sindicato!,
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
            onChanged?.call(_valoresJson);
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
            onChanged?.call(_valoresJson);
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
            onChanged?.call(_valoresJson);
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
            onChanged?.call(_valoresJson);
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
            onChanged?.call(_valoresJson);
          },
        ),
      ],
    );
  }
}
