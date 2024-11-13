// import 'package:inventur/data/repository/rodovia_repo.dart';
// import 'package:inventur/models/rodovia_model.dart';
// import 'package:get/get.dart';

// class RodoviaController extends GetxController{

// final RodoviaRepo rodoviaRepo;

// RodoviaController({required this.rodoviaRepo});

// List<Rodovia> _rodoviaList = [];
// List<Rodovia> get rodoviaList => _rodoviaList;

// bool _isLoaded = false;
// bool get isLoaded => _isLoaded;

// Future<void> getRodoviaList() async{

//   Response response = await rodoviaRepo.getRodoviaList();

//   if(response.statusCode == 200){
//     print("rodovias recebidas");
//     _rodoviaList = [];
//     response.body.forEach((rodoviaJson){
//       _rodoviaList.add(Rodovia.fromJson(rodoviaJson));
//     });
//     _rodoviaList.forEach((rodovia){
//       print("Nome popular da rodovia: ${rodovia.nomePopular}");
//     });
//     _isLoaded = true;
//     update();
//   }else{
//     print("fetch falhou");
//   }
// }




// }