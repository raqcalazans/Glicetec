import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:untitled/core/appBar.dart';
import 'package:untitled/ui/homeView.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

Future<String?> signInWithGoogle() async {
  await Firebase.initializeApp();
  final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount!.authentication;

  final AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final UserCredential authResult =
      await _auth.signInWithCredential(credential);
  final User? user = authResult.user;

  if (user != null) {
    assert(!user.isAnonymous);

    final User? currentUser = _auth.currentUser;
    assert(user.uid == currentUser!.uid);

    print('signInWithGoogle succeeded: $user');

    return '$user';
  }

  return null;
}

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String userFirebase = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlicetecAppBar(title: 'Bem-vindo!'),
      body: Padding(
        padding: EdgeInsets.only(left:20.0, top: 0.0, right: 20.0, bottom: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'GLICETEC',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(
                      FontAwesomeIcons.userMd,
                    ),
                    onPressed: null,
                    iconSize: 150,
                    color: Colors.blue,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      child: Text(
                        'Seu assistente médico pessoal',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                        ),
                      ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.horizontal(),
                  border: Border.all(
                    color: Colors.black,
                    width: 1,
                  ),
                ),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'E-mail',
                    contentPadding: EdgeInsets.all(10),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.horizontal(),
                  border: Border.all(
                    color: Colors.black,
                    width: 1,
                  ),
                ),
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Senha',
                    contentPadding: EdgeInsets.all(10),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Text(
                    'Esqueci minha senha?',
                    style: TextStyle(
                        color: Colors.blue, decoration: TextDecoration.underline),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.only(left: 200, right: 200, top: 0),
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.blueAccent),
                  child: Text('Acessar'),
                  onPressed: () {
                    try {
                      signInWithGoogle().then((result) {
                        if (result != null) {
                          print('userFirebase' + userFirebase);
                          Navigator.of(context).pop();
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return HomeView(userFirebase);
                          }));
                        }
                      });
                    } on SocketException catch (_) {
                      print('deu socketException');
                    }
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text('Novo Usuário : '),
                  SizedBox(
                    height: 10,
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      try {
                        signInWithGoogle().then((result) {
                          if (result != null) {
                            Navigator.of(context).pop();
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return HomeView(userFirebase);
                            }));
                          }
                        });
                      } on SocketException catch (_) {
                        print('deu socketException');
                      }
                    },
                    style: ElevatedButton.styleFrom(primary: Colors.white),
                    child: Text(
                      'Cadastre-se',
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
