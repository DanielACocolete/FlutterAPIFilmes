import 'package:flutter/material.dart';

class TelaHistoricoCompras extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Histórico de Compras'),
        backgroundColor: Colors.black.withOpacity(0.9),
      ),
      body: Stack(
        children: [
          // Imagem de fundo (opcional)
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/fundo.jpg'), // Caminho da imagem
                fit: BoxFit.cover, // Ajusta a imagem ao tamanho da tela
              ),
            ),
          ),
          // Lista centralizada
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      'Filme 1',
                      style: TextStyle(
                        color: Colors.white, // Cor do texto do título
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      'Compra realizada: 01/10/2024',
                      style: TextStyle(
                        color: Colors.yellow, // Cor do texto do subtítulo
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Filme 2',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      'Compra realizada: 02/10/2024',
                      style: TextStyle(
                        color: Colors.yellow,
                      ),
                    ),
                  ),
                  // Adicione mais itens de histórico aqui
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
