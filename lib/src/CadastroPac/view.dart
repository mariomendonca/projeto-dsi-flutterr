import 'package:brasil_fields/brasil_fields.dart';
import 'package:cmedapp/src/utils/authentication_service.dart';

import 'package:cmedapp/src/CadastroPac/controller.dart';
import 'package:cmedapp/src/CadastroPac/model.dart';
import 'package:cmedapp/src/widgets/appbar_with_logo.dart';
import 'package:cmedapp/src/widgets/button_padrao.dart';
import 'package:cmedapp/src/widgets/input.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'controller.dart';

class CadastroPac extends StatefulWidget {
  @override
  CadastroPacState createState() => CadastroPacState();
}

class CadastroPacState extends State<CadastroPac> {
  GlobalKey<FormState> _formKey = new GlobalKey();
  final TextEditingController controllerNome = TextEditingController();
  final TextEditingController controllerSobrenome = TextEditingController();
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerSenha = TextEditingController();
  final TextEditingController controllerCell = TextEditingController();
  final TextEditingController controllerCpf = TextEditingController();
  final TextEditingController controllerConfirmPass = TextEditingController();
  bool validateAndSave() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      return true;
    } else {
      return false;
    }
  }

  void registerUser() {
    var user = AuthenticationService();
    Pacientes(
      controllerNome.text.trim(),
      controllerSobrenome.text.trim(),
      controllerCell.text.trim(),
      controllerCpf.text.trim(),
      controllerSenha.text.trim(),
      controllerEmail.text.trim(),
    ).addInfo(controllerEmail.text.trim());
    user.signUp(
        email: controllerEmail.text.trim(),
        password: controllerSenha.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(size.height * 0.3),
        child: MyAppBar(),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(
                  40,
                ),
                topRight: Radius.circular(40)),
            color: Colors.white,
          ),
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 22, right: 14, left: 14),
                child: Input(
                  label: "Nome",
                  hint: "Digite seu nome",
                  senha: false,
                  validador: validarnome,
                  controlador: controllerNome,
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(top: 22, right: 14, left: 14),
                child: Input(
                  label: "Sobrenome",
                  hint: "Digite seu nome",
                  senha: false,
                  validador: validarsobrenome,
                  controlador: controllerSobrenome,
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(top: 22, right: 14, left: 14),
                child: Input(
                  label: "Email",
                  hint: "exemplo@dominio.com",
                  senha: false,
                  validador: validaremail,
                  controlador: controllerEmail,
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(top: 22, right: 14, left: 14),
                child: Input(
                  mascara: [
                    FilteringTextInputFormatter.digitsOnly,
                    CpfInputFormatter()
                  ],
                  label: "CPF",
                  hint: "Apenas os números",
                  senha: false,
                  tipodeteclado: TextInputType.number,
                  validador: validarcpf,
                  controlador: controllerCpf,
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(top: 22, right: 14, left: 14),
                child: Input(
                  mascara: [
                    FilteringTextInputFormatter.digitsOnly,
                    TelefoneInputFormatter(),
                  ],
                  label: "Telefone",
                  hint: "(81)99999-9999",
                  senha: false,
                  validador: validarcelular,
                  controlador: controllerCell,
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(top: 22, right: 14, left: 14),
                child: Input(
                  label: "Senha",
                  hint: "No mínimo 8 dígitos",
                  senha: true,
                  validador: validarsenha,
                  controlador: controllerSenha,
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(top: 22, right: 14, left: 14),
                child: Input(
                  label: "Confirmar senha",
                  hint: "Confirme sua senha",
                  senha: true,
                  validador: confirmarSenha,
                  controlador: controllerConfirmPass,
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(top: 26, right: 14, left: 14),
                child: ButtonPadrao(
                  text: "Finalizar",
                  press: () {
                    validateAndSave();

                    if (validateAndSave()) {
                      registerUser();
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/homePage', (Route<dynamic> route) => false);
                    }

                    // final isValid = formKey.currentState.validate();
                  },
                ),
              ),
              Spacer()
            ],
          ),
        ),
      ),
    );
  }
}
