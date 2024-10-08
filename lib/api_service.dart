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

  Future<List<dynamic>> getHistoricoCompras() async {
    final response = await http.get(Uri.parse('$baseUrl/historicoCompras'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Erro ao carregar filmes');
    }
  }

  Future<String> autenticaUsuario(String nome, String senha) async {
    final response = await http.get(
      Uri.parse('$baseUrl/testaUsuario/$nome/$senha'),
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Erro na autenticação');
    }
  }

  Future<String> cadastrarUsuario(String nome, String senha) async {
    final response = await http.post(
      Uri.parse('$baseUrl/cadastraUsuario'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'nome': nome,
        'senha': senha,
      }),
    );

    if (response.statusCode == 200) {
      return response.body; // O corpo da resposta deve conter a mensagem de sucesso
    } else {
      throw Exception('Falha ao cadastrar o usuário');
    }
  }

  Future<void> compraIngresso(Map<String, dynamic> filme) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(filme),
    );

    if (response.statusCode != 200) {
      throw Exception('Erro ao adicionar filme');
    }
  }

  Future<void> deletarCompra(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));

    if (response.statusCode != 200) {
      throw Exception('Erro ao deletar filme');
    }
  }
}
