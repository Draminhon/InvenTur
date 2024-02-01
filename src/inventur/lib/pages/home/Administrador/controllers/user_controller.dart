import 'package:flutter/material.dart';
import 'package:inventur/models/user_model.dart';

class UserController extends ChangeNotifier {
  int _countSelecedUsers = 0;
  bool _allSelectedUsers = false;
  List<UserModel> _users = [];

  final List<UserModel> _selectedUsers = [];
  final List<String> statusItems = ['Aguardando Aprovação', 'Ativo', 'Não Ativo'];

  int get countSelecedUsers => _countSelecedUsers;
  List<UserModel> get users => _users;

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
      _countSelecedUsers++;
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
    _countSelecedUsers--;
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