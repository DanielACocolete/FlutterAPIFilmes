import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'http://localhost:8080/filme';

  Future<List<dynamic>> getFilmes() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Erro ao carregar filmes');
    }
  }

  Future<String> autenticaUsuario(String nome, String senha) async {
    final response = await http.get(
      Uri.parse('$baseUrl/testaUsuario?usuario=$nome&senha=$senha'),
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Erro na autenticação');
    }
  }

  Future<void> adicionarFilme(Map<String, String> filme) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(filme),
    );

    if (response.statusCode != 200) {
      throw Exception('Erro ao adicionar filme');
    }
  }

  Future<void> deletarFilme(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));

    if (response.statusCode != 200) {
      throw Exception('Erro ao deletar filme');
    }
  }
}
