import 'package:ingressos_app/model/ingresso.dart';
import 'package:ingressos_app/repository/ingresso_repository.dart';

class IngressoController {
  final IngressoRepository _repository;

  IngressoController(this._repository);

  Future<List<Ingresso>> findAll() async{
    return _repository.findAll();
  }

  Future<String> comprarIngresso(int cliente, int ingresso) {
    return _repository.comprarIngresso(cliente, ingresso);
  }
}