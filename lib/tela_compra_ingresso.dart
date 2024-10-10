import 'package:flutter/material.dart';
import 'package:meucinema/tela_historico_compras.dart';
import 'api_service.dart';

class TelaCompraIngresso extends StatefulWidget {
  final Map<String, dynamic> filme;

  TelaCompraIngresso({required this.filme});

  @override
  _TelaCompraIngressoState createState() => _TelaCompraIngressoState();
}

class _TelaCompraIngressoState extends State<TelaCompraIngresso> {
  final _formKey = GlobalKey<FormState>();
  String? nomeComprador;
  String? horario;
  String? dia;
  String? preco;

  ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Compra de Ingresso"),
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
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text("Filme: ${widget.filme['nome']}"),
                  TextFormField(
                    decoration: InputDecoration(labelText: "Nome do Comprador"),
                    onSaved: (value) {
                      nomeComprador = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira seu nome';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: "Horário"),
                    onSaved: (value) {
                      horario = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira o horário';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: "Dia"),
                    onSaved: (value) {
                      dia = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira o dia';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      preco = widget.filme['preco'],
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();

                        final ingressoData = {
                          'nomeComprador': nomeComprador,
                          'horario': horario,
                          'dia': dia,
                          'preco': preco,
                          'filme': widget.filme['nome'],
                        };

                        try {
                          await apiService.compraIngresso(ingressoData);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Compra realizada com sucesso!")));
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TelaHistoricoCompras(),
                                ),
                              );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Erro ao realizar a compra: $e")));
                        }
                      }
                    },
                    child: Text("Comprar Ingresso"),
                  ),
                ],
              ),
            ),
          ),

        ],
      ) 
    );
  }
}