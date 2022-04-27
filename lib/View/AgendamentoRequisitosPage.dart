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
            requisitoDoar("Estar alimentado. Evite alimentos gordurosos nas 3 horas que antecedem a doação de sangue."),
            requisitoDoar("Caso seja após o almoço, aguardar 2 horas."),
            requisitoDoar("Ter dormido pelo menos 6 horas nas últimas 24 horas."),
            requisitoDoar("Pessoas com idade entre 60 e 69 anos só poderão doar sangue se já o tiverem feito antes dos 60 anos."),
            requisitoDoar(
                "A frequência máxima é de quatro doações de sangue anuais para o homem e de três doações de sangue anuais para as mulher."),
            requisitoDoar(
                "O intervalo mínimo entre uma doação de sangue e outra é de dois meses para os homens e de três meses para as mulheres."),
            requisitoDoar("Não estár com Gripe, resfriado e febre: aguardar 7 dias após o desaparecimento dos sintomas;"),
            requisitoDoar("Não estár com Período gestacional"),
            requisitoDoar("Não estár com Período pós-gravidez: 90 dias para parto normal e 180 dias para cesariana"),
            requisitoDoar("Não estár com Amamentação: até 12 meses após o parto"),
            requisitoDoar("Não estár com Ingestão de bebida alcoólica nas 12 horas que antecedem a doação"),
            requisitoDoar(
                "Não estár com Tatuagem e/ou piercing nos últimos 12 meses (piercing em cavidade oral ou região genital impedem a doação);"),
            requisitoDoar("Não estár com Extração dentária: 72 horas"),
            requisitoDoar("Não estár com Apendicite, hérnia, amigdalectomia, varizes: 3 meses"),
            requisitoDoar(
                "Não estár com Colecistectomia, histerectomia, nefrectomia, redução de fraturas, politraumatismos sem seqüelas graves, tireoidectomia, colectomia: 6 meses"),
            requisitoDoar("Não estár com Transfusão de sangue: 1 ano"),
            requisitoDoar("Não estár com Exames/procedimentos com utilização de endoscópio nos últimos 6 meses"),
            requisitoDoar(
                "Não estár com Ter sido exposto a situações de risco acrescido para infecções sexualmente transmissíveis (aguardar 12 meses após a exposição)"),
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
