import 'package:flutter/material.dart';

class TelaLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login MeuCinema'),
        backgroundColor: Colors.black.withOpacity(0.9),
      ),
      body: Stack(
        children: [
          // Imagem de plano de fundo
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/fundo.jpg'), // Caminho da imagem
                fit: BoxFit.cover, // Ajusta a imagem ao tamanho da tela
              ),
            ),
          ),
          // Conteúdo da tela
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Remover ou ajustar o SizedBox acima do texto
                  SizedBox(height: 20), // Espaço reduzido para mover o texto para cima
                  Text(
                    'Bem-vindo ao MeuCinema',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Texto em branco para destacar
                    ),
                  ),
                  SizedBox(height: 30),
                  // Campo de email
                  SizedBox(
                    width: 300,
                    child: TextField(
                      style: TextStyle(color: Colors.black), // Cor do texto digitado
                      decoration: InputDecoration(
                        labelText: 'Email',
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.7), // Fundo branco com opacidade
                        labelStyle: TextStyle(color: Colors.black), // Cor do texto do label
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Campo de senha
                  SizedBox(
                    width: 300,
                    child: TextField(
                      style: TextStyle(color: Colors.black), // Cor do texto digitado
                      decoration: InputDecoration(
                        labelText: 'Senha',
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.7), // Fundo branco com opacidade
                        labelStyle: TextStyle(color: Colors.black), // Cor do texto do label
                      ),
                      obscureText: true,
                    ),
                  ),
                  SizedBox(height: 20),
                  // Botão de login
                  SizedBox(
                    width: 300,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/filmes');
                      },
                      child: Text('Entrar'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}