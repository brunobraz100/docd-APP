
import 'package:docd/providers/document_provider.dart';
import 'package:docd/providers/login_provider.dart';
import 'package:docd/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    LoginProvider _login = Provider.of<LoginProvider>(context, listen: false);
    DocumentProvider _document =
        Provider.of<DocumentProvider>(context, listen: false);
    _document.getDocuments(
        _login.userModel.idCliente!, _login.userModel.token!);

    return Consumer<DocumentProvider>(
      builder: (context, document, child) {
        void toDocuments() {
          Navigator.pushNamed(context, '/document');
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Bem-Vindo",
              style: AppTextStyles.textNormal,
            ),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Text(
                  textAlign: TextAlign.center,
                  "Seus de Documentos",
                  style: AppTextStyles.title,
                ),
              ),
              Container(
                width: const Size.fromWidth(double.infinity).width,
                height: 600,
                child: document.load
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.black,
                        ),
                      )
                    : ListView.builder(
                        itemCount: document.documents.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () async {
                              document.changeLoad(true);
                              await document.download(
                                _login.userModel.token!,
                                document.documents[index].idDocumento!,
                                document.documents[index].dsExtensao!,
                                _login.userModel.idCliente!,
                              );

                              if (document.archiveF != null &&
                                  document.documents[index].dsExtensao ==
                                      ".pdf") {
                                toDocuments();
                              } else {
                                OpenFile.open(document.archiveF!.path);
                              }
                            },
                            child: ListTile(
                              title: Row(
                                children: [
                                  Text(
                                    document.documents[index].dsDocumento
                                        .toString(),
                                    style: AppTextStyles.txtDoc,
                                  ),
                                  document.documents[index].dsExtensao! ==
                                          ".pdf"
                                      ? const Icon(Icons.picture_as_pdf)
                                      : const Icon(Icons.download)
                                ],
                              ),
                              subtitle: Text(
                                document.documents[index].dtValidade.toString(),
                                style: AppTextStyles.textNormal,
                              ),
                            ),
                          );
                        },
                      ),
              )
            ],
          ),
        );
      },
    );
  }
}
