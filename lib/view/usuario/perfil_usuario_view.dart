import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ingressos_app/controller/usuario_controller.dart';
import 'package:ingressos_app/repository/impl/usuario_repository_impl.dart';

import '../../dto/usuario_response_dto.dart';

class PerfilUsuarioView extends StatefulWidget {
  const PerfilUsuarioView({Key? key}) : super(key: key);

  @override
  _PerfilUsuarioViewState createState() => _PerfilUsuarioViewState();
}

class _PerfilUsuarioViewState extends State<PerfilUsuarioView> {
  UsuarioResponseDto? usuario;
  final UsuarioController _usuarioController =
  UsuarioController(UsuarioRepositoryImpl());

  @override
  void initState() {
    super.initState();
    iniciaBusca();
  }

  Future<void> iniciaBusca() async {
    try {
      var response = await _usuarioController.checkUser();
      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = json.decode(response.body);
        setState(() {
          usuario = UsuarioResponseDto.fromJson(responseBody);
        });
      } else {
        throw Exception(
            'Erro ao buscar dados do usuário: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil do Usuário'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/profile_pic.jpg'),
                ),
                const SizedBox(height: 20),
                buildInfoTile('Nome', usuario?.nome ?? 'Carregando...'),
                buildInfoTile('Login', usuario?.login ?? 'Carregando...'),
                buildInfoTile(
                    'Telefone', usuario?.telefone ?? 'Carregando...'),
                buildInfoTile('CPF', usuario?.cpf ?? 'Carregando...'),
                buildInfoTile('Cidade', usuario?.cidade ?? 'Carregando...'),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Implementar ação de editar perfil
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 32,
                    ),
                  ),
                  child: const Text(
                    'Editar Perfil',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInfoTile(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$label: ',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
