import 'package:flutter/material.dart';
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
          ListView.builder(
            itemCount: filmes.length,
            itemBuilder: (context, index) {
              var filme = filmes[index];
              return ListTile(
                title: Text(filme['nome']),
                subtitle: Text(filme['tipo']),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TelaCompraIngresso(filme: filme),
                    ),
                  );
                },
              );
            },
          ),
        ]
      )
      
      
      
    );
  }
}
