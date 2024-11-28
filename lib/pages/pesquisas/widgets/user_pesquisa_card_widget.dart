import 'package:flutter/material.dart';
import 'package:inventur/models/user_model.dart';
import 'package:inventur/pages/controllers/pesquisa_controller.dart';

class UserPesquisaCardList extends StatefulWidget{
  final User user;
  bool isSelected;
  final PesquisaController pesquisaController;
  final bool xIsVisible;

   UserPesquisaCardList({
    super.key,
    required this.user,
    required this.pesquisaController,
    this.isSelected = false,
    this.xIsVisible = false
  });
   @override
  State<UserPesquisaCardList> createState() => _UserPesquisaCardListState();
}

class _UserPesquisaCardListState extends State<UserPesquisaCardList>{

  bool _isVisible = true;
  void _removeUser() {
    widget.pesquisaController.removeUserPesquisa(widget.user);
    setState(() {
      _isVisible = false; 
    widget.isSelected = widget.isSelected;
      // Oculta o card após a remoção
    });
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

 



