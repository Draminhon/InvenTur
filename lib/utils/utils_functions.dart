import 'package:flutter/material.dart';
import 'package:inventur/services/admin_service.dart';
import 'package:inventur/services/form_service.dart';
import 'package:inventur/utils/modals.dart';

class UtilsFunctions {

  Future<int> getInfoUsersInPesquisa(Map<String, dynamic> valoresjson) async {
    Map<String, dynamic> info = await getAdminAndPesquisadorInfo();
    valoresjson['nome_pesquisador'] = info['pesquisador']['nome'];
    valoresjson['telefone_pesquisador'] = info['pesquisador']['telefone'];
    valoresjson['email_pesquisador'] = info['pesquisador']['email'];

    valoresjson['nome_coordenador'] = info['coordenador']['nome'];
    valoresjson['telefone_coordenador'] = info['coordenador']['telefone'];
    valoresjson['email_coordenador'] = info['coordenador']['email'];

    return info['pesquisador']['id'];
   
  }

   bool isTheOwner(int pesquisadorId, int usuarioCriador, BuildContext context) {
    if (pesquisadorId == usuarioCriador) {
      return true;
    } else {
          Modals().showNoAcessPermissionnDialog(context);

      return false;
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