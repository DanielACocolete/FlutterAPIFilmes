import 'package:flutter/material.dart';
import 'package:meucinema/api_service.dart';

class TelaHistoricoCompras extends StatefulWidget {
  @override
  _TelaHistoricoComprasState createState() => _TelaHistoricoComprasState();
}

class _TelaHistoricoComprasState extends State<TelaHistoricoCompras> {
  ApiService apiService = ApiService();
  List<dynamic> historicoCompras = [];

  @override
  void initState() {
    super.initState();
    carregarHistoricoCompras();
  } 

  void carregarHistoricoCompras() async {
    try {
      var listaHistoricoCompras = await apiService.getHistoricoCompras();
      setState(() {
        historicoCompras = listaHistoricoCompras;
      });
    } catch (e) {
      print('Erro ao carregar historico: $e');
    }
  }

 void excluirCompra(int id) async {
    try {
      await apiService.deletarCompra(id); // Supondo que o método deleteCompra seja implementado no ApiService
      setState(() {
        historicoCompras.removeWhere((compra) => compra['id'] == id); // Remove a compra da lista local
      });
      carregarHistoricoCompras();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Compra excluída com sucesso!')));
    } catch (e) {
      print('Erro ao excluir compra: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao excluir compra!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Histórico de Compras")),
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
            itemCount: historicoCompras.length,
            itemBuilder: (context, index) {
              var historico = historicoCompras[index];
              return Card(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              historico['filme'],
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Comprador: ${historico['nomeComprador']}',
                              style: TextStyle(
                                color: const Color.fromARGB(255, 228, 224, 11),
                              ),
                            ),
                            Text(
                              'Horário: ${historico['horario']}',
                              style: TextStyle(
                                color: const Color.fromARGB(255, 228, 224, 11),
                              ),
                            ),
                            Text(
                              'Dia: ${historico['dia']}',
                              style: TextStyle(
                                color: const Color.fromARGB(255, 228, 224, 11),
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          excluirCompra(historico['chave']);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
