import 'package:doa_sangue/View/AgendamentoPage.dart';
import 'package:flutter/material.dart';
import 'ConfiguracaoPage.dart';
import 'DoadorPage.dart';
import 'FaqPage.dart';

class PrincipalPage extends StatelessWidget {
  const PrincipalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: corpo(context),
    );
  }
}

Widget corpo(context) {
  return Scaffold(
    appBar: AppBar(
      title: Text("Tela Principal"),
      centerTitle: true,
      backgroundColor: Colors.red[400],
    ),
    drawer: Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountEmail: Text("rafael.fs.camaqua@gmail.com"),
            accountName: Text("Rafael"),
            decoration: BoxDecoration(
              color: const Color(0XFFEF5350),
            ),
            currentAccountPicture: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset("assets/pictures/profile-picture-menu.jpg"),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("Cadastro Doador/Solicitante"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CadastroPrincipalPage(),
                ),
              );
              //Navegar para outra página
            },
          ),
          ListTile(
            leading: Icon(Icons.calendar_today),
            title: Text("Agendamento doação sangue"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AgendamentoDoacaoPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.call_rounded),
            title: Text("FAQ"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FAQPage(),
                ),
              ); //Navegar para outra página
            },
          ),
          ListTile(
            leading: Icon(Icons.app_settings_alt),
            title: Text("Configuração"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ConfiguracaoPage(),
                ),
              );
            },
          ),
        ],
      ),
    ),
  );
}
