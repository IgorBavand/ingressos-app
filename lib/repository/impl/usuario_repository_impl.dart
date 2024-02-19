import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ingressos_app/dto/usuario_dto.dart';
import 'package:ingressos_app/repository/usuario_repository.dart';

class UsuarioRepositoryImpl implements UsuarioRepository {
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
}
