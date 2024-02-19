class Ingresso {
  int? id;
  String? descricao;
  String? localEvento;
  DateTime? dataEvento;
  DateTime? dataEncerramento;
  double? valor;

  Ingresso({
    this.id,
    this.descricao,
    this.localEvento,
    this.dataEvento,
    this.dataEncerramento,
    this.valor,
  });

  factory Ingresso.fromJson(Map<String, dynamic> json) => Ingresso(
    id: json['id'],
    descricao: json['descricao'],
    localEvento: json['localEvento'],
    // Converter a string para DateTime
    dataEvento: DateTime.parse(json['dataEvento']),
    dataEncerramento: DateTime.parse(json['dataEncerramentoVenda']),
    valor: json['valor'].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'descricao': descricao,
    'localEvento': localEvento,
    // Converter DateTime para String
    'dataEvento': dataEvento!.toIso8601String(),
    'dataEncerramento': dataEncerramento!.toIso8601String(),
    'valor': valor,
  };
}
