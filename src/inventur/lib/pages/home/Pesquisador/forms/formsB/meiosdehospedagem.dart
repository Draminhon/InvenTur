import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:inventur/pages/home/Pesquisador/forms/formsB/widgets/checkBox.dart';
import 'package:inventur/pages/home/Pesquisador/forms/formsB/widgets/tabela.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/container_form.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/customOutro.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/customTextField.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/expandedTileYoN.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/radioButton.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/sizedBox.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/customOutro.dart';

class MeiosDeHospedagem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 55, 111, 60),
        title: const Text(
          'Identificação',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView(children: [
        Padding(
            padding: EdgeInsets.only(
                top: sizeScreen.height * 0.05, left: sizeScreen.width * 0.05),
            child: Row(
              children: [
                SizedBox(
                    width: sizeScreen.width * 0.3,
                    height: sizeScreen.height * 0.045,
                    child: const TextField(
                      decoration: InputDecoration(
                        hintText: 'UF',
                      ),
                    )),
                SizedBox(
                  width: sizeScreen.width * 0.09,
                ),
                SizedBox(
                    width: sizeScreen.width * 0.5,
                    height: sizeScreen.height * 0.045,
                    child: const TextField(
                      decoration: InputDecoration(hintText: 'Região Turística'),
                    ))
              ],
            )),
        Padding(
            padding: EdgeInsets.only(
                left: sizeScreen.width * 0.05,
                right: sizeScreen.width * 0.1,
                top: sizeScreen.height * 0.01),
            child: const TextField(
              decoration: InputDecoration(hintText: 'Município'),
            )),
        Padding(
            padding: EdgeInsets.only(top: sizeScreen.height * 0.05),
            child: Text(
              'TIPO',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: sizeScreen.width * 0.045),
            )),
        Padding(
            padding: EdgeInsets.only(left: sizeScreen.width * 0.12),
            child: const RadioB(),),
        Padding(
            padding: EdgeInsets.only(top: sizeScreen.height * 0.03),
            child: Text(
              'SUBTIPOS',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: sizeScreen.width * 0.045),
            )),
     
        const RadioC(number: 18, options: [
          'Hotel',
          'Hotel histórico',
          'Pousada',
          'Resort',
          'Hotel Fazenda',
          'Flat/apart-hotel',
          'Cama e café',
          'Albergue',
          'Motel',
          'Pensão',
          'Alojamento de floresta',
          'Colônia de férias',
          'Estalagem/ Hospedaria',
          'Alojamento Coletivo',
          'Hospedagem conventual (Mosteiro/Seminário/Convento',
          'Hospedagem Familiar',
          'Hotel de trânsito',
          'Spa'
        ]),

          SizedBox(height: sizeScreen.height * 0.05,),

        Container(
          color: const Color.fromARGB(255, 55, 111, 60),
          height: sizeScreen.height * 0.06,
          padding: EdgeInsets.only(
              top: sizeScreen.height * 0.008, left: sizeScreen.width * 0.04),
          child: Text(
            'Informações Gerais',
            style: TextStyle(
                color: Colors.white, fontSize: sizeScreen.height * 0.03),
          ),
        ),
        
        const CustomTextField(
          name: 'Razão Social',
        ),
        const CustomTextField(name: 'Nome Fantasia'),
        const CustomTextField(name: 'Código CNAE'),
        const CustomTextField(name: 'Atividade econômica'),
        const CustomTextField(name: 'Inscrição Municipal'),
        const CustomTextField(name: 'Nome da rede/holding'),
        const CustomTextField(name: 'CNPJ'),
        const textLabel(name: 'natureza'),
        Padding(
            padding: EdgeInsets.only(right: sizeScreen.width * 0.5),
            child: const Column(
              children: [
                RadioD(
                  options: ['pública', 'privada', 'outro'],
                  number: 3,
                ),
              ],
            )),
        const textLabel(
          name: 'tipo de organização/instituição',
        ),
        Padding(
            padding: EdgeInsets.only(right: sizeScreen.width * 0.2),
            child: const RadioD(
              options: [
                'associação',
                'sindicato',
                'cooperativa',
                'sistema S',
                'empresa',
                'outro'
              ],
              number: 6,
            )),
        Row(
          children: [
            const textLabel(name: 'início da atividade:'),
            SizedBox(
              width: sizeScreen.width * 0.1,
            ),
            SizedBox(
                width: sizeScreen.width * 0.4,
                height: sizeScreen.height * 0.07,
                child: const CustomTextDate())
          ],
        ),
        SizedBox(
          height: sizeScreen.height * 0.03,
        ),
        const textLabel(name: 'Quantidade de Funcionários'),
        Column(
          children: [
            Row(
              children: [
                const textLabel(name: 'Permanentes'),
                SizedBox(
                  width: sizeScreen.width * 0.026,
                ),
                SizedBox(
                    width: sizeScreen.width * 0.6,
                    height: sizeScreen.height * 0.07,
                    child: const CustomTextField(
                      name: '',
                    ))
              ],
            ),
            Row(
              children: [
                const textLabel(name: 'Temporários'),
                SizedBox(
                  width: sizeScreen.width * 0.038,
                ),
                SizedBox(
                    width: sizeScreen.width * 0.6,
                    height: sizeScreen.height * 0.07,
                    child: const CustomTextField(
                      name: '',
                    ))
              ],
            ),
            Row(
              children: [
                const textLabel(name: 'Pessoas com\ndefiicência (%)'),
                SizedBox(
                    width: sizeScreen.width * 0.6,
                    height: sizeScreen.height * 0.07,
                    child: const CustomTextField(
                      name: '',
                    ))
              ],
            ),
          ],
        ),
        const textLabel(name: 'localização:'),
        const RadioD(number: 2, options: ['urbana', 'rural']),
        const textLabel(name: 'Coordenadas Geográficas'),
        Column(children: [
          Row(
            children: [
              const textLabel(name: 'Latitude'),
              SizedBox(
                width: sizeScreen.width * 0.032,
              ),
              SizedBox(
                  width: sizeScreen.width * 0.6,
                  height: sizeScreen.height * 0.07,
                  child: const CustomTextField(
                    name: '',
                  ))
            ],
          ),
          Row(
            children: [
              const textLabel(name: 'Longitude'),
              SizedBox(
                  width: sizeScreen.width * 0.6,
                  height: sizeScreen.height * 0.07,
                  child: const CustomTextField(
                    name: '',
                  ))
            ],
          ),
        ]),
        const textLabel(name: 'endereço:'),
        const CustomTextField(
          name: 'avenida/rua/travessa/caminho/outro',
        ),
        const CustomTextField(
          name: 'bairro/localidade',
        ),
        const CustomTextField(
          name: 'distrito',
        ),
        const CustomTextField(
          name: 'CEP',
        ),
        Column(children: [
          Row(
            children: [
              const textLabel(name: 'Telefone'),
              SizedBox(
                width: sizeScreen.width * 0.03,
              ),
              SizedBox(
                  width: sizeScreen.width * 0.6,
                  height: sizeScreen.height * 0.07,
                  child: const CustomTextField(
                    name: '',
                  ))
            ],
          ),
          Padding(
              padding: EdgeInsets.only(left: sizeScreen.width * 0.08),
              child: SizedBox(
                  width: sizeScreen.width * 0.6,
                  height: sizeScreen.height * 0.07,
                  child: const CustomTextField(name: ''))),
          Row(
            children: [
              const textLabel(name: 'Endereço eletrônico\n        (e-mail)'),
              SizedBox(
                  width: sizeScreen.width * 0.5,
                  height: sizeScreen.height * 0.07,
                  child: const CustomTextField(
                    name: '',
                  ))
            ],
          ),
          Row(
            children: [
              const textLabel(name: '  Sítio eletrônico\n(site/página web)'),
              SizedBox(
                width: sizeScreen.width * 0.045,
              ),
              SizedBox(
                  width: sizeScreen.width * 0.5,
                  height: sizeScreen.height * 0.07,
                  child: const CustomTextField(
                    name: '',
                  ))
            ],
          ),
        ]),
        const textLabel(name: 'sinalização:'),
        Row(children: [
          const textLabel(name: 'de acessso -'),
          SizedBox(
            width: sizeScreen.width * 0.04,
          ),
          const SizedBox(
              // width: sizeScreen.width * 0.5,
              //    height: sizeScreen.height * 0.07,
              child: ExpansionTileYoN())
        ]),
        SizedBox(
          height: sizeScreen.height * 0.01,
        ),
        Row(children: [
          const textLabel(name: 'turística -'),
          SizedBox(
            width: sizeScreen.width * 0.09,
          ),
          const SizedBox(
              //width: sizeScreen.width * 0.5,
              //    height: sizeScreen.height * 0.07,
              child: ExpansionTileYoN())
        ]),
        const textLabel(name: 'proximidades:'),
        //  RadioD(number: 6, options: options)
        const RadioD(number: 7, options: [
          'Restaurante',
          'Centro de Convenções exposições',
          'Shopping',
          'Bar/Lanchconete',
          'Posto de combustível',
          'Galeria/rua comercial',
          'outro'
        ]),
        const textLabel(name: 'pontos de referência:'),
        const CustomTextField(name: 'ponto de referência'),
        SizedBox(height: sizeScreen.height * 0.1,),
        
         Container(
          color: const Color.fromARGB(255, 55, 111, 60),
          height: sizeScreen.height * 0.06,
          padding: EdgeInsets.only(
              top: sizeScreen.height * 0.008, left: sizeScreen.width * 0.04),
          child: Text(
            'Cadastro, classificação e outros',
            style: TextStyle(
                color: Colors.white, fontSize: sizeScreen.height * 0.03),
          ),
        ),
        SizedBox(height: sizeScreen.height * 0.05,),
       
        Tabela(),
         SizedBox(height: sizeScreen.height * 0.05,),
  Padding(padding: EdgeInsets.only(left: sizeScreen.width * 0.05), child: 
        textLabel(name: '       Segmentos ou tipos de turismo\nem que é especializado (assinalar até 3)')
     ),
      SizedBox(height: sizeScreen.height * 0.05,),
      CheckB(nomes: ['Aventura', 'Ecoturismo', 'Rural', 'Estudos e intercâmbio', 'Cultural\n(cívico, étnico,\nreligioso, místico e\nesotérico)', 'náutico', 'Saúde\n(Bem estar e médico)', 'Pesca', 'Sol e praia', 'Negócios e\eventos', 'Esporte', 'Não é\nespecializado em nenhum segmento'],)
      ,SizedBox(height: sizeScreen.height * 0.05,),
      Container(
          color: const Color.fromARGB(255, 55, 111, 60),
          height: sizeScreen.height * 0.06,
          padding: EdgeInsets.only(
              top: sizeScreen.height * 0.008, left: sizeScreen.width * 0.04),
          child: Text(
            'Funcionamento',
            style: TextStyle(
                color: Colors.white, fontSize: sizeScreen.height * 0.03),
          ),
        ),
      ]),
    );
  }
}
