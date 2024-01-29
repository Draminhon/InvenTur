import 'package:flutter/material.dart';
import 'package:inventur/models/user_model.dart';

class UserController extends ChangeNotifier {
  int _countSelecedUsers = 0;
  bool _allSelectedUsers = false;
  List<UserModel> _users = [];

  final List<UserModel> _selectedUsers = [];

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
      notifyListeners();
    }
  }

  void unselectUser({required UserModel user}) {
    _selectedUsers.remove(user);
    user.isSelected = false;
    _countSelecedUsers--;
    notifyListeners();
  }

  void selectAllUsers() {
    for (UserModel user in _users) {
      selectUser(user: user);
    }
    _countSelecedUsers = _selectedUsers.length;
    notifyListeners();
  }

  void unselectAllUsers() {
    // for (var i = 0; i < _selectedUsers.length; i++) {
    //   UserModel user = _selectedUsers[i];
    //   unselectUser(user: user);
    // }
    for (UserModel user in _selectedUsers) {
      user.isSelected = false;
    }
    _countSelecedUsers = 0;
    notifyListeners();
  }
}