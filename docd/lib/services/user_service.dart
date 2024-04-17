import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:docd/configs/constants.dart';
import 'package:docd/models/user_model.dart';
import 'package:flutter/material.dart';

class UserServices {
  Future<UserModel> login(String username, String password) async {
    UserModel user = UserModel();
    bool complete = false;
    try {
      final response = await Dio().post(
        "${Constants().url}access/LoginCustomer",
        data: jsonEncode(
          {
            "nmCnpj": int.parse(username),
            "dsSenha": password,
          },
        ),
      );
      if (response.statusCode == 200) {
        user = UserModel.fromMap(response.data);
        complete = true;
      }
    } catch (err) {
      debugPrint(err.toString());
    }

    return user;
  }
}
