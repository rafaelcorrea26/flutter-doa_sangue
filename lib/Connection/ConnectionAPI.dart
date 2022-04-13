import 'dart:collection';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ConnectionAPI {
  var urlLocal = "http://10.0.2.2:3232/";
  var urlAPI = 'https://webmc.com.br/api_cpagar/public/api/login'; // "http://192.168.1.121:8080/api/login";
  var email = '';
  var senha = '';
  var accessToken = '';
  var acessExpiresIn = '';

  //Token
  Future<bool> pegaToken() async {
    var url = Uri.parse(urlAPI);
    url = url.replace(queryParameters: {'email': email, 'senha': senha});
    print(url);
    var response = await http.post(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });

    if (response.statusCode == 200) {
      print(response.body);
      accessToken = json.decode(response.body)["access_token"];
      acessExpiresIn = json.decode(response.body)["expires_in"];

      return true;
    } else {
      return false;
    }
  }

//get

  Future<String> carregaUsuario() async {
    Map<String, String> headers = HashMap();

    if (accessToken.isEmpty) {
      pegaToken();
    }

    print("Fazendo a requisição GET Usuário");
    var url = Uri.parse(urlAPI);

    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    });

    print("Resposta get da API ${response.body}");
    print(response.statusCode);

    if (response.statusCode == 200) {
      print(response.body);
      var usuarios = json.decode(response.body)[""]!;
      return usuarios;
    } else {
      return "Usuário não carregado!";
    }
  }

// post

// put

//delete
}
