import 'package:flutter/material.dart';
import 'package:ingressos_app/view/autenticacao/autenticacao_view.dart';
import 'package:ingressos_app/view/list_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ingressos App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const AutenticacaoView(),
      // home: const ListViewIngressos(),
      debugShowCheckedModeBanner: false,
    );
  }
}
