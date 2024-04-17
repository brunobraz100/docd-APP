import 'dart:convert';

class DocumentModel {
  int? idDocumento = 0;
  int? idCategoria = 0;
  String? dsDocumento;
  String? dsCategoria;
  String? dsExtensao;
  DateTime? dtCarga;
  DateTime? dtValidade;
  int? idCliente = 0;

  DocumentModel({
    this.idDocumento,
    this.idCategoria,
    this.dsDocumento,
    this.dsCategoria,
    this.dsExtensao,
    this.dtCarga,
    this.dtValidade,
    this.idCliente,
  });

  Map<String, dynamic> toMap() => {
        "idDocumento": idDocumento,
        "idCategoria": idCategoria,
        "dsDocumento": dsDocumento,
        "dsCategoria": dsCategoria,
        "dsExtensao": dsExtensao,
        "dtCarga": dtCarga,
        "dtValidade": dtValidade,
        "idCliente": idCliente,
      };

  String toJson() => jsonEncode(toMap());

  factory DocumentModel.fromMap(Map<String, dynamic> map) {
    return DocumentModel(
      idDocumento: map["idDocumento"],
      idCategoria: map["idCategoria"],
      dsDocumento: map["dsDocumento"],
      dsCategoria: map["dsCategoria"],
      dsExtensao: map["dsExtensao"],
      dtCarga: DateTime.parse(map["dtCarga"]),
      dtValidade: DateTime.parse(map["dtValidade"]),
      idCliente: (map["idCliente"]),
    );
  }

  factory DocumentModel.fromJson(String json) =>
      DocumentModel.fromMap(jsonDecode(json));
}
