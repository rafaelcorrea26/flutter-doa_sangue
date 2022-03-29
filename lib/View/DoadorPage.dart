import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:doa_sangue/Model/Doador.dart';
import 'package:image_picker/image_picker.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:doa_sangue/Connection/DAO/DoadorDAO.dart';

class CadastroPrincipalPage extends StatefulWidget {
  const CadastroPrincipalPage();

  @override
  _CadastroDoadorPage createState() => _CadastroDoadorPage();
}

class _CadastroDoadorPage extends State<CadastroPrincipalPage> {
  // variaveis globais
  Doador _doador = Doador();
  var CaminhoImagem = "assets/pictures/profile-picture.jpg";
  bool _tipoDoador = false;
  File? _arquivo;
  TextEditingController _nomeController = TextEditingController();
  TextEditingController _nome_maeController = TextEditingController();
  TextEditingController _nome_paiController = TextEditingController();
  TextEditingController _data_nascController = TextEditingController();
  TextEditingController _cpfController = TextEditingController();
  TextEditingController _rgController = TextEditingController();
  TextEditingController _celularController = TextEditingController();
  TextEditingController _id_carteiraController = TextEditingController();
  TextEditingController _email_doadorController = TextEditingController();
  TextEditingController _email_solicitanteController = TextEditingController();
  TextEditingController _local_internacaoController = TextEditingController();
  TextEditingController _motivoController = TextEditingController();
  TextEditingController _qtd_bolsasController = TextEditingController();
  String _dropdownTipoValue = 'Doador';
  String _dropdownGenValue = 'Outro';
  String _dropdownSangValue = 'A+';
  String _dropdownUFValue = 'RS';

