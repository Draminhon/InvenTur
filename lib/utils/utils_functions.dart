import 'package:flutter/material.dart';
import 'package:sistur/services/admin_service.dart';
import 'package:sistur/services/form_service.dart';
import 'package:sistur/utils/modals.dart';

class UtilsFunctions {

  Future<int> getInfoUsersInPesquisa(Map<String, dynamic> valoresjson,  bool isAdmin) async {
    Map<String, dynamic> info = await getAdminAndPesquisadorInfo();
    print("Is admin $isAdmin");
    if(isAdmin == false){
    valoresjson['nome_pesquisador'] = info['pesquisador']['nome'];
    valoresjson['telefone_pesquisador'] = info['pesquisador']['telefone'];
    valoresjson['email_pesquisador'] = info['pesquisador']['email'];

    valoresjson['nome_coordenador'] = info['coordenador']['nome'];
    valoresjson['telefone_coordenador'] = info['coordenador']['telefone'];
    valoresjson['email_coordenador'] = info['coordenador']['email'];
    }
    return info['pesquisador']['id'];
   
  }

   bool isTheOwner(int pesquisadorId, int usuarioCriador, bool isAdmin, BuildContext context) {
    if(isAdmin != true){
   if (pesquisadorId == usuarioCriador) {
      return true;
    } else {
          Modals().showNoAcessPermissionnDialog(context);

      return false;
    }
    }else{
      return true;
    }
 
  }

  void decideSendingOrUpdating(bool isUpdate, isTheOwner,
   BuildContext context,
    int idEquipamento,
    Map<String, dynamic> valoresjson, String route
    ){
  if (isUpdate && isTheOwner) {
          FormService().updateForm(
              idEquipamento, valoresjson, route);
        } else if (isUpdate && !isTheOwner) {
          Modals().showNoPermissionDialog(context);
        } else {
              FormService().sendForm(valoresjson, route);
          ("deu ERRO!");
        }
  }


}