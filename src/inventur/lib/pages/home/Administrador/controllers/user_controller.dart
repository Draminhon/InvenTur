import 'package:flutter/material.dart';
import 'package:inventur/models/user_model.dart';

class UserController extends ChangeNotifier {
  int _countSelectedUsers = 0;
  List<UserModel> _users = [];
  bool _allSelectedUsers = false;
  String _usersFilteredStatus = 'Todos';
  String _usersFilteredAccessLevel = 'Pesquisador';

  final List<UserModel> _selectedUsers = [];
  
  final List<String> _accessLevels = ['Pesquisador', 'Administrador'];
  final List<String> statusItems = ['Aguardando Aprovação', 'Ativo', 'Não Ativo'];
  final List<String> _statusFilters = ['Todos', 'Ativo', 'Não Ativo', 'Aguardando Aprovação'];

  List<UserModel> get users => _users;
  List<String> get accessLeves => _accessLevels;
  int get countSelectedUsers => _countSelectedUsers;
  List<String> get statusFilters => _statusFilters;
  String get usersFilteredStatus => _usersFilteredStatus;
  String get usersFilteredAccessLevel => _usersFilteredAccessLevel;

  bool get allSelectedUsers => _allSelectedUsers;
  void setAllSelectedUsers(bool marked) {
    _allSelectedUsers = marked;
    notifyListeners();
  }

  void addUser({required UserModel user}) {
    _users.add(user);
    notifyListeners();
  }

  void setUsers(List<UserModel> users) {
    _users = users;
  }
  
  void selectUser({required UserModel user}) {
    if (!_selectedUsers.contains(user)){
      _selectedUsers.add(user);
      user.isSelected = true;
      _countSelectedUsers++;
    }

    if (!allSelectedUsers && _selectedUsers.length == users.length){
      setAllSelectedUsers(true);
    }
    notifyListeners();
  }

  void unselectUser({required UserModel user}) {
    if (allSelectedUsers) setAllSelectedUsers(false);
    _selectedUsers.remove(user);
    user.isSelected = false;
    _countSelectedUsers--;
    notifyListeners();
  }

  void selectAllUsers() {
    for (UserModel user in _users) {
      selectUser(user: user);
    }
  }

  void unselectAllUsers() {
    for (UserModel user in _users) {
      unselectUser(user: user);
    }
  }

  void setUserStatus(String status, UserModel user) {
    user.status = status;
    notifyListeners();
  }

  void changeUserStatus(String status) {
    for (UserModel user in _users) {
      setUserStatus(status, user);
    }
  }

  void filterUsersStatus(String status) {
    _usersFilteredStatus = status;
    notifyListeners();
  }

  void filterUsersAccessLevel(String accessLevel) {
    _usersFilteredAccessLevel = accessLevel;
    notifyListeners();
  }

  Color? statusColor(String status) {
    switch (status) {
      case 'Aguardando Aprovação':
        return Colors.orangeAccent[400]!;
      case 'Ativo':
        return Colors.greenAccent[700]!;
      case 'Não Ativo':
        return Colors.redAccent[400]!;
    }
    return null;
  }
}