  List<String> _tipo_Doador = ['Doador', 'Solicitante', 'Ambos'];
  List<String> _genero = ['Masculino', 'Feminino', 'Outro'];
  List<String> _tipo_Sangue = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];
  List<String> _estado = [
    'AC',
    'AL',
    'AM',
    'AP',
    'BA',
    'CE',
    'DF',
    'ES',
    'FN',
    'GO',
    'MA',
    'MG',
    'MS',
    'MT',
    'PA',
    'PB',
    'PE',
    'PI',
    'PR',
    'RJ',
    'RN',
    'RO',
    'RR',
    'RS',
    'SC',
    'SE',
    'SP',
    'TO'
  ];

  // Functions
  String? _verificarCaminhoImagem() {
    if (_arquivo == null) {
      return CaminhoImagem;
    } else {
      return _arquivo?.path;
    }
  }

  _CadastroDoadorPage();

  @override
  void initState() {
    super.initState();
    _carregaCamposDoador();
  }

  _carregaCamposDoador() async {
    _doador.id = 1;
    await DoadorDAO.searchId(_doador);

    //   print(_doador.toString());
    if (_doador.nome_completo != "") {
      _nomeController.text = _doador.nome_completo;
      _nome_maeController.text = _doador.nome_mae;
      _nome_paiController.text = _doador.nome_pai;
      _dropdownGenValue = _doador.genero;
      _data_nascController.text = _doador.data_nasc;
      _cpfController.text = _doador.cpf;
      _rgController.text = _doador.rg;
      _celularController.text = _doador.celular;
      _dropdownSangValue = _doador.tipo_sangue;
      _dropdownUFValue = _doador.uf;
      _id_carteiraController.text = _doador.id_carteira_doador;
      _email_doadorController.text = _doador.email_doador;
      _email_solicitanteController.text = _doador.email_solicitante;
      _local_internacaoController.text = _doador.local_internacao;
      _motivoController.text = _doador.motivo;
      _qtd_bolsasController.text = _doador.qtd_bolsas.toString();
      if (_doador.imagem != '') {
        setState(() => CaminhoImagem = _doador.imagem);
      }
    } else
      _doador.id = 0;
  }

  void _cadastrarDoador() async {
    _doador.nome_completo = _nomeController.text;
    _doador.nome_mae = _nome_maeController.text;
    _doador.nome_pai = _nome_paiController.text;
    _doador.genero = _dropdownGenValue;
    _doador.data_nasc = _data_nascController.text;
    _doador.cpf = _cpfController.text;
    _doador.rg = _rgController.text;
    _doador.celular = _celularController.text;
    _doador.tipo_sangue = _dropdownSangValue;
    _doador.uf = _dropdownUFValue;
    _doador.id_carteira_doador = _id_carteiraController.text;
    _doador.email_doador = _email_doadorController.text;
    _doador.imagem = _verificarCaminhoImagem()!;

    if (_tipoDoador) {
      _doador.email_solicitante = _email_solicitanteController.text;
      _doador.local_internacao = _local_internacaoController.text;
      _doador.motivo = _motivoController.text;
      _doador.qtd_bolsas = int.parse(_qtd_bolsasController.text);
    }

    if (_doador.id < 1) {
      _doador.id = 1;
      DoadorDAO.insert(_doador);
    } else {
      DoadorDAO.update(_doador);
    }

    Navigator.pop(context, false);
  }

  bool? _montaTelaDeAcordoComTipoCadastro(String? Tipo) {
    switch (Tipo) {
      case 'Doador':
        _email_solicitanteController.clear();
        _local_internacaoController.clear();
        _motivoController.clear();
        _qtd_bolsasController.clear();
        return false;
      case 'Solicitante':
        return true;
      case 'Ambos':
        return true;
      default:
        return false;
    }
  }

  _barraSuperior() {
    return AppBar(
      title: Text("Tela Cadastro Doador/Solicitante"),
      centerTitle: true,
      backgroundColor: Colors.red[400],
    );
  }

  Future<void> _mostraDialogoEscolha(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Escolha uma opção",
              style: TextStyle(
                color: Colors.black87,
              ),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Divider(
                    height: 1,
                    color: Colors.red[400],
                  ),
                  ListTile(
                    onTap: () {
                      _abreGaleria(context);
                    },
                    title: Text("Galeria"),
                    leading: Icon(
                      Icons.account_box,
                      color: Colors.red[400],
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Colors.red[400],
                  ),
                  ListTile(
                    onTap: () {
                      _abreCamera(context);
                    },
                    title: Text("Câmera"),
                    leading: Icon(
                      Icons.camera,
                      color: Colors.red[400],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  _camposInsercaoTexto(String textoLabel, int length, TextEditingController controller, TextInputType type, bool enabled) {
    return TextFormField(
      enabled: enabled,
      controller: controller,
      inputFormatters: [
        LengthLimitingTextInputFormatter(length),
      ],
      keyboardType: type,
      decoration: InputDecoration(
        labelText: textoLabel,
        labelStyle: TextStyle(
          color: Colors.black38,
          fontWeight: FontWeight.w400,
          fontSize: 18,
        ),
      ),
      style: TextStyle(
        fontSize: 18,
      ),
    );
  }

  _camposInsercaoTextoNumber(String textoLabel, int length, TextEditingController controller, TextInputType type, bool enabled) {
    return TextFormField(
      enabled: enabled,
      controller: controller,
      inputFormatters: [LengthLimitingTextInputFormatter(length), FilteringTextInputFormatter.digitsOnly],
      keyboardType: type,
      decoration: InputDecoration(
        labelText: textoLabel,
        labelStyle: TextStyle(
          color: Colors.black38,
          fontWeight: FontWeight.w400,
          fontSize: 18,
        ),
      ),
      style: TextStyle(
        fontSize: 18,
      ),
    );
  }

  _camposInsercaoTextoComFiltro(
    String textoLabel,
    TextEditingController controller,
    TextInputType type,
    TextInputFormatter filtro,
  ) {
    return TextFormField(
      controller: controller,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly, filtro],
      keyboardType: type,
      decoration: InputDecoration(
        labelText: textoLabel,
        labelStyle: TextStyle(
          color: Colors.black38,
          fontWeight: FontWeight.w400,
          fontSize: 18,
        ),
      ),
      style: TextStyle(
        fontSize: 18,
      ),
    );
  }

  _montaComboBoxPadrao(String pValue, String pTitle, List<String> pList) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        filled: true,
        labelText: pTitle,
        labelStyle: TextStyle(
          color: Colors.black38,
          fontWeight: FontWeight.w400,
          fontSize: 20,
        ),
      ),
      value: pValue,
      // icon: const Icon(Icons.),
      elevation: 16,
      style: const TextStyle(color: Colors.black38),
      onChanged: (String? newValue) {
        setState(() {
          pValue = newValue!;
        });
      },
      items: pList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  _montaComboBoxTipoDoador() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        filled: true,
        labelText: 'Tipo Usuario',
        labelStyle: TextStyle(
          color: Colors.black38,
          fontWeight: FontWeight.w400,
          fontSize: 20,
        ),
      ),
      value: _dropdownTipoValue,
      // icon: const Icon(Icons.),
      elevation: 16,
      style: const TextStyle(color: Colors.black38),
      onChanged: (String? newValue) {
        setState(() {
          _dropdownTipoValue = newValue!;
          _tipoDoador = _montaTelaDeAcordoComTipoCadastro(_dropdownTipoValue)!;
        });
      },
      items: _tipo_Doador.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Future _abreCamera(BuildContext context) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => this._arquivo = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future _abreGaleria(BuildContext context) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => this._arquivo = imageTemp);
      //cropImage(image.path);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  _cropImage(filePath) async {
    File? croppedImage = await ImageCropper().cropImage(
      sourcePath: filePath,
      maxWidth: 625,
      maxHeight: 625,
    );
    if (croppedImage != null) {
      final imageTemp = File(croppedImage.path);
      setState(() => this._arquivo = imageTemp);
    }
  }

  Widget _corpo(context) {
    return Container(
      padding: EdgeInsets.only(top: 10, left: 20, right: 20),
      color: Colors.white,
      child: Scrollbar(
        isAlwaysShown: true,
        child: ListView(
          children: <Widget>[
            Container(
              width: 300,
              height: 300,
              alignment: Alignment(0.0, 1.15),
              child: Column(
                children: [
                  Container(
                    width: 240,
                    height: 240,
                    child: FittedBox(
                        fit: BoxFit.fill, // otherwise the logo will be tiny
                        child: _arquivo != null ? Image.file(_arquivo!) : Image.asset(CaminhoImagem)),
                  ),
                  Container(
                    height: 56,
                    width: 56,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color(0XFFEF5350),
                      border: Border.all(
                        width: 1.0,
                        color: const Color(0xFFFFFFFF),
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(56),
                      ),
                    ),
                    child: SizedBox.expand(
                      child: TextButton(
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        onPressed: () async {
                          await _mostraDialogoEscolha(context);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            _camposInsercaoTexto("Nome Completo", 50, _nomeController, TextInputType.text, true),
            const SizedBox(
              height: 10,
            ),
            _camposInsercaoTexto("Nome Mãe", 50, _nome_maeController, TextInputType.text, true),
            const SizedBox(
              height: 10,
            ),
            _camposInsercaoTexto("Nome Pai", 50, _nome_paiController, TextInputType.text, true),
            const SizedBox(
              height: 10,
            ),
            _montaComboBoxTipoDoador(),
            _montaComboBoxPadrao(_dropdownGenValue, 'Gênero', _genero),
            _montaComboBoxPadrao(_dropdownSangValue, 'Tipo Sangue', _tipo_Sangue),
            _montaComboBoxPadrao(_dropdownUFValue, 'UF', _estado),
            const SizedBox(
              height: 10,
            ),
            _camposInsercaoTextoComFiltro("CPF", _cpfController, TextInputType.number, CpfInputFormatter()),
            const SizedBox(
              height: 10,
            ),
            _camposInsercaoTextoComFiltro("Data Nascimento", _data_nascController, TextInputType.datetime, DataInputFormatter()),
            const SizedBox(
              height: 10,
            ),
            _camposInsercaoTextoNumber("RG", 10, _rgController, TextInputType.number, true),
            const SizedBox(
              height: 10,
            ),
            _camposInsercaoTextoNumber("ID Carteira Doador", 10, _id_carteiraController, TextInputType.number, true),
            const SizedBox(
              height: 10,
            ),
            _camposInsercaoTextoComFiltro("Celular", _celularController, TextInputType.number, TelefoneInputFormatter()),
            const SizedBox(
              height: 10,
            ),
            _camposInsercaoTexto("Email", 50, _email_doadorController, TextInputType.emailAddress, true),
            const SizedBox(
              height: 10,
            ),
            Visibility(
              visible: _tipoDoador, // condition here
              child: Container(
                child: ListView(
                  children: <Widget>[
                    _camposInsercaoTexto(
                        "Email Solicitante", 50, _email_solicitanteController, TextInputType.emailAddress, _tipoDoador),
                    const SizedBox(
                      height: 10,
                    ),
                    _camposInsercaoTexto("Local Internação ", 50, _local_internacaoController, TextInputType.text, _tipoDoador),
                    const SizedBox(
                      height: 10,
                    ),
                    _camposInsercaoTexto("Motivo", 50, _motivoController, TextInputType.text, _tipoDoador),
                    const SizedBox(
                      height: 10,
                    ),
                    _camposInsercaoTexto("Quantidade Bolsas ", 4, _qtd_bolsasController, TextInputType.number, _tipoDoador),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                width: double.infinity,
                height: 300.0,
              ),
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
                    _cadastrarDoador();
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
    return Scaffold(body: _corpo(context), appBar: _barraSuperior());
  }
}
