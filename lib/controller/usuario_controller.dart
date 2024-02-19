import 'package:ingressos_app/dto/usuario_dto.dart';
import 'package:ingressos_app/repository/usuario_repository.dart';
import 'package:http/http.dart' as http;

class UsuarioController {
  final UsuarioRepository _repository;

  UsuarioController(this._repository);

  Future<http.Response> cadastrarUsuario(UsuarioDto UsuarioDto) async {
    return await _repository.resgistrarUsuario(UsuarioDto);
  }
}
