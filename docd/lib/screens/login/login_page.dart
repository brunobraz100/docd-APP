import 'package:docd/providers/login_provider.dart';
import 'package:docd/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<LoginProvider>(
        builder: (((context, login, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 200),
                  child: Text(
                    textAlign: TextAlign.center,
                    "HVL",
                    style: AppTextStyles.title,
                  ),
                ),
                Text(
                  "Login",
                  style: AppTextStyles.title,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    onChanged: (value) {
                      login.changeUser(value);
                    },
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.go,
                    decoration: const InputDecoration(
                      hintText: "CNPJ",
                      labelText: "CNPJ",
                      prefixIcon: Icon(
                        Icons.person,
                        color: Color.fromARGB(255, 62, 61, 61),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    onChanged: (value) {
                      login.changePassword(value);
                    },
                    obscureText: login.visible,
                    textInputAction: TextInputAction.go,
                    decoration: InputDecoration(
                      hintText: "Senha",
                      labelText: "Senha",
                      suffixIcon: IconButton(
                        onPressed: () {
                          login.changeVisibility(!login.visible);
                        },
                        icon: const Icon(
                          Icons.visibility,
                          color: Color.fromARGB(255, 62, 61, 61),
                        ),
                      ),
                      prefixIcon: const Icon(
                        Icons.password,
                        color: Color.fromARGB(255, 62, 61, 61),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: login.load
                      ? const CircularProgressIndicator(
                          color: Color.fromARGB(255, 62, 61, 61),
                        )
                      : Container(
                          width: const Size.fromWidth(double.infinity).width,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 62, 61, 61),
                            ),
                            child: Text(
                              "Entrar",
                              style: AppTextStyles.textNormalWhite,
                            ),
                            onPressed: () async {
                              login.changeLoad(true);
                              await login.login();
                              if (login.userModel.token != null) {
                                login.changeLoad(false);
                                Navigator.pushReplacementNamed(
                                    context, "/home");
                              }
                              login.changeLoad(false);
                            },
                          ),
                        ),
                ),
              ],
            ),
          );
        })),
      ),
    );
  }
}
