import 'package:doa_sangue/Connection/DAO/AgendamentoDAO.dart';
import 'package:doa_sangue/Controller/Validators.dart';
import 'package:doa_sangue/Model/Agendamento.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AgendamentoPage extends StatefulWidget {
  int idUsuario;
  String NomeUsuario;
  int idDoador;
  int idAgendamento;
  AgendamentoPage(this.idUsuario, this.NomeUsuario, this.idDoador, this.idAgendamento);

  @override
  State<AgendamentoPage> createState() => _AgendamentoPageState();
}

class _AgendamentoPageState extends State<AgendamentoPage> {
  final _formKey = GlobalKey<FormState>();
  Agendamento _agendamento = Agendamento();
  String _dropdownSitValue = 'Bem';
  String _dropdownStatusValue = 'Pendente';
  List<String> _sitSaude = ['Bem', 'Ruim'];
  List<String> _status = ['Pendente', 'Concluida'];
  TextEditingController _nomeController = TextEditingController();
  TextEditingController _idadeController = TextEditingController();
  bool _agendamentoExiste = false;

  TextEditingController _idade = TextEditingController();

  Future _carregaCamposAgendamento() async {
    if (widget.idAgendamento > 0) {
      _agendamento.id = await AgendamentoDAO.returnDoadorId(widget.idUsuario);
      _agendamentoExiste = _agendamento.id > 0;
    }

    if (_agendamentoExiste) {
      await AgendamentoDAO.searchId(_agendamento);
      _idadeController.text = _agendamento.idade.toString();
      _dropdownSitValue = _agendamento.sit_saude;
      _dropdownStatusValue = _agendamento.status;
    }

    print(_agendamento);
  }

  Future _cadastrarAgendamento() async {
    if (_idadeController.text != "") {
      _agendamento.idade = int.parse(_idadeController.text);
    }
    _agendamento.status = _dropdownStatusValue;
    _agendamento.sit_saude = _dropdownSitValue;
    _agendamento.id_usuario = widget.idUsuario;
    _agendamento.id_doador = widget.idDoador;

    if (_agendamentoExiste) {
      AgendamentoDAO.update(_agendamento);
    } else {
      AgendamentoDAO.insert(_agendamento);
    }

    Navigator.pop(context, false);
  }

  barraSuperior() {
    return AppBar(
      title: Text("Tela Cadastro de Agendamento"),
      centerTitle: true,
      backgroundColor: Colors.red[400],
    );
  }

  @override
  void initState() {
    super.initState();
    _carregaCamposAgendamento().then;
    setState(() {});
  }

  Widget corpo(context) {
    _nomeController.text = widget.NomeUsuario;
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.only(top: 10, left: 40, right: 40),
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            TextFormField(
              enabled: false,
              controller: _nomeController,
              inputFormatters: [
                LengthLimitingTextInputFormatter(50),
              ],
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Nome Usuário/Doador",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                ),
              ),
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            TextFormField(
              validator: Validators.required('Idade não pode ficar em branco.'),
              autofocus: true,
              enabled: true,
              controller: _idade,
              inputFormatters: [LengthLimitingTextInputFormatter(50), FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Idade",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                ),
              ),
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                filled: true,
                labelText: 'Situação saúde',
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              value: _dropdownSitValue,
              // icon: const Icon(Icons.),
              elevation: 16,
              style: const TextStyle(color: Colors.black38),
              onChanged: (String? newValue) {
                setState(() {
                  _dropdownSitValue = newValue!;
                  // _sitSaude = _dropdownSitValue;
                });
              },
              items: _sitSaude.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                filled: true,
                labelText: 'Status',
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              value: _dropdownStatusValue,
              // icon: const Icon(Icons.),
              elevation: 16,
              style: const TextStyle(color: Colors.black38),
              onChanged: (String? newValue) {
                setState(() {
                  _dropdownStatusValue = newValue!;
                  // _tipoDoador = _montaTelaDeAcordoComTipoCadastro(_dropdownTipoValue)!;
                });
              },
              items: _status.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 60,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: Color(0XFFEF5350),
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: SizedBox.expand(
                child: TextButton(
                  child: Text(
                    "Cadastrar/Alterar",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _cadastrarAgendamento();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Erro! Existem campos em branco ou preenchidos incorretamente.')),
                      );
                    }
                  },
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 40,
              alignment: Alignment.center,
              child: TextButton(
                child: Text(
                  "Cancelar",
                  textAlign: TextAlign.center,
                ),
                onPressed: () => Navigator.pop(context, false),
              ),
            ),
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
