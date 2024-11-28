// import 'package:flutter/material.dart';
// import 'package:inventur/models/user_model.dart';
// import 'package:inventur/pages/pesquisas/widgets/user_pesquisa_card_widget.dart';

// class UserSearchPage extends StatefulWidget {
//   final Future<List<User>> userFuture;

//   const UserSearchPage({Key? key, required this.userFuture}) : super(key: key);

//   @override
//   _UserSearchPageState createState() => _UserSearchPageState();
// }

// class _UserSearchPageState extends State<UserSearchPage> {
//   List<User> allUsers = [];
//   List<User> filteredUsers = [];
//   TextEditingController searchController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     // Carregar a lista de usuários do Future e inicializar os usuários filtrados
//     widget.userFuture.then((users) {
//       setState(() {
//         allUsers = users;
//         filteredUsers = users; // Começa com todos os usuários
//       });
//     });

//     // Adicionar um listener para a barra de pesquisa
//     searchController.addListener(() {
//       filterUsers(searchController.text);
//     });
//   }

//   void filterUsers(String query) {
//     final filtered = allUsers.where((user) {
//       final nameLower = user.username?.toLowerCase() ?? '';
//       final searchLower = query.toLowerCase();
//       return nameLower.contains(searchLower);
//     }).toList();

//     setState(() {
//       filteredUsers = filtered;
//     });
//   }

//   @override
//   void dispose() {
//     searchController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: TextField(
//             controller: searchController,
//             decoration: InputDecoration(
//               labelText: 'Pesquisar Usuários',
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(18),
//               ),
//               prefixIcon: Icon(Icons.search),
//             ),
//           ),
//         ),
//         Expanded(
//           child: filteredUsers.isEmpty
//               ? const Center(child: Text("Nenhum usuário encontrado"))
//               : showUsers(filteredUsers),
//         ),
//       ],
//     );
//   }

//   Widget showUsers(List<User> users) {
//     return ListView.builder(
//       itemCount: users.length,
//       itemBuilder: (context, index) {
//         final user = users[index];
//         return UserPesquisaCardList(user: user,);
//       },
//     );
//   }
// }
