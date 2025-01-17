import 'package:cmedapp/src/Login/controller.dart';
import 'package:cmedapp/src/utils/authentication_service.dart';

import 'package:cmedapp/src/EsqueceuSenha/view.dart';
import 'package:cmedapp/src/widgets/alertDialog.dart';
import 'package:cmedapp/src/widgets/input.dart';
import 'package:cmedapp/src/widgets/logo.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  containerHeight(size) {
    double height;
    if (size.height < 600) {
      height = size.height * 0.65;
    } else if (size.width < 400 && size.height >= 640 && size.height < 800) {
      height = size.height * 0.70;
    } else {
      height = size.height * 0.65;
    }
    return height;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(30),
            child: Logo(),
          ),
          Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: containerHeight(size),
                  width: size.width * 0.9,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black54.withOpacity(0.5),
                          blurRadius: 5.0,
                          offset: Offset(0.0, 5.0))
                    ],
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                  ),
                  child: LoginArea(size: size),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class LoginArea extends StatefulWidget {
  const LoginArea({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  _LoginAreaState createState() => _LoginAreaState();
}

class _LoginAreaState extends State<LoginArea> {
  GlobalKey<FormState> formLoginKey = new GlobalKey();

  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerSenha = TextEditingController();

  @override
  // ignore: override_on_non_overriding_member
  void _showDialog(text) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Alert_Box(
            buttons: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        "/login", (Route<dynamic> route) => false);
                  },
                  child: Text("Voltar", style: TextStyle()))
            ],
            text: text,
          );
        });
  }

  Widget build(BuildContext context) {
///// conferir se os dados existem

    bool validateAndConfirm() {
      if (formLoginKey.currentState.validate()) {
        formLoginKey.currentState.save();
        return true;
      } else {
        return false;
      }
    }

    submitButton(size, context) {
      if (size.width > 300) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => EsqueceuSenha()));
                },
                child: Text(
                  "Esqueceu sua senha?",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                )),
            Column(
              children: [
                Container(
                  width: 100,
                  height: 45,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.tealAccent[700].withOpacity(0.5),
                          blurRadius: 5.0,
                          offset: Offset(0.0, 5.0))
                    ],
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                  ),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (validateAndConfirm()) {
                        var user = AuthenticationService();
                        var erro2 = await user.signIn(
                            email: controllerEmail.text.trim(),
                            password: controllerSenha.text.trim());
                        if (erro2 != "LogIn") {
                          _showDialog(
                            erro2,
                          );
                        } else {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              '/home', (Route<dynamic> route) => false);
                        }
                      }
                    },
                    child: Text("Entrar"),
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromRGBO(0, 191, 186, 1),
                      onPrimary: Colors.white,
                      onSurface: Colors.grey,
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (validateAndConfirm()) {
                      var user = AuthenticationService();
                      var erro2 = await user.signIn(
                          email: controllerEmail.text.trim(),
                          password: controllerSenha.text.trim());
                      if (erro2 != "LogIn") {
                        _showDialog(
                          erro2,
                        );
                      } else {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/admin', (Route<dynamic> route) => false);
                      }
                    }
                  },
                  child: Text("ADM"),
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(0, 191, 186, 1),
                    onPrimary: Colors.white,
                    onSurface: Colors.grey,
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (validateAndConfirm()) {
                      var user = AuthenticationService();
                      var erro2 = await user.signIn(
                          email: controllerEmail.text.trim(),
                          password: controllerSenha.text.trim());
                      if (erro2 != "LogIn") {
                        _showDialog(
                          erro2,
                        );
                      } else {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/clinica', (Route<dynamic> route) => false);
                      }
                    }
                  },
                  child: Text("Clínica"),
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(0, 191, 186, 1),
                    onPrimary: Colors.white,
                    onSurface: Colors.grey,
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      } else {
        return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 150,
                height: 45,
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.tealAccent[700].withOpacity(0.5),
                        blurRadius: 5.0,
                        offset: Offset(0.0, 5.0))
                  ],
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/home', (Route<dynamic> route) => false);
                  },
                  child: Text("Entrar"),
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(0, 191, 186, 1),
                    onPrimary: Colors.white,
                    onSurface: Colors.grey,
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => EsqueceuSenha()));
                  },
                  child: Text(
                    "Esqueci minha senha?",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  )),
            ]);
      }
    }

    return Form(
      key: formLoginKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40, right: 35, left: 35),
            child: Container(
              margin: EdgeInsets.only(bottom: 40),
              child: Text(
                "Seja bem-vindo(a) de volta",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(right: 14, left: 14),
              child: Container(
                height: 55,
                //// criar formulario
                child: Input(
                  label: "Email",
                  hint: "exemplo@dominio.com",
                  senha: false,
                  validador: validaremail,
                  controlador: controllerEmail,
                ),
              )),
          SizedBox(
            height: 20,
          ),
          Padding(
              padding: const EdgeInsets.only(top: 5, right: 14, left: 14),
              child: Container(
                height: 55,
                ////criar formulario
                child: Input(
                  label: "Senha",
                  hint: "No mínimo 8 dígitos",
                  senha: true,
                  validador: validarsenha,
                  controlador: controllerSenha,
                ),
              )),
          Padding(
              padding: const EdgeInsets.all(20),
              child: submitButton(widget.size, context))
        ],
      ),
    );
  }
}
