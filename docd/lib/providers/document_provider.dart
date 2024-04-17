import 'dart:io';

import 'package:docd/models/document_model.dart';
import 'package:docd/services/document_services.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class DocumentProvider extends ChangeNotifier {
  List<DocumentModel> _documents = [];
  bool _load = false;
  DocumentServices documentServices = DocumentServices();
  List<int> _bytes = [];
  File? _file;

  List<DocumentModel> get documents => _documents;
  bool get load => _load;
  List<int> get bytes => _bytes;
  File? get archiveF => _file;

  changeLoad(bool value) {
    _load = value;
    notifyListeners();
  }

  setBytes(List<int> value) {
    _bytes = value;
    notifyListeners();
  }

  Future<void> download(
      String token, int idDocument, String extension, int idCliente) async {
    _load = true;
    _bytes = await documentServices.downloadDoc(token, idDocument, extension);
    Directory documentsPath = await getApplicationDocumentsDirectory();
    File archive = File("${documentsPath.path}/$idDocument$extension");
    await archive.writeAsBytes(_bytes);
    _file = archive;
    await documentServices.setDownloaded(idCliente, token);
    _load = false;
    notifyListeners();
  }

  Future<void> getDocuments(int idCliente, String token) async {
    var status = await Permission.storage.isGranted;
    if (!status) {
      await Permission.storage.request();
    }
    _load = true;
    _documents = await documentServices.getDocuments(idCliente, token);
    _load = false;
    notifyListeners();
  }
}
