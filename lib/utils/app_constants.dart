import 'package:flutter/material.dart';

class AppConstants {
  static const String APP_NAME = "InvenTur";
  static int APP_VERSION = 1;

  static const String BASE_URI = "http://10.0.2.2:8000";
  static const String LOGIN_URI = "/api/v1/login/";
  static const String REGISTER_URI = "/api/v1/register/";
  static const String GET_USERS = "/api/v1/usuarios/";
  static const  String GET_PESQUISAS = "/api/v1/pesquisa/create";
  static const String RODOVIA_CREATE = "/api/v1/rodovia/create/";
  static const String RODOVIA_GET = "/api/v1/rodovia/get";
  static const String SET_PESQUISA_STATUS = "/api/v1/pesquisa/status/update/<int:pk>/";
  static const String TOKEN = "DBtoken";

  static const Color MAIN_GREEN = Color.fromARGB(255, 55, 111, 60);
}