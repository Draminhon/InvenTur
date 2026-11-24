import 'package:flutter/material.dart';
import 'package:sistur/services/interceptor_service.dart';
import 'package:sistur/utils/app_constants.dart';
import 'package:sistur/controllers/user_controller.dart';
import 'package:sistur/ui/home/Administrador/widgets/popup_menu_widget.dart';
import 'package:sistur/ui/home/Administrador/widgets/user_card_widget.dart';
import 'package:sistur/ui/home/Administrador/dialogs/user_management_dialog.dart';

class UserManagementPage extends StatefulWidget {
  final UserController userControllerNotifier;

  const UserManagementPage({super.key, required this.userControllerNotifier});

  @override
  State<UserManagementPage> createState() => _UserManagementPageState();
}

class _UserManagementPageState extends State<UserManagementPage> {
  final TextEditingController _searchController = TextEditingController();

  late UserController _userController;

  // Pesquisas deste administrador, para o filtro (o servidor só devolve as que ele criou)
  List<({int id, String nome})> _pesquisas = [];

  @override
  void initState() {
    super.initState();
    _userController = widget.userControllerNotifier;
    _carregarPesquisas();
  }

  Future<void> _carregarPesquisas() async {
    try {
      final response = await ApiService().get(AppConstants.GET_PESQUISAS);
      if (response.statusCode == 200 && mounted) {
        setState(() {
          _pesquisas = [
            for (final p in List<Map<String, dynamic>>.from(response.data))
              (id: p['id'] as int, nome: '${p['municipio']} - ${p['estado']}'),
          ];
        });
      }
    } catch (e) {
      debugPrint('Erro ao carregar pesquisas para o filtro: $e');
    }
  }

  Widget _filtroPorPesquisa() {
    final ids = _pesquisas.map((p) => p.id).toSet();
    final selecionada = ids.contains(_userController.pesquisaFiltrada) ? _userController.pesquisaFiltrada : null;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppConstants.MAIN_GREEN.withValues(alpha: 0.3)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int?>(
          isExpanded: true,
          value: selecionada,
          icon: const Icon(Icons.filter_list, color: AppConstants.MAIN_GREEN),
          items: [
            const DropdownMenuItem(value: null, child: Text('Todas as minhas pesquisas')),
            for (final p in _pesquisas)
              DropdownMenuItem(value: p.id, child: Text(p.nome, overflow: TextOverflow.ellipsis)),
          ],
          onChanged: _userController.filterUsersByPesquisa,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 13, top: 8, right: 13, bottom: 2),
          height: 40,
          child: SearchBar(
            hintText: 'Pesquisar',
            controller: _searchController,
            backgroundColor: WidgetStateProperty.all(Colors.white),
            surfaceTintColor: WidgetStateProperty.all(Colors.white),
            elevation: WidgetStateProperty.all(2),
            trailing: [
              IconButton(
                onPressed: () {
                  _userController.searchUsers(_searchController.text);
                },
                icon: const Icon(
                  Icons.search,
                  color: Color.fromARGB(255, 55, 111, 60),
                )
              ),
            ],
            onChanged: (value) {
              if (value == '') _userController.populateFilteredUsers();
            },
          )
        ),
        ListenableBuilder(
          listenable: _userController,
          builder: (context, child) {
            final pesquisadores = _userController.usersFilteredAccessLevel == 'Pesquisador';
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 13),
              child: Column(
                children: [
                  // Filtro por pesquisa (pesquisadores são os membros das pesquisas)
                  if (pesquisadores && _pesquisas.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: _filtroPorPesquisa(),
                    ),
                  // Filtros de status e de grupo dividem a linha; o cadastro vai numa linha própria
                  Row(
                    children: [
                      if (pesquisadores) ...[
                        Expanded(
                          child: PopupMenu(
                            popupIcon: Icons.filter_alt,
                            tooltip: 'Status filtrado',
                            itens: _userController.statusFilters,
                            onChanged: _userController.filterUsersByStatus,
                            selectedItem: _userController.usersFilteredStatus,
                          ),
                        ),
                        const SizedBox(width: 8),
                      ] else
                        const Spacer(),
                      Expanded(
                        child: PopupMenu(
                          popupIcon: Icons.group,
                          rightIconPosition: false,
                          tooltip: 'Grupo filtrado',
                          itens: _userController.accessLeves,
                          onChanged: _userController.filterUsersByAccessLevel,
                          selectedItem: _userController.usersFilteredAccessLevel,
                        ),
                      ),
                    ],
                  ),
                  _userController.countSelectedUsers > 0
                  ? Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(45)
                              ),
                              value: _userController.allSelectedUsers, 
                              visualDensity: VisualDensity.compact,
                              onChanged: (marked) {
                                _userController.setAllSelectedUsers(marked!);
                                marked
                                ? _userController.selectAllUsers()
                                : _userController.unselectAllUsers();
                              },
                            ),
                            Text('${_userController.countSelectedUsers} Usuário(s) selecionado(s)'),
                          ],
                        ),
                        UserManagementDialogButton(userControllerNotifier: _userController)
                      ],
                    ),
                  )
                  :Container()
                ],
              ),
            );
          },
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ListenableBuilder(
              listenable: _userController,
              builder: (context, child) {
                return _userController.filteredUsers.isNotEmpty
                  ? ListView.builder(
                  itemCount: _userController.filteredUsers.length,
                  itemBuilder: (context, index) {
                    return UserCard(
                      user: _userController.filteredUsers[index],
                      userControllerNotifier: _userController,
                    );
                  }
                )
                : Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      _userController.pesquisaFiltrada != null
                          ? 'Nenhum usuário nesta pesquisa.'
                          : 'Nenhum usuário ainda. Aparecem aqui os usuários que entrarem nas suas pesquisas '
                            '(pelo código da pesquisa) e os que você cadastrar.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ),
                );
              },
            )
          ),
        ),
      ],
    );
  }
}