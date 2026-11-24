import 'package:flutter/material.dart';
import 'package:sistur/models/user_model.dart';

class UserProvider with ChangeNotifier{

User _user = User(id:0, username: "", email: "");

User get user=> _user;

void setUser(User newUser){
  _user = newUser;
  notifyListeners();
}

void updateUser(String name, String email, String telefone){
  _user.username = name;
  _user.email = email;
  _user.telefone = telefone;
  notifyListeners();
}


}