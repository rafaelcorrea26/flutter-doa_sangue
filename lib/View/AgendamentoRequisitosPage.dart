import 'package:doa_sangue/View/AgendamentoPage.dart';
import 'package:flutter/material.dart';

class AgendamentoRequisitosPage extends StatefulWidget {
  int idUsuario;
  String NomeUsuario;
  int idDoador;
  AgendamentoRequisitosPage(this.idUsuario, this.NomeUsuario, this.idDoador);

  @override
  State<AgendamentoRequisitosPage> createState() => _AgendamentoRequisitosPageState();
}

class _AgendamentoRequisitosPageState extends State<AgendamentoRequisitosPage> {
  final _formKey = GlobalKey<FormState>();
  bool checkboxValue = false;

  barraSuperior() {
    return AppBar(
      title: Text("Tela Agendamento"),
      centerTitle: true,
      backgroundColor: Colors.red[400],
    );
  }

  Widget aceitaTermos(context) {
    return FormField<bool>(
      builder: (state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Checkbox(
                    value: checkboxValue,
                    onChanged: (value) {
                      setState(() {
                        checkboxValue = value!;
                        state.didChange(value);
                      });
                    }),
                Text(
                  'Confirmo que estou apto a fazer a doação.',
                  style: TextStyle(fontSize: 14, height: 0.6, color: Colors.black),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
            Text(
              state.errorText ?? '',
              style: TextStyle(
                color: Theme.of(context).errorColor,
              ),
            )
          ],
        );
      },
      validator: (value) {
        if (!checkboxValue) {
          return 'Você precisa aceitar os termos';
        } else {
          return null;
        }
      },
    );
  }

  botaoContinuar() {
    return TextButton(
      child: const Text(
        "Continuar",
        textAlign: TextAlign.center,
      ),
      onPressed: () {
        if (checkboxValue) {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AgendamentoPage(widget.idDoador, widget.NomeUsuario, widget.idDoador, 0),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Erro!Doador deve ser criado antes de utilizar a tela de agendamentos.')),
          );
        }
      },
    );
  }

  requisitoDoar(requisito) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Center(
          child: Text(
            requisito,
            style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.normal, fontFamily: 'Poppins'),
          ),
        ),
      ),
    );
  }

  Widget corpo(context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.only(top: 10, left: 40, right: 40),
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            requisitoDoar("1"),
            requisitoDoar("2"),
            requisitoDoar("3"),
            requisitoDoar("4"),
            requisitoDoar("5"),
            requisitoDoar("6"),
            requisitoDoar("7"),
            requisitoDoar("8"),
            requisitoDoar("9"),
            requisitoDoar("10"),
            requisitoDoar("11"),
            requisitoDoar("12"),
            requisitoDoar("13"),
            requisitoDoar("14"),
            requisitoDoar("15"),
            requisitoDoar("16"),
            requisitoDoar("17"),
            requisitoDoar("18"),
            requisitoDoar("19"),
            requisitoDoar("20"),
            aceitaTermos(context),
            botaoContinuar(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: corpo(context), appBar: barraSuperior());
  }
}
