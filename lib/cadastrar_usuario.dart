import 'package:flutter/material.dart';
import 'package:meucinema/api_service.dart';

class TelaCadastro extends StatefulWidget {
  @override
  _TelaCadastroState createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final ApiService apiService = ApiService();

  void _cadastrar() async {
    String nome = _nomeController.text;
    String senha = _senhaController.text;

    if (nome.isEmpty || senha.isEmpty) {
      _showMessage('Por favor, preencha todos os campos.');
      return;
    }

    try {
      final response = await apiService.cadastrarUsuario(nome, senha);
      Navigator.pop(context);
    } catch (e) {
      _showMessage('Erro ao tentar cadastrar: $e');
    }
  }

  void _showMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Atenção'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro MeuCinema'),
        backgroundColor: Colors.black.withOpacity(0.9),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/fundo.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  Text(
                    'Cadastre-se no MeuCinema',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 30),
                  // Campo de nome
                  SizedBox(
                    width: 300,
                    child: TextField(
                      controller: _nomeController,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        labelText: 'Nome',
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.7),
                        labelStyle: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Campo de senha
                  SizedBox(
                    width: 300,
                    child: TextField(
                      controller: _senhaController,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        labelText: 'Senha',
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.7),
                        labelStyle: TextStyle(color: Colors.black),
                      ),
                      obscureText: true,
                    ),
                  ),
                  SizedBox(height: 20),
                  // Botão de cadastrar
                  SizedBox(
                    width: 300,
                    child: ElevatedButton(
                      onPressed: _cadastrar,
                      child: Text('Cadastrar'),
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