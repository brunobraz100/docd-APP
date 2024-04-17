import 'package:docd/models/user_model.dart';
import 'package:docd/services/user_service.dart';
import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  String _user = "";
  String _password = "";
  bool _load = false;
  bool _visible = true;
  UserModel _userModel = UserModel();
  UserServices userServices = UserServices();

  UserModel get userModel => _userModel;
  String get user => _user;
  String get password => _password;
  bool get load => _load;
  bool get visible => _visible;

  changeUser(String value) {
    _user = value;
    notifyListeners();
  }

  changePassword(String value) {
    _password = value;
    notifyListeners();
  }

  changeLoad(bool value) {
    _load = value;
    notifyListeners();
  }

  changeVisibility(bool value) {
    _visible = value;
    notifyListeners();
  }

  setUserModel(UserModel user) {
    _userModel = user;
    notifyListeners();
  }

  Future<void> login() async {
    _userModel = await userServices.login(_user, _password);
    notifyListeners();
  }
}
