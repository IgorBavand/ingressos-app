import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ingressos_app/controller/usuario_controller.dart';
import 'package:ingressos_app/dto/usuario_dto.dart';
import 'package:ingressos_app/repository/impl/usuario_repository_impl.dart';
import 'package:ingressos_app/view/autenticacao/autenticacao_view.dart';

enum EUserRole { admin, user }

class CadastroUsuarioScreen extends StatefulWidget {
  const CadastroUsuarioScreen({Key? key}) : super(key: key);

  @override
  _CadastroUsuarioScreenState createState() => _CadastroUsuarioScreenState();
}

class _CadastroUsuarioScreenState extends State<CadastroUsuarioScreen> {
  late UsuarioDto _usuarioDto = UsuarioDto();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Usuário'),
        centerTitle: true,
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Nome',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _usuarioDto.nome = value;
                });
              },
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: 'Login',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _usuarioDto.login = value;
                });
              },
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              obscureText: true,
              onChanged: (value) {
                setState(() {
                  _usuarioDto.password = value;
                });
              },
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: 'Telefone',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _usuarioDto.telefone = value;
                });
              },
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: 'CPF',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _usuarioDto.cpf = value;
                });
              },
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: 'Cidade',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _usuarioDto.cidade = value;
                });
              },
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<EUserRole>(
              value: EUserRole.admin,
              items: const [
                DropdownMenuItem(
                  value: EUserRole.admin,
                  child: Text('ADMIN'),
                ),
                DropdownMenuItem(
                  value: EUserRole.user,
                  child: Text('USER'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _usuarioDto.userRole = value.toString();
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _cadastrarUsuario(context, _usuarioDto);
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }

  void _cadastrarUsuario(BuildContext context, UsuarioDto usuarioDto) async {
    var usuarioController = UsuarioController(UsuarioRepositoryImpl());
    final LoginPageState _authView = LoginPageState();

    http.Response response = await usuarioController.cadastrarUsuario(usuarioDto);

    if (response.statusCode == 200) {
      _authView.login(context, _usuarioDto.login.toString(), _usuarioDto.password.toString());
    } else {
      var responseData = json.decode(response.body);
      var message = responseData['message'];

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Erro de cadastro'),
            content: Text(message),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}

void main() {
  runApp(const MaterialApp(
    home: CadastroUsuarioScreen(),
  ));
}
