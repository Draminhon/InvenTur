import 'package:flutter/material.dart';

class AppConstants {
  static const String APP_NAME = "InvenTur";
  static int APP_VERSION = 1;

 static const String BASE_URI = "http://10.0.2.2:8000/api/v1/";
 //static const String BASE_URI = "https://nupreds.ifce.edu.br/inventur/api/v1/";
//    static const String BASE_URI = "http://localhost";
  static const String LOGIN_URI = "login/";
  static const String REGISTER_URI = "user/";
  static const String GET_USERS = "user/";
  static const  String GET_PESQUISAS = "pesquisa";
  static const String RODOVIA_CREATE = "rodovias/";
  static const String OUTROS_MEIOS_DE_HOSPEDAGEM = "outromeiodehospedagem/";
  static const String INFO_BASICA_CREATE = "informacoesbasicasdomunicipio/";
  static const String COMERCIO_TURISTICO = "comercioturistico/";
  static const String SISTEMAS_DE_SEGURANCA = "sistemadeseguranca/";
  static const String ALIMENTOS_E_BEBIDAS = "alimentosEBebidas/";
  static const String MEIOS_DE_HOSPEDAGEM = "meiosdehospedagem/";
  static const String LOCADORA_IMOVEIS = "locadoraimoveis/";
  static const String AGENCIA_TURISMO = "agenciadeturismo/";
  static const String TRANSPORTE_TURISTICO = "transporteturistico/";

  
  static const String SET_PESQUISA_STATUS = "pesquisa/<int:pk>/";

  static const Color MAIN_GREEN = Color.fromARGB(255, 55, 111, 60);
}