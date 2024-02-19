import 'package:ingressos_app/model/ingresso.dart';

abstract class IngressoRepository {
  Future <List<Ingresso>> findAll();
  Future <String> comprarIngresso(int cliente, int ingresso);
// Future <String> putCompleted(Produto produto);
// Future <String> delete(Produto produto);
// Future <String> save(Produto produto);
}