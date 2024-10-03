class Usuario {
  String nome;
  String email;
  List<String> historicoCompras;

  Usuario({
    required this.nome,
    required this.email,
    this.historicoCompras = const [],
  });

  void adicionarCompra(String compra) {
    historicoCompras.add(compra);
  }
}
