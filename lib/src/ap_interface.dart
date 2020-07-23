import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'authorization.dart';

final _baseUri = "http://trello.backend.tests.nekidaem.ru/api/v1/";
final _tokenUri = "users/login/";
final _cardsUri = "cards/";

class APInterface {

  Future<Token> getToken(User userLogin) async {
    String _uri = _baseUri + _tokenUri;
    final http.Response response = await http.post(
      _uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(userLogin.toDatabaseJson()),
    );
    if (response.statusCode == 200) {
      return Token.fromJson('ok', json.decode(response.body));
    } else {
      return Token(result: 'error', token: json.decode(response.body).toString());
    }
  }

  Future<List<dynamic>> getCards(Token token) async {
    List<dynamic> result = [];
    String _uri = _baseUri + _cardsUri;
    final http.Response response = await http.get(
      _uri,
      headers: <String, String>{
        'Authorization': "JWT " + token.token,
      },
    );
    if (response.statusCode == 200) {
      result = ['ok'];
      result.addAll(json.decode(response.body));
      return result;
    } else {
      result = ['error'];
      result.addAll(json.decode(response.body));
      return result;
    }
  }
}

class Token{
  String result;
  String token;

  Token({this.result, this.token});

  factory Token.fromJson(String result, Map<String, dynamic> json) {
    return Token(
        result: result,
        token: json['token']
    );
  }
}
