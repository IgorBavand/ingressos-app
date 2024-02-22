import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ingressos_app/view/autenticacao/autenticacao_view.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ingressos_app/controller/ingresso_controller.dart';
import 'package:ingressos_app/model/ingresso.dart';
import 'package:ingressos_app/repository/impl/ingresso_repository_impl.dart';
import 'dart:convert' show utf8;

class ListViewIngressos extends StatelessWidget {

  const ListViewIngressos({Key? key}) : super(key: key);
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    var ingressoController = IngressoController(IngressoRepositoryImpl());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ingressos disponíveis'),
        centerTitle: true,
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              _deslogar();
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AutenticacaoView()));
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem<String>(
                value: 'user',
                child: Row(
                  children: [
                    Icon(Icons.person, color: Colors.teal),
                    SizedBox(width: 8),
                    Text(
                      "igor",
                      style: TextStyle(color: Colors.teal),
                    ),
                  ],
                ),
              ),
              const PopupMenuItem<String>(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(Icons.exit_to_app, color: Colors.red),
                    SizedBox(width: 8),
                    Text(
                      'Deslogar',
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: FutureBuilder<List<Ingresso>>(
        future: ingressoController.findAll(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Nenhum ingresso encontrado..."));
          }

          if (snapshot.hasError) {
            print(snapshot.error);
            return const Center(child: Text('Error ...'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var ingresso = snapshot.data![index];
              var formattedValue =
              NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$')
                  .format(ingresso.valor ?? 0);
              return Card(
                elevation: 4,
                margin: const EdgeInsets.all(8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: InkWell(
                  onTap: () => _comprarIngresso(context, ingresso.id!),
                  borderRadius: BorderRadius.circular(15),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            color: Colors.teal,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.attach_money,
                              color: Colors.white),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                utf8.decode(ingresso.descricao
                                    .toString()
                                    .codeUnits) ??
                                    '',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.teal,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                utf8.decode(ingresso.localEvento
                                    .toString()
                                    .codeUnits) ??
                                    '',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Data: ${ingresso.dataEvento != null ? DateFormat('dd/MM/yyyy').format(ingresso.dataEvento!) : ''}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Valor: $formattedValue',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () =>
                              _comprarIngresso(context, ingresso.id!),
                          style: ElevatedButton.styleFrom(
                            // primary: Colors.indigo,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Comprar',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _comprarIngresso(BuildContext context, int ingressoId) async {
    var ingressoController = IngressoController(IngressoRepositoryImpl());
    var url = await ingressoController.comprarIngresso(1, ingressoId);
    _redirecionarParaLinkPagamento(url);
  }

  Future<void> _deslogar() async {
    await _storage.delete(key: "token");
    await _storage.delete(key: "login");
    await _storage.delete(key: "password");
  }

  Future<void> _redirecionarParaLinkPagamento(String urlParameter) async {
    Uri url = Uri.parse(urlParameter);
    if (!await launch(url.toString())) {
      throw Exception('Could not launch $url');
    }
  }
}
