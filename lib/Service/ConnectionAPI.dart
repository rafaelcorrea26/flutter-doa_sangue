import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';

const _Url = "http://192.168.1.120:8001/api/";

class ConnectionAPI {
  Future<String> _pegaToken() async {
    var _url = Uri.parse(_Url + 'login');
    var _email = 'rafael@gmail.com';
    var _senha = '1234';

    _url = _url.replace(queryParameters: {'email': _email, 'senha': _senha});
    print(_url);
    var response = await http.post(_url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });

    if (response.statusCode == 200) {
      return json.decode(response.body)["access_token"];
    } else {
      return "";
    }
  }

  // Requisição GET

  Future<String> getUsuario(context) async {
    var _token = await _pegaToken();
    print(_token);
    var url = Uri.parse(_Url + 'usuario');
    final _resposta = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    });
    print(_resposta.statusCode);

    if (_resposta.statusCode == 200 || _resposta.statusCode == 204) {
      print(_resposta.body);
      _mostraDialogoConexaoAPI(context, 'Ativo ', _token, _resposta.body);
      return "Usuário carregado!";
    } else {
      _mostraDialogoConexaoAPI(context, 'Inativa ', 'Erro ao conectar', '');
      return "Usuário não carregado!";
    }
  }

// post

// put

//delete

  Future _mostraDialogoConexaoAPI(BuildContext context, ativo, token, body) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Status Conexão : $ativo",
              style: TextStyle(
                color: Colors.black87,
              ),
            ),
            content: SingleChildScrollView(
              child: Container(
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Center(
                    child: Text(
                      "Access_token: $token \n \n Json Usuários: $body",
                      style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.normal, fontFamily: 'Poppins'),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
