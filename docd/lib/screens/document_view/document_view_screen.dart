import 'dart:typed_data';

import 'package:docd/providers/document_provider.dart';
import 'package:docd/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:provider/provider.dart';

class DocumentViewScreen extends StatefulWidget {
  const DocumentViewScreen({super.key});

  @override
  State<DocumentViewScreen> createState() => _DocumentViewScreenState();
}

class _DocumentViewScreenState extends State<DocumentViewScreen> {
  @override
  Widget build(BuildContext context) {
    viewPdf(Uint8List data) {
      try {
        return PDFView(
          filePath: null,
          pdfData: data,
          enableSwipe: true,
        );
      } catch (err) {
        debugPrint(err.toString());
      }
    }

    return Consumer<DocumentProvider>(
      builder: (context, document, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Documento",
              style: AppTextStyles.textNormal,
            ),
          ),
          body: document.archiveF != null
              ? viewPdf(Uint8List.fromList(document.bytes))
              : Center(
                  child: Text(
                    "Documento não pode ser exibido!",
                    style: AppTextStyles.textNormal,
                  ),
                ),
        );
      },
    );
  }
}
