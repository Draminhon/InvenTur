// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:inventur/models/rodovia_model.dart';
// import 'package:inventur/utils/app_constants.dart';
// import 'package:get/get.dart';

// class ApiClient extends GetConnect implements GetxService{
 
// static Future<List<Rodovia>> getRodovias() async{
//   var url = Uri.parse(AppConstants.BASE_URI + AppConstants.RODOVIA_GET);
//   final response = await http.get(url, headers:{"Content-Type": "application/json"});
//   final List body = json.decode(response.body);
//   return body.map((e) => Rodovia.fromJson(e)).toList();
// }

// Future<List<Rodovia>> rodoviasFuture = getRodovias();

// }