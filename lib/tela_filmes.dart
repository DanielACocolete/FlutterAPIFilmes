import 'package:flutter/material.dart';
import 'package:meucinema/tela_historico_compras.dart';
import 'package:meucinema/tela_login.dart';
import 'api_service.dart';
import 'tela_compra_ingresso.dart';


class TelaFilmes extends StatefulWidget {
  @override
  _TelaFilmesState createState() => _TelaFilmesState();
}

class _TelaFilmesState extends State<TelaFilmes> {
  ApiService apiService = ApiService();
  List<dynamic> filmes = [];

  @override
  void initState() {
    super.initState();
    carregarFilmes();
  }

  void carregarFilmes() async {
    try {
      var listaFilmes = await apiService.getFilmes();
      setState(() {
        filmes = listaFilmes;
      });
    } catch (e) {
      print('Erro ao carregar filmes: $e');
    }
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Filmes")),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_bag),
              title: Text('Histórico de Compras'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TelaHistoricoCompras(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                 Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => TelaLogin()),
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        ),
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
            child: filmes.isEmpty
                ? CircularProgressIndicator()
                : SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8, // 80% da altura da tela
                    child: ListView.builder(
                      itemCount: filmes.length,
                      itemBuilder: (context, index) {
                        var filme = filmes[index];
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                          elevation: 5,
                          child: ListTile(
                            leading: Image.network(
                              filme['imagem'],
                              width: 50,
                              height: 50,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(Icons.error, size: 50, color: Colors.red);
                              },
                            ),
                            title: Text(
                              filme['nome'],
                              style: TextStyle(color: Colors.grey),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  filme['tipo'],
                                  style: TextStyle(color: Colors.grey),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  filme['preco'],
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TelaCompraIngresso(filme: filme),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

