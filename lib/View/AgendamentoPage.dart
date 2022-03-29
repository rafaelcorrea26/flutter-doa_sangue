import 'package:flutter/material.dart';

class AgendamentoDoacaoPage extends StatelessWidget {
  const AgendamentoDoacaoPage({ Key? key }) : super(key: key);



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: corpo(context),
      appBar: barraSuperior(),
    );
  }}
barraSuperior() {
  return AppBar(
    title: Text("Tela agendamento de doação"),
    centerTitle: true,
    backgroundColor: Colors.red[400],
  );
}

Widget corpo(context) {
  return Container(
    color: Colors.white,
    child: Column(
      children:  [
      ],
    ),
  );
}

