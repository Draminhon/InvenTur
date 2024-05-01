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
          child: const RadioB(),
        ),
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

        SizedBox(
          height: sizeScreen.height * 0.05,
        ),

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
      const Column(
              children: [
                RadioD(
                  options: ['pública', 'privada', 'outro'],
                ),
              ],
            ),
        const textLabel(
          name: 'tipo de organização/instituição',
        ),
       const RadioD(
              options: [
                'associação',
                'sindicato',
                'cooperativa',
                'sistema S',
                'empresa',
                'outro'
              ],
            ),
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
        const RadioD(options: ['urbana', 'rural']),
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
        const RadioD(options: [
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
        SizedBox(
          height: sizeScreen.height * 0.1,
        ),

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
        SizedBox(
          height: sizeScreen.height * 0.05,
        ),

        const TabelaT1(column01: [
          Text('Entidade/guia turístico'),
          Text(
            'Associações e sindicatos do setor de hospedagem',
          ),
          Text('Associações de turismos'),
          Text('Associações comerciais'),
          Text('Guias Turísticos'),
          Text('Outros'),
        ], column02: [
          Text('Categoria/tipo/classificação/número'),
          Text('CADASTUR outros'),
          TextField(
            decoration: InputDecoration(border: InputBorder.none),
          ),
          TextField(
            decoration: InputDecoration(border: InputBorder.none),
          ),
          TextField(
            decoration: InputDecoration(border: InputBorder.none),
          ),
          TextField(
            decoration: InputDecoration(border: InputBorder.none),
          ),
          TextField(
            decoration: InputDecoration(border: InputBorder.none),
          ),
        ]),
        SizedBox(
          height: sizeScreen.height * 0.05,
        ),
        Padding(
            padding: EdgeInsets.only(left: sizeScreen.width * 0.05),
            child: const textLabel(
                name:
                    '       Segmentos ou tipos de turismo\nem que é especializado (assinalar até 3)')),
        SizedBox(
          height: sizeScreen.height * 0.05,
        ),
        const CheckB(
          nomes: [
            'Aventura',
            'Ecoturismo',
            'Rural',
            'Estudos e intercâmbio',
            'Cultural\n(cívico, étnico,\nreligioso, místico e\nesotérico)',
            'náutico',
            'Saúde\n(Bem estar e médico)',
            'Pesca',
            'Sol e praia',
            'Negócios e\eventos',
            'Esporte',
            'Não é\nespecializado em nenhum segmento'
          ],
        ),
        SizedBox(
          height: sizeScreen.height * 0.05,
        ),
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

        const textLabel(name: 'Estrutura de Funcionamento'),
        Padding(
          padding: EdgeInsets.only(
              left: sizeScreen.width * 0.3, top: sizeScreen.height * 0.02),
          child: const textLabel(name: 'Tipo de diária'),
        ),
        SizedBox(
          height: sizeScreen.height * 0.03,
        ),
        const RadioC(number: 5, options: [
          'Sem Alimentação',
          'Café da manhã',
          'Meia Pensão',
          'Pensão Completa',
          'Tudo incluído'
        ]),
        Padding(
          padding: EdgeInsets.only(
              left: sizeScreen.width * 0.24,
              top: sizeScreen.height * 0.02,
              bottom: sizeScreen.height * 0.02),
          child: const textLabel(name: 'Formas de Pagamento'),
        ),
        const RadioC(
          number: 5,
          options: [
            'Dinheiro',
            'Cheque',
            'Cheque de outra praça',
            'Cartão de Crédito',
            'Cartão de Débito'
          ],
        ),
        Padding(
          padding: EdgeInsets.only(
              left: sizeScreen.width * 0.35,
              top: sizeScreen.height * 0.02,
              bottom: sizeScreen.height * 0.02),
          child: const textLabel(name: 'Reservas'),
        ),
        const RadioC(
          number: 7,
          options: [
            'Balcão',
            'Telefone',
            'Fax',
            'Internet',
            'Agência de turismo',
            'Com sinal',
            'Antecipado'
          ],
        ),
        Padding(
          padding: EdgeInsets.only(
              left: sizeScreen.width * 0.2,
              top: sizeScreen.height * 0.02,
              bottom: sizeScreen.height * 0.02),
          child: const textLabel(name: 'Atendimento ao Público'),
        ),
        Padding(
          padding: EdgeInsets.only(
              left: sizeScreen.width * 0.11,
              top: sizeScreen.height * 0.02,
              bottom: sizeScreen.height * 0.02),
          child: const textLabel(name: 'Atendimento em língua estrangeira'),
        ),
        const RadioD(options: ['Não', 'Inglês', 'Espanhol', 'outro']),
        Padding(
          padding: EdgeInsets.only(
              left: sizeScreen.width * 0.11,
              top: sizeScreen.height * 0.02,
              bottom: sizeScreen.height * 0.02),
          child: const textLabel(name: 'Informativos impressos'),
        ),
        const RadioD(
            options: ['Não', 'Inglês', 'Espanhol', 'Português', 'outro']),
        SizedBox(
          height: sizeScreen.height * 0.05,
        ),
        Container(
          color: const Color.fromARGB(255, 55, 111, 60),
          height: sizeScreen.height * 0.06,
          padding: EdgeInsets.only(
              top: sizeScreen.height * 0.008, left: sizeScreen.width * 0.04),
          child: Text(
            'Regras de Funcionamento',
            style: TextStyle(
                color: Colors.white, fontSize: sizeScreen.height * 0.03),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              left: sizeScreen.width * 0.35,
              top: sizeScreen.height * 0.02,
              bottom: sizeScreen.height * 0.02),
          child: const textLabel(name: 'Período'),
        ),
        const RadioC(number: 13, options: [
          'Janeiro',
          'Fevereiro',
          'Março',
          'Abril',
          'Maio',
          'Junho',
          'Julho',
          'Agosto',
          'Setembro',
          'Outubro',
          'Novembro',
          'Dezembro',
          'Ano Inteiro'
        ]),
        Padding(
          padding: EdgeInsets.only(
              left: sizeScreen.width * 0.35,
              top: sizeScreen.height * 0.02,
              bottom: sizeScreen.height * 0.02),
          child: const textLabel(name: 'Horário'),
        ),
        TabelaT2(),
        SizedBox(
          height: sizeScreen.height * 0.05,
        ),
        Padding(
          padding: EdgeInsets.only(
              left: sizeScreen.width * 0.2,
              top: sizeScreen.height * 0.02,
              bottom: sizeScreen.height * 0.02),
          child: const textLabel(name: 'Funcionamento 24 horas'),
        ),
        const RadioD(options: ['Sim', 'Não']),
        Padding(
          padding: EdgeInsets.only(
              left: sizeScreen.width * 0.16,
              top: sizeScreen.height * 0.02,
              bottom: sizeScreen.height * 0.02),
          child: const textLabel(name: 'Funcionamento em feriados'),
        ),
        const RadioD(options: ['Sim', 'Não']),
        Padding(
          padding: EdgeInsets.only(
              left: sizeScreen.width * 0.2,
              top: sizeScreen.height * 0.02,
              bottom: sizeScreen.height * 0.02),
          child: const textLabel(name: 'Restrições'),
        ),
        const RadioD(options: ['Crianças', 'Fumantes', 'Animais', 'outro']),
        const textLabel(name: 'Outras regras e informações'),
        const CustomTextField(name: ''),
        const textLabel(name: 'Dados da Visitação'),
        const textLabel(name: 'Ocupação ano nº'),
        const CustomTextField(name: ''),
        const textLabel(name: 'Ocupação na alta temporada nº'),
        const CustomTextField(name: ''),
        const textLabel(name: 'Meses de alta temporada'),

        const RadioC(number: 13, options: [
          'Janeiro',
          'Fevereiro',
          'Março',
          'Abril',
          'Maio',
          'Junho',
          'Julho',
          'Agosto',
          'Setembro',
          'Outubro',
          'Novembro',
          'Dezembro',
          'Ano Inteiro'
        ]),
        const textLabel(name: 'Origem dos visitantes/turistas'),
        const RadioD(options: [
          'Entorno municipal',
          'Estadual',
          'Nacional',
          'Internacional'
        ]),
        const textLabel(name: 'Origem dos turistas nacionais (Até 5 estados)'),
        const CustomTextField(name: '1'),
        const CustomTextField(name: '2'),
        const CustomTextField(name: '3'),
        const CustomTextField(name: '4'),
        const CustomTextField(name: '5'),
        const textLabel(
            name: 'Origem dos turistas internacionais (Até 5 Países)'),
        const CustomTextField(name: '1'),
        const CustomTextField(name: '2'),
        const CustomTextField(name: '3'),
        const CustomTextField(name: '4'),
        const CustomTextField(name: '5'),
        const textLabel(name: 'Ano base'),
        const CustomTextField(name: ''),
        SizedBox(
          height: sizeScreen.height * 0.05,
        ),
        Container(
          color: const Color.fromARGB(255, 55, 111, 60),
          height: sizeScreen.height * 0.06,
          padding: EdgeInsets.only(
              top: sizeScreen.height * 0.008, left: sizeScreen.width * 0.04),
          child: Text(
            'Características',
            style: TextStyle(
                color: Colors.white, fontSize: sizeScreen.height * 0.03),
          ),
        ),

        Padding(
          padding: EdgeInsets.only(
              left: sizeScreen.width * 0.17,
              top: sizeScreen.height * 0.02,
              bottom: sizeScreen.height * 0.02),
          child: const textLabel(name: 'Unidades habitacionais (UH)'),
        ),

        Column(children: [
          Row(
            children: [
              const textLabel(name: 'Total de UH nº'),
              SizedBox(
                width: sizeScreen.width * 0.055,
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
              const textLabel(name: 'Total de leitos nº'),
              SizedBox(
                width: sizeScreen.width * 0.005,
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
              const textLabel(name: 'Uh adaptadas\npara PCD nº'),
              SizedBox(
                width: sizeScreen.width * 0.071,
              ),
              SizedBox(
                  width: sizeScreen.width * 0.6,
                  height: sizeScreen.height * 0.07,
                  child: const CustomTextField(
                    name: '',
                  ))
            ],
          ),
        ]),
        Padding(
          padding: EdgeInsets.only(
              left: sizeScreen.width * 0.02,
              top: sizeScreen.height * 0.02,
              bottom: sizeScreen.height * 0.02),
          child: const textLabel(name: 'Produtos de higiene pessoal'),
        ),
        const CheckC(nomes: [
          'Shampoo',
          'Toalha',
          'Condicionador',
          'Roupão de banho',
          'Sabonete',
          'Touca',
          'Creme dental',
          'Chinelo',
          'Loção',
          'outro'
        ]),
        Padding(
          padding: EdgeInsets.only(
              left: sizeScreen.width * 0.005,
              top: sizeScreen.height * 0.02,
              bottom: sizeScreen.height * 0.02),
          child: const textLabel(name: 'Equipamentos e serviços'),
        ),
        const RadioC(number: 23, options: [
          'Aparelho de vídeo',
          'DVD',
          'TV com canal pago',
          'Rádio',
          'Internet',
          'Ar-Condicionado',
          'Calefação',
          'Mesa',
          'Cama King Size',
          'Cama Queen Size',
          'Panelas e louças',
          'Micro-ondas',
          'Forno Elétrico',
          'Cofre',
          'Academia',
          'Ofurô',
          'Hidromassagem',
          'Sauna seca',
          'Room - service',
          'Room service 24h',
          'Controle de Iluminação',
          'Luminária para leitura',
          'outro'
        ]),
        Padding(
          padding: EdgeInsets.only(
              right: sizeScreen.width * 0.05,
              top: sizeScreen.height * 0.02,
              bottom: sizeScreen.height * 0.02),
          child: const textLabel(name: 'Instalações'),
        ),
        Padding(
          padding: EdgeInsets.only(
              left: sizeScreen.width * 0.005,
              top: sizeScreen.height * 0.02,
              bottom: sizeScreen.height * 0.02),
          child: const textLabel(name: 'Estacionamento'),
        ),
        const RadioD(
          options: ['Pago', 'Gratuito', 'Coberto', 'Descoberto'],
        ),

        Column(children: [
          Row(
            children: [
              const textLabel(name: 'Capacidade de\nveículos nº'),
              SizedBox(
                width: sizeScreen.width * 0.01,
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
              const textLabel(name: 'Automóveis nº'),
              SizedBox(
                width: sizeScreen.width * 0.005,
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
              const textLabel(name: 'Ônibus nº'),
              SizedBox(
                width: sizeScreen.width * 0.1,
              ),
              SizedBox(
                  width: sizeScreen.width * 0.6,
                  height: sizeScreen.height * 0.07,
                  child: const CustomTextField(
                    name: '',
                  ))
            ],
          ),
        ]),
        Padding(
          padding: EdgeInsets.only(
              left: sizeScreen.width * 0.16,
              top: sizeScreen.height * 0.02,
              bottom: sizeScreen.height * 0.02),
          child: const textLabel(name: 'Outras intalações e estruturas'),
        ),
        Padding(
          padding: EdgeInsets.only(
              left: sizeScreen.width * 0.29,
              top: sizeScreen.height * 0.02,
              bottom: sizeScreen.height * 0.02),
          child: const textLabel(name: 'Energia  elétrica'),
        ),
        const RadioD(options: ['110 volts', '220 volts', '110/220 volts']),
        Row(
          children: [
            const textLabel(name: 'Capacidade\n   em KVA'),
            SizedBox(
              width: sizeScreen.width * 0.005,
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
          padding: EdgeInsets.only(
              left: sizeScreen.width * 0.25,
              top: sizeScreen.height * 0.02,
              bottom: sizeScreen.height * 0.02),
          child: const textLabel(name: 'Gerador de emergência'),
        ),
        const ExpansionTileYoN(),
        Row(
          children: [
            const textLabel(name: 'Capacidade\n   em KVA'),
            SizedBox(
              width: sizeScreen.width * 0.005,
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
          padding: EdgeInsets.only(
              left: sizeScreen.width * 0.28,
              top: sizeScreen.height * 0.02,
              bottom: sizeScreen.height * 0.02),
          child: const textLabel(name: 'Área de alimentação'),
        ),
        Padding(
          padding: EdgeInsets.only(
              left: sizeScreen.width * 0.35,
              top: sizeScreen.height * 0.02,
              bottom: sizeScreen.height * 0.02),
          child: const textLabel(name: 'Restaurante'),
        ),
        const RadioD(options: [
          'Não',
          'Apenas para hóspedes',
          'Aberto ao público',
          'Adaptado para PCD'
        ]),
        Padding(
          padding: EdgeInsets.only(
              left: sizeScreen.width * 0.2,
              top: sizeScreen.height * 0.02,
              bottom: sizeScreen.height * 0.02),
          child: const textLabel(name: 'Capacidade de atendimento'),
        ),

        Column(children: [
          Row(
            children: [
              const textLabel(name: 'Capacidade\nInstalada\npor dia nº'),
              SizedBox(
                width: sizeScreen.width * 0.01,
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
              SizedBox(
                width: sizeScreen.width * 0.05,
              ),
              const textLabel(name: 'Pessoas\natendidas\nsentadas nº'),
              SizedBox(
                width: sizeScreen.width * 0.005,
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
              const textLabel(name: 'Capacidade\nsimultânea nº'),
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
              SizedBox(
                width: sizeScreen.width * 0.05,
              ),
              const textLabel(name: 'Pessoas\natendidas\nsentadas nº'),
              SizedBox(
                  width: sizeScreen.width * 0.6,
                  height: sizeScreen.height * 0.07,
                  child: const CustomTextField(
                    name: '',
                  ))
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
                right: sizeScreen.width * 0.06,
                top: sizeScreen.height * 0.02,
                bottom: sizeScreen.height * 0.02),
            child: const textLabel(name: 'Lanchonete'),
          ),
        ]),
        const RadioD(options: [
          'Não',
          'Apenas para hóspedes',
          'Aberto ao público',
          'Adaptado para PCD'
        ]),
        Column(children: [
          Row(
            children: [
              const textLabel(name: 'Capacidade\nInstalada\npor dia nº'),
              SizedBox(
                width: sizeScreen.width * 0.01,
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
              SizedBox(
                width: sizeScreen.width * 0.05,
              ),
              const textLabel(name: 'Pessoas\natendidas\nsentadas nº'),
              SizedBox(
                width: sizeScreen.width * 0.005,
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
              const textLabel(name: 'Capacidade\nsimultânea nº'),
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
              SizedBox(
                width: sizeScreen.width * 0.05,
              ),
              const textLabel(name: 'Pessoas\natendidas\nsentadas nº'),
              SizedBox(
                  width: sizeScreen.width * 0.6,
                  height: sizeScreen.height * 0.07,
                  child: const CustomTextField(
                    name: '',
                  ))
            ],
          ),
        ]),
        Padding(
          padding: EdgeInsets.only(
              left: sizeScreen.width * 0.22,
              top: sizeScreen.height * 0.02,
              bottom: sizeScreen.height * 0.02),
          child: const textLabel(
              name: 'Área de recreação e lazer\n\n   Instalações e espaços'),
        ),
        const RadioD(options: [
          'Piscina',
          'Toboágua',
          'Quadra de tênis',
          'Área verde',
          'Piscina aquecida',
          'Parque infantil',
          'Campo de futebol',
          'Lago paronâmico',
          'Piscina infantil',
          'Clube infantil',
          'Campo de golfe',
          'Bar na piscina',
          'Quadra poliesportiva',
          'Pista de cooper',
          'outro'
        ]),
        Padding(
          padding: EdgeInsets.only(
              left: sizeScreen.width * 0.2,
              top: sizeScreen.height * 0.02,
              bottom: sizeScreen.height * 0.02),
          child: const textLabel(
              name: '        Outros espaços,\nequipamentos e atividades'),
        ),
        const RadioD(options: [
          'Observação da fauna',
          'Visita a produção agrícola',
          'Atividades pedagógicas',
          'Atividades Programadas para adultos',
          'Passeios em barcos e lanchas',
          'Realização de cursos, seminários, feiras',
          'Competições de pesca',
          'Equipamento para mergulho',
          'Tirolesa',
          'Cicloturismo / Atividade com bicicleta',
          'Mergulho livre',
          'Banana boat',
          'Mini zoo',
          'Horta',
          'Peregrinação e romarias',
          'Venda de souvenir e produtos típicos',
          'Observação de flora',
          'Degustação gastronômica',
          'Atividades programadas para crianças',
          'atividades equestres',
          'Passeios em embarcações alugadas',
          'Realização de eventos (Esportivos, Sociais, Culturais)',
          'Pesca amadora',
          'Pedalinhos',
          'Arvorismo',
          'Caminhadas / trilha interpretativas',
          'Esqui aquático',
          'Jet ski',
          'Fazendinha',
          'Centro equestre',
          'Retiros espirituais',
          'outro'
        ]),
        Padding(
          padding: EdgeInsets.only(
              left: sizeScreen.width * 0.28,
              top: sizeScreen.height * 0.02,
              bottom: sizeScreen.height * 0.02),
          child: const textLabel(name: 'Área para eventos\n\n     Instalações'),
        ),
        const TabelaT3(),
        Padding(
          padding: EdgeInsets.only(
              left: sizeScreen.width * 0.35,
              top: sizeScreen.height * 0.02,
              bottom: sizeScreen.height * 0.02),
          child: const textLabel(name: 'Serviços'),
        ),
        const RadioD(options: [
          'Realização de eventos próprios',
          'Aluguel de equipamentos',
          'Aluguel de espaço para terceiros',
          'Serviços de alimentação',
          'Organização de eventos',
          'Serviços de som',
          'outro',
        ]),
        Padding(
          padding: EdgeInsets.only(
              left: sizeScreen.width * 0.3,
              top: sizeScreen.height * 0.02,
              bottom: sizeScreen.height * 0.02),
          child: const textLabel(name: 'Equipamentos'),
        ),
        const RadioD(options: [
          'Cadeira com prancheta',
          'Copa',
          'Vídeo',
          'Tela fixa',
          'Telefonia',
          'Internet sem fio',
          'Sonorização',
          'Elevador',
          'Poltronas',
          'Tv com canal aberto',
          'DVD',
          'Projetor',
          'Computador',
          'Equipamento de tradução simultânea',
          'Parabólica',
          'Ar condicionado central',
          'TV com canal por assinatura',
          'Tela móvel',
          'Retroprojetor',
          'Internet',
          'Videoconferência',
          'Palco',
          'outro'
        ]),
        Padding(
          padding: EdgeInsets.only(
              left: sizeScreen.width * 0.25,
              top: sizeScreen.height * 0.02,
              bottom: sizeScreen.height * 0.02),
          child: const textLabel(name: 'Facilidades e serviços'),
        ),
        const RadioD(options: [
          'Adaptador de voltagem',
          'Calefação',
          'Telefones públicos',
          'Impressora',
          'Micro - ondas',
          'Adega climatizada',
          'Loja de conveniência',
          'Cofre ',
          'Agência de turismo',
          'Heliponto',
          'Lavanderia',
          'Serviço de babá',
          'Auditório',
          'Sala de imprensa',
          'Salão de beleza',
          'Passeios e guias',
          'Ar condicionado',
          'Centra telefônica',
          'Internet',
          'Circuito interno de TV',
          'Churrasqueira',
          'Barbearia',
          'Farmácia',
          'Guarda - volume',
          'Locadora de veículos',
          'Embarcações',
          'Serviços de copa',
          'Serviço médico',
          'Sala de reuniões',
          'Sala de ginástica',
          'Salão de jogos',
          'Câmbio',
          'Ventilador',
          'Telefone',
          'Internet sem fio',
          'Forno elétrico',
          'Bar',
          'Lojas',
          'Caixa eletrônico',
          'Informações turísticas',
          'Traslados',
          'Manobrista',
          'Serviço bilíngue',
          'Elevador',
          'Sala de convenções',
          'Equipamento de ginástica',
          'Exposição de arte/artesanato',
          'outro'
        ]),
        Padding(
          padding: EdgeInsets.only(
              left: sizeScreen.width * 0.2,
              top: sizeScreen.height * 0.02,
              bottom: sizeScreen.height * 0.02),
          child: const textLabel(name: 'Facilidades para executivos'),
        ),
        const RadioD(options: [
          'Apartamentos em andares especiais',
          'Café da manhã em ambiente privativo',
          'Jornais diários no apartamento',
          'Acesso á internet sem fio',
          'Acesso a internet em áreas comuns',
          'Impressora',
          'Datashow',
          'Sla de reunião',
          'Serviço de café',
          'Guarda de mala em consignação',
          'Lustro e graxa para os sapatos',
          'Check in e check out expresso em ambiente diferenciado',
          'Early check in e late check out conforme disponibilidade',
          'Acesso á internet banda larga',
          'Acesso a internet na UH',
          'Computador ',
          'fax',
          'Máquina de fotocópia',
          'Serviço de chá',
          'Refrigerante / sucos',
          'Lavagem e passagem de roupa no período noturno',
          'outro'
        ]),
        Container(
          color: const Color.fromARGB(255, 55, 111, 60),
          height: sizeScreen.height * 0.15,
          padding: EdgeInsets.only(
              top: sizeScreen.height * 0.008, left: sizeScreen.width * 0.04),
          child: Text(
            'Proteção, Qualificação, Certificação, Premiação, destaques e outros',
            style: TextStyle(
                color: Colors.white, fontSize: sizeScreen.height * 0.03),
          ),
        ),
        SizedBox(
          height: sizeScreen.height * 0.05,
        ),
        Row(children: [
          const textLabel(name: 'Do equipamento/espaço:'),
          SizedBox(
            width: sizeScreen.width * 0.04,
          ),
          const SizedBox(
              // width: sizeScreen.width * 0.5,
              //    height: sizeScreen.height * 0.07,
              child: ExpansionTileYoN())
        ]),
        const TabelaT4(
          column01: [
            Text('Categoria'),
            Text('Municipal'),
            Text('Municipal'),
            Text('Municipal'),
            Text('Municipal'),
          ],
          column02: [
            Text('instrumento (nª)'),
            Text('Lei/decreto'),
            Text('Portaria/instrução/deliberação'),
            Text('Norma/ato'),
            Text('Outros'),
          ],
          column03: [
            Text('Nome/titulo/certificação/licenciamento/outro'),
            TextField(
              decoration: InputDecoration(border: InputBorder.none),
            ),
            TextField(
              decoration: InputDecoration(border: InputBorder.none),
            ),
            TextField(
              decoration: InputDecoration(border: InputBorder.none),
            ),
            TextField(
              decoration: InputDecoration(border: InputBorder.none),
            ),
          ],
          column04: [
            Text('Entidade declaratória/tipo de declaração'),
            TextField(
              decoration: InputDecoration(border: InputBorder.none),
            ),
            TextField(
              decoration: InputDecoration(border: InputBorder.none),
            ),
            TextField(
              decoration: InputDecoration(border: InputBorder.none),
            ),
            TextField(
              decoration: InputDecoration(border: InputBorder.none),
            ),
          ],
        ),
        SizedBox(
          height: sizeScreen.height * 0.05,
        ),
        const TabelaT4(
          column01: [
            Text('Estadual/Distrital'),
            Text('Estadual/Distrital'),
            Text('Estadual/Distrital'),
            Text('Estadual/Distrital'),
            Text('Estadual/Distrital'),
          ],
          column02: [
            Text('instrumento (nª)'),
            Text('Lei/decreto'),
            Text('Portaria/instrução/deliberação'),
            Text('Norma/ato'),
            Text('Outros'),
          ],
          column03: [
            Text('Nome/titulo/certificação/licenciamento/outro'),
            TextField(
              decoration: InputDecoration(border: InputBorder.none),
            ),
            TextField(
              decoration: InputDecoration(border: InputBorder.none),
            ),
            TextField(
              decoration: InputDecoration(border: InputBorder.none),
            ),
            TextField(
              decoration: InputDecoration(border: InputBorder.none),
            ),
          ],
          column04: [
            Text('Entidade declaratória/tipo de declaração'),
            TextField(
              decoration: InputDecoration(border: InputBorder.none),
            ),
            TextField(
              decoration: InputDecoration(border: InputBorder.none),
            ),
            TextField(
              decoration: InputDecoration(border: InputBorder.none),
            ),
            TextField(
              decoration: InputDecoration(border: InputBorder.none),
            ),
          ],
        ),
        SizedBox(
          height: sizeScreen.height * 0.05,
        ),
        const TabelaT4(
          column01: [
            Text('Categoria'),
            Text('Federal'),
            Text('Federal'),
            Text('Federal'),
            Text('Federal'),
          ],
          column02: [
            Text('instrumento (nª)'),
            Text('Lei/decreto'),
            Text('Portaria/instrução/deliberação'),
            Text('Norma/ato'),
            Text('Outros'),
          ],
          column03: [
            Text('Nome/titulo/certificação/licenciamento/outro'),
            TextField(
              decoration: InputDecoration(border: InputBorder.none),
            ),
            TextField(
              decoration: InputDecoration(border: InputBorder.none),
            ),
            TextField(
              decoration: InputDecoration(border: InputBorder.none),
            ),
            TextField(
              decoration: InputDecoration(border: InputBorder.none),
            ),
          ],
          column04: [
            Text('Entidade declaratória/tipo de declaração'),
            TextField(
              decoration: InputDecoration(border: InputBorder.none),
            ),
            TextField(
              decoration: InputDecoration(border: InputBorder.none),
            ),
            TextField(
              decoration: InputDecoration(border: InputBorder.none),
            ),
            TextField(
              decoration: InputDecoration(border: InputBorder.none),
            ),
          ],
        ),
        SizedBox(
          height: sizeScreen.height * 0.05,
        ),
        const TabelaT4(
          column01: [
            Text('Estadual/Distrital'),
            Text('Internacional'),
            Text('Internacional'),
            Text('Internacional'),
            Text('Internacional'),
            Text('Outras'),
          ],
          column02: [
            Text('instrumento (nª)'),
            Text('Lei/decreto'),
            Text('Portaria/instrução/deliberação'),
            Text('Norma/ato'),
            Text('Outros'),
            TextField(
              decoration: InputDecoration(border: InputBorder.none),
            ),
          ],
          column03: [
            Text('Nome/titulo/certificação/licenciamento/outro'),
            TextField(
              decoration: InputDecoration(border: InputBorder.none),
            ),
            TextField(
              decoration: InputDecoration(border: InputBorder.none),
            ),
            TextField(
              decoration: InputDecoration(border: InputBorder.none),
            ),
            TextField(
              decoration: InputDecoration(border: InputBorder.none),
            ),
            TextField(
              decoration: InputDecoration(border: InputBorder.none),
            ),
          ],
          column04: [
            Text('Entidade declaratória/tipo de declaração'),
            TextField(
              decoration: InputDecoration(border: InputBorder.none),
            ),
            TextField(
              decoration: InputDecoration(border: InputBorder.none),
            ),
            TextField(
              decoration: InputDecoration(border: InputBorder.none),
            ),
            TextField(
              decoration: InputDecoration(border: InputBorder.none),
            ),
            TextField(
              decoration: InputDecoration(border: InputBorder.none),
            ),
          ],
        ),
        SizedBox(
          height: sizeScreen.height * 0.05,
        ),
        Row(children: [
          const textLabel(
              name:
                  'Da área ou edificação \nem que está\nlocalizado / Instalado'),
          SizedBox(
            width: sizeScreen.width * 0.04,
          ),
          const SizedBox(
              // width: sizeScreen.width * 0.5,
              //    height: sizeScreen.height * 0.07,
              child: ExpansionTileYoN())
        ]),
        SizedBox(
          height: sizeScreen.height * 0.05,
        ),
        const TabelaT4(
          column01: [
            Text('Categoria'),
            Text('Municipal'),
            Text('Municipal'),
            Text('Municipal'),
            Text('Municipal'),
          ],
          column02: [
            Text('instrumento (nª)'),
            Text('Lei/decreto'),
            Text('Portaria/instrução/deliberação'),
            Text('Norma/ato'),
            Text('Outros'),
          ],
          column03: [
            Text('Nome/titulo/certificação/licenciamento/outro'),
            TextField(
              decoration: InputDecoration(border: InputBorder.none),
            ),
            TextField(
              decoration: InputDecoration(border: InputBorder.none),
            ),
            TextField(
              decoration: InputDecoration(border: InputBorder.none),
            ),
            TextField(
              decoration: InputDecoration(border: InputBorder.none),
            ),
          ],
          column04: [
            Text('Entidade declaratória/tipo de declaração'),
            TextField(
              decoration: InputDecoration(border: InputBorder.none),
            ),
            TextField(
              decoration: InputDecoration(border: InputBorder.none),
            ),
            TextField(
              decoration: InputDecoration(border: InputBorder.none),
            ),
            TextField(
              decoration: InputDecoration(border: InputBorder.none),
            ),
          ],
        ),
        SizedBox(
          height: sizeScreen.height * 0.05,
        ),
        const TabelaT4(
          column01: [
            Text('Estadual/Distrital'),
            Text('Estadual/Distrital'),
            Text('Estadual/Distrital'),
            Text('Estadual/Distrital'),
            Text('Estadual/Distrital'),
          ],
          column02: [
            Text('instrumento (nª)'),
            Text('Lei/decreto'),
            Text('Portaria/instrução/deliberação'),
            Text('Norma/ato'),
            Text('Outros'),
          ],
          column03: [
            Text('Nome/titulo/certificação/licenciamento/outro'),
            TextField(
              decoration: InputDecoration(border: InputBorder.none),
            ),
            TextField(
              decoration: InputDecoration(border: InputBorder.none),
            ),
            TextField(
              decoration: InputDecoration(border: InputBorder.none),
            ),
            TextField(
              decoration: InputDecoration(border: InputBorder.none),
            ),
          ],
          column04: [
            Text('Entidade declaratória/tipo de declaração'),
            TextField(
              decoration: InputDecoration(border: InputBorder.none),
            ),
            TextField(
              decoration: InputDecoration(border: InputBorder.none),
            ),
            TextField(
              decoration: InputDecoration(border: InputBorder.none),
            ),
            TextField(
              decoration: InputDecoration(border: InputBorder.none),
            ),
          ],
        ),
        SizedBox(
          height: sizeScreen.height * 0.05,
        ),
        const TabelaT4(
          column01: [
            Text('Categoria'),
            Text('Federal'),
            Text('Federal'),
            Text('Federal'),
            Text('Federal'),
          ],
          column02: [
            Text('instrumento (nª)'),
            Text('Lei/decreto'),
            Text('Portaria/instrução/deliberação'),
            Text('Norma/ato'),
            Text('Outros'),
          ],
          column03: [
            Text('Nome/titulo/certificação/licenciamento/outro'),
            TextField(
              decoration: InputDecoration(border: InputBorder.none),
            ),
            TextField(
              decoration: InputDecoration(border: InputBorder.none),
            ),
            TextField(
              decoration: InputDecoration(border: InputBorder.none),
            ),
            TextField(
              decoration: InputDecoration(border: InputBorder.none),
            ),
          ],
          column04: [
            Text('Entidade declaratória/tipo de declaração'),
            TextField(
              decoration: InputDecoration(border: InputBorder.none),
            ),
            TextField(
              decoration: InputDecoration(border: InputBorder.none),
            ),
            TextField(
              decoration: InputDecoration(border: InputBorder.none),
            ),
            TextField(
              decoration: InputDecoration(border: InputBorder.none),
            ),
          ],
        ),
        SizedBox(
          height: sizeScreen.height * 0.05,
        ),
        const TabelaT4(
          column01: [
            Text('Estadual/Distrital'),
            Text('Internacional'),
            Text('Internacional'),
            Text('Internacional'),
            Text('Internacional'),
            Text('Outras'),
          ],
          column02: [
            Text('instrumento (nª)'),
            Text('Lei/decreto'),
            Text('Portaria/instrução/deliberação'),
            Text('Norma/ato'),
            Text('Outros'),
            TextField(
              decoration: InputDecoration(border: InputBorder.none),
            ),
          ],
          column03: [
            Text('Nome/titulo/certificação/licenciamento/outro'),
            TextField(
              decoration: InputDecoration(border: InputBorder.none),
            ),
            TextField(
              decoration: InputDecoration(border: InputBorder.none),
            ),
            TextField(
              decoration: InputDecoration(border: InputBorder.none),
            ),
            TextField(
              decoration: InputDecoration(border: InputBorder.none),
            ),
            TextField(
              decoration: InputDecoration(border: InputBorder.none),
            ),
          ],
          column04: [
            Text('Entidade declaratória/tipo de declaração'),
            TextField(
              decoration: InputDecoration(border: InputBorder.none),
            ),
            TextField(
              decoration: InputDecoration(border: InputBorder.none),
            ),
            TextField(
              decoration: InputDecoration(border: InputBorder.none),
            ),
            TextField(
              decoration: InputDecoration(border: InputBorder.none),
            ),
            TextField(
              decoration: InputDecoration(border: InputBorder.none),
            ),
          ],
        ),
        SizedBox(
          height: sizeScreen.height * 0.05,
        ),
        Container(
          color: const Color.fromARGB(255, 55, 111, 60),
          height: sizeScreen.height * 0.06,
          padding: EdgeInsets.only(
              top: sizeScreen.height * 0.008, left: sizeScreen.width * 0.04),
          child: Text(
            'Estado geral de conservação',
            style: TextStyle(
                color: Colors.white, fontSize: sizeScreen.height * 0.03),
          ),
        ),
        SizedBox(
          height: sizeScreen.height * 0.05,
        ),
        const RadioD(options: ['Muito bom', 'Bom', 'Ruim']),
        SizedBox(
          height: sizeScreen.height * 0.05,
        ),
        Container(
          color: const Color.fromARGB(255, 55, 111, 60),
          height: sizeScreen.height * 0.06,
          padding: EdgeInsets.only(
              top: sizeScreen.height * 0.008, left: sizeScreen.width * 0.04),
          child: Text(
            'Acessibilidade',
            style: TextStyle(
                color: Colors.white, fontSize: sizeScreen.height * 0.03),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              left: sizeScreen.width * 0.19,
              top: sizeScreen.height * 0.02,
              bottom: sizeScreen.height * 0.02),
          child: const textLabel(
              name:
                  'Possui alguma facilidade\n      para pessoas com\ndeficiência ou mobilidade\n             reduzida?'),
        ),
        const ExpansionTileYoN(),

        Padding(
          padding: EdgeInsets.only(
              left: sizeScreen.width * 0.1,
              top: sizeScreen.height * 0.02,
              bottom: sizeScreen.height * 0.02),
          child: const textLabel(name: 'obs: responder ás questões seguintes'),
        ),

        Padding(
          padding: EdgeInsets.only(
              left: sizeScreen.width * 0.1,
              top: sizeScreen.height * 0.02,
              bottom: sizeScreen.height * 0.02),
          child: const textLabel(name: 'Pessoal capacitado para receber PCD'),
        ),
        const RadioD(options: [
          'Não',
          'Física',
          'Auditiva',
          'Visual',
          'Mental',
          'Múltipla'
        ]),
        Padding(
          padding: EdgeInsets.only(
              left: sizeScreen.width * 0.24,
              top: sizeScreen.height * 0.02,
              bottom: sizeScreen.height * 0.02),
          child: const textLabel(name: 'Rota externa acessível'),
        ),
        const RadioD(options: [
          'Não',
          'Estacionamento',
          'Calçada rebaixada',
          'Faixa de pedestre',
          'Rampa',
          'Semáforo sonoro',
          'Piso tátil de alerta',
          'Piso regular antiderrapante',
          'Livre de obstáculos',
          'outro'
        ]),
        Padding(
          padding: EdgeInsets.only(
              left: sizeScreen.width * 0.15,
              top: sizeScreen.height * 0.02,
              bottom: sizeScreen.height * 0.02),
          child: const textLabel(name: 'Símbolo internacional de acesso'),
        ),
        const RadioD(options: [
          'Não',
          'Entrada',
          'Área reservada',
          'Estacionamento',
          'Área de embarque e desembarque',
          'Sanitário',
          'Saída de emergência',
        ]),
        Padding(
          padding: EdgeInsets.only(
              left: sizeScreen.width * 0.11,
              top: sizeScreen.height * 0.02,
              bottom: sizeScreen.height * 0.02),
          child: const textLabel(name: 'Local de embarque e desembarque'),
        ),
        const RadioD(options: ['Não', 'Sinalizado', 'Com acesso em nível']),
        Padding(
          padding: EdgeInsets.only(
              left: sizeScreen.width * 0.2,
              top: sizeScreen.height * 0.02,
              bottom: sizeScreen.height * 0.02),
          child: const textLabel(name: 'Vaga em estacionamento'),
        ),
        const RadioD(options: [
          'Não',
          'Sinalizado',
          'Com acesso em nível',
          'Alargada para cadeira de rodas',
          'Rampa de acesso á calçada'
        ]),
        Padding(
          padding: EdgeInsets.only(
              left: sizeScreen.width * 0.1,
              top: sizeScreen.height * 0.02,
              bottom: sizeScreen.height * 0.02),
          child: const textLabel(
              name:
                  'Área de circulação / acesso interno\n          para cadeira de rodas'),
        ),
        const RadioD(options: [
          'Não',
          'Rampa',
          'Elevador',
          'Plataforma elevatória',
          'Porta larga',
          'Piso regular / antiderrapante'
        ]),
        Padding(
          padding: EdgeInsets.only(
              left: sizeScreen.width * 0.35,
              top: sizeScreen.height * 0.02,
              bottom: sizeScreen.height * 0.02),
          child: const textLabel(name: 'Escada'),
        ),
        const RadioD(options: [
          'Não',
          'Corrimão',
          'Patamar para descanso',
          'Sinalização tátil de alerta',
          'Piso antiderrapante',
        ]),

        Padding(
          padding: EdgeInsets.only(
              left: sizeScreen.width * 0.35,
              top: sizeScreen.height * 0.02,
              bottom: sizeScreen.height * 0.02),
          child: const textLabel(name: 'Rampa'),
        ),
        const RadioD(options: [
          'Não',
          'Corrimão',
          'Patamar para descanso',
          'Sinalização tátil de alerta',
          'Piso antiderrapante',
          'Inclinação adequada',
        ]),
        Padding(
          padding: EdgeInsets.only(
              left: sizeScreen.width * 0.35,
              top: sizeScreen.height * 0.02,
              bottom: sizeScreen.height * 0.02),
          child: const textLabel(name: 'Piso'),
        ),
        const RadioD(options: [
          'Não',
          'Tátil',
          'Sem obstáculos',
          'Antiderrapante/deslizante',
        ]),
        Padding(
          padding: EdgeInsets.only(
              left: sizeScreen.width * 0.3,
              top: sizeScreen.height * 0.02,
              bottom: sizeScreen.height * 0.02),
          child: const textLabel(name: 'Elevador'),
        ),
        const RadioD(options: [
          'Não',
          'Sinalizado em braile',
          'Dispositivo sonoro',
          'Dispositivo luminoso',
          'Sensor eletrônico (porta)'
        ]),
        Padding(
          padding: EdgeInsets.only(
              left: sizeScreen.width * 0.19,
              top: sizeScreen.height * 0.02,
              bottom: sizeScreen.height * 0.02),
          child: const textLabel(
              name: '  Equipamento motorizado\npara deslocamento interno'),
        ),
        const RadioD(options: [
          'Não',
          'Cadeira',
          'Carrinho',
        ]),
        Padding(
          padding: EdgeInsets.only(
              left: sizeScreen.width * 0.25,
              top: sizeScreen.height * 0.02,
              bottom: sizeScreen.height * 0.02),
          child: const textLabel(name: 'Sinalização visual'),
        ),
        const RadioD(options: [
          'Não',
          'Entrada',
          'Recepção',
          'Porta',
          'Sanitário',
          'Elevador',
          'Restaurante',
          'Área de lazer',
          'Área de resgate',
        ]),
        Padding(
          padding: EdgeInsets.only(
              left: sizeScreen.width * 0.29,
              top: sizeScreen.height * 0.02,
              bottom: sizeScreen.height * 0.02),
          child: const textLabel(name: 'Sinalização tátil'),
        ),
        const RadioD(options: [
          'Não',
          'Entrada',
          'Recepção',
          'Porta',
          'Sanitário',
          'Elevador',
          'Restaurante',
          'Área de lazer',
          'Área de resgate',
        ]),
        Padding(
          padding: EdgeInsets.only(
              left: sizeScreen.width * 0.23,
              top: sizeScreen.height * 0.02,
              bottom: sizeScreen.height * 0.02),
          child: const textLabel(name: 'Alarme de emergência'),
        ),
        const RadioD(options: [
          'Não',
          'Sonoro',
          'Visual',
          'Vibratório',
        ]),
        Padding(
          padding: EdgeInsets.only(
              left: sizeScreen.width * 0.3,
              top: sizeScreen.height * 0.02,
              bottom: sizeScreen.height * 0.02),
          child: const textLabel(name: 'Comunicação'),
        ),
        const RadioD(options: [
          'Não',
          'Texto informativo em braile',
          'Texto informativo em fonte ampliada',
          'Intérprete em libras',
        ]),
        Padding(
          padding: EdgeInsets.only(
              left: sizeScreen.width * 0.23,
              top: sizeScreen.height * 0.02,
              bottom: sizeScreen.height * 0.02),
          child: const textLabel(name: 'Balcão de atendimento'),
        ),
        const RadioD(options: [
          'Não',
          'Rebaixado',
          'Preferencial para PCD ou com deficiência ou mobilidade reduzida',
        ]),
        Padding(
          padding: EdgeInsets.only(
              left: sizeScreen.width * 0.33,
              top: sizeScreen.height * 0.02,
              bottom: sizeScreen.height * 0.02),
          child: const textLabel(name: 'Mobiliário'),
        ),
        const RadioD(options: [
          'Não',
          'Altura adequada',
          'Recuo adequado',
        ]),
        Padding(
          padding: EdgeInsets.only(
              left: sizeScreen.width * 0.34,
              top: sizeScreen.height * 0.02,
              bottom: sizeScreen.height * 0.02),
          child: const textLabel(name: 'Sanitário'),
        ),
        const RadioD(options: [
          'Não',
          'Porta larga suficiente para entrada de cadeira de rodas ',
          'Acesso para cadeira de rodas',
          'Espelho rebaixado ou com ângulo de alcance visual',
          'Torneira monocomando / alavanca',
          'Barra de apoio',
          'Giro para cadeira de rodas',
          'Pia rebaixada',
          'Boxe ou banheira daptada',
        ]),
        Padding(
          padding: EdgeInsets.only(
              left: sizeScreen.width * 0.34,
              top: sizeScreen.height * 0.02,
              bottom: sizeScreen.height * 0.02),
          child: const textLabel(name: 'Telefone'),
        ),
        const RadioD(options: [
          'Não',
          'Altura adequada',
          'Para surdos (TPS ou TTS)',
        ]),
        Padding(
          padding: EdgeInsets.only(
              top: sizeScreen.height * 0.02, bottom: sizeScreen.height * 0.02),
          child: const textLabel(
              name:
                  'Sinalização indicativa de atendimento preferencial para pessoas com deficiência ou mobilidade reduzida'),
        ),
        const ExpansionTileYoN(),
        Row(
          children: [
            const textLabel(name: 'Outros'),
            SizedBox(
              width: sizeScreen.width * 0.1,
            ),
            SizedBox(
                width: sizeScreen.width * 0.6,
                height: sizeScreen.height * 0.07,
                child: const CustomTextField(
                  name: '',
                ))
          ],
        ),
        SizedBox(
          height: sizeScreen.height * 0.05,
        ),
        Container(
          color: const Color.fromARGB(255, 55, 111, 60),
          height: sizeScreen.height * 0.06,
          padding: EdgeInsets.only(
              top: sizeScreen.height * 0.008, left: sizeScreen.width * 0.04),
          child: Text(
            'Observações',
            style: TextStyle(
                color: Colors.white, fontSize: sizeScreen.height * 0.03),
          ),
        ),
        const CustomTextField(name: ''),
        SizedBox(
          height: sizeScreen.height * 0.05,
        ),

        Container(
          color: const Color.fromARGB(255, 55, 111, 60),
          height: sizeScreen.height * 0.06,
          padding: EdgeInsets.only(
              top: sizeScreen.height * 0.008, left: sizeScreen.width * 0.04),
          child: Text(
            'Referências',
            style: TextStyle(
                color: Colors.white, fontSize: sizeScreen.height * 0.03),
          ),
        ),
        const CustomTextField(name: ''),
        SizedBox(
          height: sizeScreen.height * 0.05,
        ),
        Container(
          color: const Color.fromARGB(255, 55, 111, 60),
          height: sizeScreen.height * 0.06,
          padding: EdgeInsets.only(
              top: sizeScreen.height * 0.008, left: sizeScreen.width * 0.04),
          child: Text(
            'Equipe Responsável',
            style: TextStyle(
                color: Colors.white, fontSize: sizeScreen.height * 0.03),
          ),
        ),
        SizedBox(
          height: sizeScreen.height * 0.05,
        ),
        const textLabel(name: 'Responsável pelo atendimento (Pesquisador)'),
        const CustomTextField(name: ''),
        const textLabel(name: 'Telefone'),
        const CustomTextField(name: ''),
        const textLabel(name: 'E-mail'),
        const CustomTextField(name: ''),
        const textLabel(name: 'Responsável pelo atendimento (Coordenador)'),
        const CustomTextField(name: ''),
        const textLabel(name: 'Telefone'),
        const CustomTextField(name: ''),
        const textLabel(name: 'E-mail'),
        const CustomTextField(name: ''),
        SizedBox(
          height: sizeScreen.height * 0.05,
        ),
        SizedBox(
          height: sizeScreen.height * 0.07,
          width: sizeScreen.width * 0.15,
          child: FittedBox(
            child: OutlinedButton(
              onPressed: () => print('enviar'),
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.green[800],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                    left: sizeScreen.width * 0.22,
                    right: sizeScreen.width * 0.25),
                child: Text(
                  'Enviar',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize:
                          sizeScreen.height * 0.03), // Use um fontSize fixo
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: sizeScreen.height * 0.05,)
      ]),
    );
  }
}
