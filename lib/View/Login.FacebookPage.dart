import 'package:flutter/material.dart';

class FacebookPage extends StatelessWidget {
  const FacebookPage({ Key? key }) : super(key: key);



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
    title: Text("Tela Login Facebook"),
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

