import 'package:flutter/material.dart';
import 'tela_login.dart';
import 'tela_filmes.dart';
import 'tela_historico_compras.dart';

void main() {
  runApp(AppCinema());
}

class AppCinema extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meu Cinema',
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => TelaLogin(),
        '/filmes': (context) => TelaFilmes(),
        '/historico': (context) => TelaHistoricoCompras(),
      },
    );
  }
}
