import 'dart:convert';

class UserModel {
  int? idCliente;
  int? nmCnpj;
  String? token;

  UserModel({
    this.nmCnpj,
    this.token,
    this.idCliente,
  });

  Map<String, dynamic> toMap() => {
        "nmCnpj": nmCnpj,
        "token": token,
        "idCliente": idCliente,
      };

  String toJson() => jsonEncode(toMap());

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      nmCnpj: map["nmCnpj"],
      token: map["token"],
      idCliente: map["idCliente"],
    );
  }

  factory UserModel.fromJson(String json) =>
      UserModel.fromMap(jsonDecode(json));
}
