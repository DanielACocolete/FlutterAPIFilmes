import 'package:flutter/material.dart';
import 'package:meucinema/api_service.dart';
import 'package:meucinema/cadastrar_usuario.dart';


class TelaLogin extends StatefulWidget {
  @override
  _TelaLoginState createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {

  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final ApiService apiService = ApiService();

  void _login() async {
    String usuario = _usuarioController.text;
    String senha = _senhaController.text;

    if (usuario.isEmpty || senha.isEmpty) {
      // Exibir mensagem de erro se os campos estiverem vazios
      _showMessage('Por favor, preencha todos os campos.');
      return;
    }

    try {
      // Chamar o método do ApiService para autenticação
      final response = await apiService.autenticaUsuario(usuario, senha);
      if (response == "Usuário autenticado com sucesso!") {
        Navigator.pushNamed(context, '/filmes');
      } else {
        _showMessage('Usuário ou senha inválidos.');
      }
    } catch (e) {
      _showMessage('Usuário ou senha incorretos!');
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
        title: Text('Login MeuCinema'),
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
                    'Bem-vindo ao MeuCinema',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, 
                    ),
                  ),
                  SizedBox(height: 30),
                  // Campo de usuário
                  SizedBox(
                    width: 300,
                    child: TextField(
                      controller: _usuarioController,
                      style: TextStyle(color: Colors.black), 
                      decoration: InputDecoration(
                        labelText: 'Usuário',
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
                  // Botão de login
                  SizedBox(
                    width: 300,
                    child: ElevatedButton(
                      onPressed: _login,
                      child: Text('Entrar'),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TelaCadastro()),
                      );
                    },
                    child: Text(
                      'Cadastrar um novo usuário',
                      style: TextStyle(color: Colors.white),
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