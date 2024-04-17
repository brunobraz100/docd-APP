
import 'package:dio/dio.dart';
import 'package:docd/configs/constants.dart';
import 'package:docd/models/document_model.dart';
import 'package:flutter/material.dart';

class DocumentServices {
  Future<List<DocumentModel>> getDocuments(int idCliente, String token) async {
    List<DocumentModel> documents = [];
    try {
      final response = await Dio().get(
          "${Constants().url}documents/GetDocumentsByClient/$idCliente",
          options: Options(headers: {"Authorization": "Bearer $token"}));
      if (response.statusCode == 200) {
        dynamic list = (response.data as List);
        for (dynamic doc in list) {
          documents.add(DocumentModel.fromMap(doc));
        }
      }
    } catch (err) {
      debugPrint(err.toString());
    }
    return documents;
  }

  Future<List<int>> downloadDoc(
      String token, int idDocument, String extensao) async {
    List<int> bytes = [];
    try {
      final response = await Dio().get(
          "${Constants().url}documents/GetDocument/file/$idDocument/$extensao",
          options: Options(
            headers: {
              "Authorization": "Bearer $token",
            },
            responseType: ResponseType.bytes,
          ));
      if (response.statusCode == 200) {
        bytes = response.data as List<int>;
      }
    } catch (err) {
      debugPrint(err.toString());
    }
    return bytes;
  }

  Future<void> setDownloaded(int idCliente, String token) async {
    try {
      await Dio().put("${Constants().url}documents/SetDownload/$idCliente",
          options: Options(headers: {"Authorization": "Bearer $token"}));
    } catch (err) {
      debugPrint(err.toString());
    }
  }
}
