import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:doa_sangue/Connection/DAO/UsuarioDAO.dart';
import 'package:doa_sangue/Model/Usuario.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';

class CadastroUsuarioPage extends StatefulWidget {
  CadastroUsuarioPage();

  @override
  _CadastroUsuarioPage createState() => _CadastroUsuarioPage();
}

class _CadastroUsuarioPage extends State<CadastroUsuarioPage> {
  Usuario _usuario = Usuario();
  var CaminhoImagem = "assets/pictures/profile-picture.jpg";
  TextEditingController _nomeController = TextEditingController();
  TextEditingController _loginController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _senhaController = TextEditingController();
  File? _arquivo;
  XFile? imageFile = null;

  String VerificarCaminhoImagem() {
    if (imageFile == null) {
      return CaminhoImagem;
    } else {
      return imageFile!.path;
    }
  }

  _CadastroUsuarioPage();

  @override
  void initState() {
    super.initState();
    _usuario.id = 0;
  }

  String? _verificarCaminhoImagem() {
    if (_arquivo == null) {
      return CaminhoImagem;
    } else {
      return _arquivo?.path;
    }
  }

  void _carregaCampos() async {
    _usuario.id = 1;
    await UsuarioDAO.searchId(_usuario);

    print(_usuario.toString());
    if (_usuario.nome != "") {
      _nomeController.text = _usuario.nome;
      _emailController.text = _usuario.email;
      _senhaController.text = _usuario.senha;
      if (_usuario.imagem != '') {
        final imageTemp = File(_usuario.imagem);
        setState(() => _arquivo = imageTemp);
      }
    } else
      _usuario.id = 0;
  }

  void CadastrarUsuario() async {
    _usuario.nome = _nomeController.text;
    _usuario.login = _loginController.text;
    _usuario.email = _emailController.text;
    _usuario.senha = _senhaController.text;
    _usuario.imagem = _verificarCaminhoImagem()!;

    if (_usuario.id < 1) {
      UsuarioDAO.insert(_usuario);
    } else {
      UsuarioDAO.update(_usuario);
    }

    Navigator.pop(context, false);
  }

  Future<void> MostraDialogoEscolha(BuildContext context) {
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
                      AbreGaleria(context);
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
                      AbreCamera(context);
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

  Future AbreCamera(BuildContext context) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) return;

      cropImage(image.path);
    } on PlatformException catch (e) {
      print('Falha ao selecionar a imagem: $e');
    }
  }

  Future AbreGaleria(BuildContext context) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      cropImage(image.path);
    } on PlatformException catch (e) {
      print('Falha ao selecionar a imagem: $e');
    }
  }

  cropImage(filePath) async {
    File? croppedImage = await ImageCropper().cropImage(
      sourcePath: filePath,
      maxWidth: 600,
      maxHeight: 600,
      aspectRatio: CropAspectRatio(ratioX: 16, ratioY: 9),
      androidUiSettings: androidUiSettings(),
      iosUiSettings: iosUiSettings(),
    );
    if (croppedImage != null) {
      final imageTemp = croppedImage; //File(croppedImage.path);
      setState(() => this._arquivo = imageTemp);
    }
  }

  static IOSUiSettings iosUiSettings() => IOSUiSettings(
        aspectRatioLockEnabled: false,
      );

  static AndroidUiSettings androidUiSettings() => AndroidUiSettings(
        toolbarTitle: 'Ajuste a Imagem',
        toolbarColor: Colors.red,
        toolbarWidgetColor: Colors.white,
        lockAspectRatio: false,
      );

  void ListarUsuarios() async {
    Container(
        child: FutureBuilder(
      future: UsuarioDAO.get(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.lenght,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(snapshot.data[index].title),
                  );
                },
              )
            : Center(
                child: Text('Não há usuários...'),
              );
      },
    ));
  }

  barraSuperior() {
    return AppBar(
      title: Text("Tela Cadastro Usuário"),
      centerTitle: true,
      backgroundColor: Colors.red[400],
    );
  }

  Widget corpo(context) {
    return Container(
      padding: EdgeInsets.only(top: 10, left: 40, right: 40),
      color: Colors.white,
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
                        await MostraDialogoEscolha(context);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: _nomeController,
            // autofocus: true,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              prefixIcon: Padding(
                padding: EdgeInsets.only(top: 15), // add padding to adjust icon
                child: Icon(
                  Icons.person,
                  color: Colors.red[400],
                ),
              ),
              labelText: "Nome",
              labelStyle: TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.w400,
                fontSize: 20,
              ),
            ),
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: _loginController,
            // autofocus: true,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              prefixIcon: Padding(
                padding: EdgeInsets.only(top: 15), // add padding to adjust icon
                child: Icon(
                  Icons.person,
                  color: Colors.red[400],
                ),
              ),
              labelText: "Login",
              labelStyle: TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.w400,
                fontSize: 20,
              ),
            ),
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: _emailController,
            // autofocus: true,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              prefixIcon: Padding(
                padding: EdgeInsets.only(top: 15), // add padding to adjust icon
                child: Icon(
                  Icons.email,
                  color: Colors.red[400],
                ),
              ),
              labelText: "E-mail",
              labelStyle: TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.w400,
                fontSize: 20,
              ),
            ),
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: _senhaController,
            // autofocus: true,
            keyboardType: TextInputType.text,
            obscureText: true,
            decoration: InputDecoration(
              prefixIcon: Padding(
                padding: EdgeInsets.only(top: 15), // add padding to adjust icon
                child: Icon(
                  Icons.lock,
                  color: Colors.red[400],
                ),
              ),
              labelText: "Senha",
              labelStyle: TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.w400,
                fontSize: 20,
              ),
            ),
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 10,
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
                  "Cadastrar",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
                onPressed: () {
                  CadastrarUsuario();
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: corpo(context), appBar: barraSuperior());
  }
}
