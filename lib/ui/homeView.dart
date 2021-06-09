import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:untitled/core/appBar.dart';
import 'package:untitled/ui/loginView.dart';

// ignore: must_be_immutable
class HomeView extends StatefulWidget {
  String userFirebase;
  HomeView(this.userFirebase);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  var userFirebaseController = TextEditingController();

  void initState() {
    super.initState();
    userFirebaseController.addListener(onUserFirebaseController);
    userFirebaseController.text = widget.userFirebase;
  }

  void onUserFirebaseController() {
    print("chamou na mudança");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlicetecAppBar(title: 'GLICETEC'),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Bem-vindo a Glicetec!',
                  style: TextStyle(color: Colors.black, fontSize: 30),
                ),
              ],
            )
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
              ),
              child: Text('Usuário: '),
            ),
            ListTile(
              title: Text('Configurações'),
              onTap: () {},
            ),
            ListTile(
              title: Text('Informações do Usuário'),
              onTap: () {},
            ),
            ListTile(
              title: Text('Idioma'),
              onTap: () {},
            ),
            ListTile(
              title: Text('Segurança'),
              onTap: () {},
            ),
            ListTile(
              title: Text('Logs'),
              onTap: () {},
            ),
            ListTile(
              title: Text('Bloquear Acesso'),
              onTap: () {},
            ),
            ListTile(
              title: Text('Regras'),
              onTap: () {},
            ),
            ListTile(
              title: Text('Gráficos'),
              onTap: () {},
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                    onPressed: () {
                      logout(); //chamar logout
                    },
                    child: Text(
                      'Sair',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 180,
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Versão 1.0.0 - Flutter Mobile App'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  logout() async {
    Navigator.of(context).pop();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginView()));
  }
}
