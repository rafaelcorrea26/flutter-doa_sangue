import 'dart:convert';
import 'package:http/http.dart' as http;

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

  Future<String> getUsuario() async {
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
      //   usuario = json.decode(resposta.body)["deck_id"]!;
      return "Usuário carregado!";
    } else {
      return "Usuário não carregado!";
    }
  }

// post

// put

//delete
}
