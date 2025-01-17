import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:cmedapp/src/ConsultaMarcada/widgets/label_consulta_marcada.dart';
import 'package:cmedapp/src/ConsultaMarcada/model.dart';
import 'package:cmedapp/src/ConsultaMarcada/widgets/text_consulta_confirmada.dart';

import 'package:cmedapp/src/utils/globals.dart' as globals;
import 'package:cmedapp/src/widgets/app_bar.dart';
import 'package:cmedapp/src/widgets/button_padrao.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ConsultaMarcada extends StatefulWidget {
  @override
  _ConsultaMarcadaState createState() => _ConsultaMarcadaState();
}

class _ConsultaMarcadaState extends State<ConsultaMarcada> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(size.height * 0.10),
        child: AppBar2(),
      ),
      body: BodyConsultaMarcada(),
    );
  }
}

class BodyConsultaMarcada extends StatelessWidget {
  const BodyConsultaMarcada({
    Key key,
  }) : super(key: key);

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("medicos")
            .doc(globals.medicoId)
            .snapshots(),
        builder: (context, snapshots) {
          if (snapshots.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            Map<dynamic, dynamic> medico = snapshots.data.data();
            return Container(
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
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: LabelConsultaMarcada(),
                  ),
                  Spacer(),
                  TextConsultaConfirmada(
                    nome: medico["nome"],
                    sobrenome: medico["sobrenome"],
                    horario:
                        "${medico['inicioExpediente']}h ás ${medico['fimExpediente']}h",
                    dia: globals.diaDaConsulta,
                    especialidade: medico["especialidade"],
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: ButtonPadrao(
                      text: "Confirmar consulta",
                      press: () {
                        MarcarConsulta(
                                globals.diaDaConsulta,
                                medico["nome"],
                                medico["sobrenome"],
                                medico["especialidade"],
                                medico["email"],
                                medico['inicioExpediente'],
                                medico['fimExpediente'],
                                medico["url"])
                            .addConsulta(
                                FirebaseAuth.instance.currentUser.email);
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            "/home", (Route<dynamic> route) => false);
                      },
                    ),
                  )
                ],
              ),
            );
          }
        });
  }
}
