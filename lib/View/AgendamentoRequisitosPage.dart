import 'package:doa_sangue/Model/Agendamento.dart';
import 'package:doa_sangue/View/AgendamentoPage.dart';
import 'package:flutter/material.dart';

class AgendamentoRequisitosPage extends StatefulWidget {
  String NomeUsuario;
  Agendamento agendamento;

  AgendamentoRequisitosPage(this.NomeUsuario, this.agendamento);

  @override
  State<AgendamentoRequisitosPage> createState() => _AgendamentoRequisitosPageState();
}

class _AgendamentoRequisitosPageState extends State<AgendamentoRequisitosPage> {
  final _formKey = GlobalKey<FormState>();
  bool checkboxValue = false;

  barraSuperior() {
    return AppBar(
      title: Text("Requisitos para Agendamento"),
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
              builder: (context) => AgendamentoPage(widget.NomeUsuario, false, widget.agendamento),
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

  headerRequisitoDoar(requisito) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Center(
          child: Text(
            requisito,
            style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.normal, fontFamily: 'Poppins'),
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
            headerRequisitoDoar("Recomendações:"),
            requisitoDoar("Estar alimentado. Evite alimentos gordurosos nas 3 horas que antecedem a doação de sangue."),
            requisitoDoar("Caso seja após o almoço, aguardar 2 horas."),
            requisitoDoar("Ter dormido pelo menos 6 horas nas últimas 24 horas."),
            requisitoDoar("Pessoas com idade entre 60 e 69 anos só poderão doar sangue se já o tiverem feito antes dos 60 anos."),
            requisitoDoar(
                "A frequência máxima é de quatro doações de sangue anuais para o homem e de três doações de sangue anuais para as mulher."),
            requisitoDoar(
                "O intervalo mínimo entre uma doação de sangue e outra é de dois meses para os homens e de três meses para as mulheres."),
            headerRequisitoDoar("Impedimentos:"),
            requisitoDoar("Resfriado e febre: aguardar 7 dias após o desaparecimento dos sintomas;"),
            requisitoDoar("Período gestacional"),
            requisitoDoar("Período pós-gravidez: 90 dias para parto normal e 180 dias para cesariana"),
            requisitoDoar("Amamentação: até 12 meses após o parto"),
            requisitoDoar("Ingestão de bebida alcoólica nas 12 horas que antecedem a doação"),
            requisitoDoar(
                "Tatuagem e/ou piercing nos últimos 12 meses (piercing em cavidade oral ou região genital impedem a doação);"),
            requisitoDoar("Extração dentária: 72 horas"),
            requisitoDoar("Apendicite, hérnia, amigdalectomia, varizes: 3 meses"),
            requisitoDoar(
                "Colecistectomia, histerectomia, nefrectomia, redução de fraturas, politraumatismos sem seqüelas graves, tireoidectomia, colectomia: 6 meses"),
            requisitoDoar("Transfusão de sangue  a menos de  1 ano da data que deseja doar"),
            requisitoDoar("Exames/procedimentos com utilização de endoscópio nos últimos 6 meses"),
            requisitoDoar(
                "Ter sido exposto a situações de risco acrescido para infecções sexualmente transmissíveis (aguardar 12 meses após a exposição)"),
            headerRequisitoDoar("Quais são os impedimentos definitivos para doar sangue?"),
            requisitoDoar("Ter passado por um quadro de hepatite após os 11 anos de idade"),
            requisitoDoar(
                "Evidencia clinica ou laboratorial das seguintes doenças de sangue: Hepatites B e C, AIDS( virus HIV), doenças associadas aos virus HTLV I e II e doença de chagas"),
            requisitoDoar("Uso de drogas ilícitas injetáveis e malaria. "),
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
