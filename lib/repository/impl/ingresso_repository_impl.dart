import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ingressos_app/model/ingresso.dart';
import 'package:ingressos_app/repository/ingresso_repository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class IngressoRepositoryImpl implements IngressoRepository {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  @override
  Future<List<Ingresso>> findAll() async {
    List<Ingresso> passagens = [];
    var url = Uri.parse("http://192.168.0.132:8091/api/ingresso");
    var token = await _storage.read(key: 'token');

    var response  = await http.get(url, headers: {
      'Authorization': token.toString()
    });
    var body = json.decode(response.body);

    for(var i = 0; i < body.length; i++){
      passagens.add(Ingresso.fromJson(body[i]));
    }
    return passagens;
  }

  @override
  Future <String> comprarIngresso(int cliente, int ingresso) async {
    var url = Uri.parse("http://192.168.0.132:8091/api/venda");
    var token = await _storage.read(key: 'token');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token.toString()
    };
    var body = {
      'cliente': cliente.toString(),
      'ingresso': ingresso.toString(),
    };
    var bodyJson = json.encode(body);
    var response = await http.post(url, body: bodyJson, headers: headers);
    var urlParaPagamento = response.body.toString();

    return urlParaPagamento;
  }
}