import 'package:flutter/material.dart';
import 'package:inventur/models/user_model.dart';
import 'package:inventur/pages/controllers/pesquisa_controller.dart';

class UserPesquisaCardList extends StatefulWidget{
  final User user;
  bool isSelected;
  final PesquisaController pesquisaController;
  final bool xIsVisible;
  final int pesquisaId;
  final void Function(User)? onRemove;
   
   UserPesquisaCardList({
    super.key,
    required this.user,
    required this.pesquisaId,
    required this.pesquisaController,
    this.onRemove,
    this.isSelected = false,
    this.xIsVisible = false
  });
   @override
  State<UserPesquisaCardList> createState() => _UserPesquisaCardListState();
}

class _UserPesquisaCardListState extends State<UserPesquisaCardList>{

  bool _isVisible = true;
void _removeUser() async {
  // 1) Chamar o método que faz a requisição HTTP de remoção
  final sucesso = await widget.pesquisaController.removerPesquisador(
    pesquisaId: widget.pesquisaId,
    userId: widget.user.id!,
  );
  if (sucesso) {
    // 2) Atualiza lista local
    widget.pesquisaController.removeUserPesquisa(widget.user);
    // 3) Atualiza a UI deste card
    setState(() {
      _isVisible = false;
      // Se quiser também atualizar widget.isSelected, você pode:
      widget.isSelected = false;
      widget.onRemove!(widget.user);
    });
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Erro ao remover pesquisador")),
    );
  }
}



 @override
Widget build(BuildContext context) {
  if (!_isVisible) return SizedBox.shrink();
    return Card(
    
      elevation: 6,
      color: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
       
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Flexible(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Nome:", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(widget.user.username)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("CPF:", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(widget.user.CPF)
                    ],
                  ),
                ],
              ),
            ),

          widget.xIsVisible ?
          Padding(
              padding: const EdgeInsets.only(left: 8),
              child: IconButton(
                padding: EdgeInsets.zero,
                visualDensity: VisualDensity.compact,
                onPressed: _removeUser,
                icon: const Icon(
                  Icons.close_rounded,
                  color: Color.fromARGB(255, 232, 0, 0),
                  size: 36,
                ),
              ),
            ) :
            Container()
          ],
        ),
      ),
    );
  }
}

 



