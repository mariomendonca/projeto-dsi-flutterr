import 'package:cmedapp/src/AllDoctors/all_doctors.dart';
import 'package:cmedapp/src/CadastroMed/view/cadastro_med_p1.dart';
import 'package:cmedapp/src/CadastroPac/view.dart';
import 'package:cmedapp/src/EsqueceuSenha.dart';
import 'package:cmedapp/src/Home/Home.dart';
import 'package:cmedapp/src/login_page.dart';
import 'package:cmedapp/src/SecondPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cmedapp/src/FirstPage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'C-MED',
        theme: ThemeData(
            primaryColor: Colors.tealAccent[700], fontFamily: 'Inter'),
        routes: {
          "/homePage": (context) => MyHomePage(),
          "/secondPage": (context) => SecondPage(),
          "/cadastroPac": (context) => CadastroPac(),
          "/cadastroMed1": (context) => CadastroMed(),
          "/login": (context) => Login(),
          "/home": (context) => Home(),
          "/esqueceuSenha": (context) => EsqueceuSenha(),
          "/doctors": (context) => AllDoctors(),
        },
        home: MyHomePage());
  }
}
