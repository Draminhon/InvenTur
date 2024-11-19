import 'package:flutter/material.dart';
import 'package:inventur/models/user_model.dart';
import 'package:inventur/utils/app_constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class UserController extends ChangeNotifier {
  static const String _allStatus = 'Todos';
  static const String _onStatus = 'Ativo';
  static const String _offStatus = 'Não Ativo';
  static const String _waitingStatus = 'Aguardando Aprovação';
  static const String _primaryLevel = 'Administrador';
  static const String _secondaryLevel = 'Pesquisador';

  final List<User> _selectedUsers = [];
  final List<User> _filteredUsers = [];

  final List<String> _accessLevels = [_secondaryLevel, _primaryLevel];
  final List<String> statusItems = [
    _waitingStatus,
    _onStatus,
    _offStatus
  ];
  final List<String> _statusFilters = [
    _allStatus,
    _onStatus,
    _offStatus,
    _waitingStatus
  ];

  int _countSelectedUsers = 0;
  List<User> _users = [];
  List<User> get users => _users;
  bool _allSelectedUsers = false;
  String _usersFilteredStatus = _allStatus;
  String _usersFilteredAccessLevel = _secondaryLevel;

  String get primaryLevel => _primaryLevel;
  String get secondaryLevel => _secondaryLevel;

  List<String> get accessLeves => _accessLevels;
  List<String> get statusFilters => _statusFilters;
  int get countSelectedUsers => _countSelectedUsers;
  List<User> get filteredUsers => _filteredUsers;
  String get usersFilteredStatus => _usersFilteredStatus;
  String get usersFilteredAccessLevel => _usersFilteredAccessLevel;

  bool get allSelectedUsers => _allSelectedUsers;

  void setUsers(List<User> users) {
    _users = users;
  }

  void removeUser(User user){
    _users.removeWhere((u)=>u.id == user.id);
    populateFilteredUsers();
    notifyListeners();
  }

  void setAllSelectedUsers(bool marked) {
    _allSelectedUsers = marked;
    notifyListeners();
  }

  void populateFilteredUsers() {
    if (_selectedUsers.isNotEmpty) {
      unselectAllUsers();
    }

    if (_filteredUsers.isNotEmpty) {
      _filteredUsers.clear();
    }

    for (User user in _users) {
      if (usersFilteredAccessLevel == _accessLevels[0] &&
          user.accessLevel == _accessLevels[0]) {
        switch (usersFilteredStatus) {
          case _allStatus:
            _filteredUsers.add(user);
            break;
          default:
            if (user.status == usersFilteredStatus) {
              _filteredUsers.add(user);
            }
            break;
        }
      } else if (usersFilteredAccessLevel == _accessLevels[1] &&
          user.accessLevel == _accessLevels[1]) {
        _filteredUsers.add(user);
      }
      notifyListeners();
    }
  }

  void selectUser({required User user}) {
    if (!_selectedUsers.contains(user)) {
      _selectedUsers.add(user);
      user.isSelected = true;
      _countSelectedUsers++;
    }

    if (!allSelectedUsers && _selectedUsers.length == filteredUsers.length) {
      setAllSelectedUsers(true);
    }
    notifyListeners();
  }

  void unselectUser({required User user}) {
    if (allSelectedUsers) setAllSelectedUsers(false);
    _selectedUsers.remove(user);
    user.isSelected = false;
    _countSelectedUsers--;
    notifyListeners();
  }

  void selectAllUsers() {
    for (User user in _filteredUsers) {
      selectUser(user: user);
    }
  }

  void unselectAllUsers() {
    for (User user in _filteredUsers) {
      if (user.isSelected) {
        unselectUser(user: user);
      }
    }
  }

  void setUserStatus(String status, User user) async{
    user.status = status;
    notifyListeners();

      var url = Uri.parse('${AppConstants.BASE_URI}/api/v1/usuarios/status/update/${user.id}/');

     try{
     await http.patch(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'id': user.id,
          'username': user.username,
          'CPF': user.CPF,
          'email': user.email,
          'acessLevel': user.accessLevel,
          'status': status
        }),
      );

     
    }catch(e){
      print('Erro ao atualizar o status no banco: $e');
    }
  }

  void changeSelectedUsersStatus(String status) {
    for (User user in _filteredUsers) {
      if (user.isSelected) {
        setUserStatus(status, user);
        unselectUser(user: user);
      }
    }
    populateFilteredUsers();
  }

  void filterUsersByStatus(String status) {
    _usersFilteredStatus = status;
    notifyListeners();
    populateFilteredUsers();
  }

  void filterUsersByAccessLevel(String accessLevel) {
    _usersFilteredAccessLevel = accessLevel;
    notifyListeners();
    populateFilteredUsers();
  }

  void searchUsers(String text) {
    List<User> auxUsers = [];

    if (_selectedUsers.isNotEmpty) {
      unselectAllUsers();
    }
    
    text = text.toLowerCase();
    for (User user in _filteredUsers) {
      if (user.username.toLowerCase().contains(text)) {
        auxUsers.add(user);
      } else if (user.CPF.contains(text)) {
        auxUsers.add(user);
      } else if (user.email.toLowerCase().contains(text)) {
        auxUsers.add(user);
      }
    }

    _filteredUsers.clear();
    for (User user in auxUsers){
      _filteredUsers.add(user);
    }
    notifyListeners();
  }

  Color? statusColor(String status) {
    switch (status) {
      case _waitingStatus:
        return Colors.orange[600];
      case _onStatus:
        return Colors.green[600];
      case _offStatus:
        return Colors.red[600];
    }
    return null;
  }
}
