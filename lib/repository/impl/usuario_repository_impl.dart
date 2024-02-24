import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:ingressos_app/dto/usuario_dto.dart';
import 'package:ingressos_app/repository/usuario_repository.dart';

class UsuarioRepositoryImpl implements UsuarioRepository {

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  var url = "http://192.168.0.132:8091";

  @override
  Future<http.Response> resgistrarUsuario(UsuarioDto usuarioDto) async {

    var headers = {
      'Content-Type': 'application/json',
    };

    var body = {
      'nome': usuarioDto.nome.toString(),
      'login': usuarioDto.login.toString(),
      'password': usuarioDto.password.toString(),
      'telefone': usuarioDto.telefone.toString(),
      'cpf': usuarioDto.cpf.toString(),
      'cidade': usuarioDto.cidade.toString(),
      'userRole': "ADMIN"
    };
    var bodyJson = json.encode(body);

    var response = await http.post(Uri.parse("$url/api/auth/register"),
        headers: headers, body: bodyJson);

    return response;
  }

  @override
  Future<http.Response> checkUser() async {

    var token = await _storage.read(key: 'token');
    token = token.toString();

    final response = await http.get(
        Uri.parse("http://192.168.0.132:8091/api/auth/check-user"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': token
        });

    return response;
  }
}
