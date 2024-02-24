import 'package:ingressos_app/dto/usuario_dto.dart';
import 'package:http/http.dart' as http;

abstract class UsuarioRepository {
  Future<http.Response> resgistrarUsuario(UsuarioDto UsuarioDto);
  Future<http.Response> checkUser();

}