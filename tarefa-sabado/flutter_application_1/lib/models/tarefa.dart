class Tarefa {
  String nome;
  DateTime prazo;
  bool concluida;

  Tarefa({
    required this.nome,
    required this.prazo,
    this.concluida = false,
  });

  bool get estaAtrasada {
    if (concluida) return false;
    final agora = DateTime.now();
    final hoje = DateTime(agora.year, agora.month, agora.day);
    final dataPrazo = DateTime(prazo.year, prazo.month, prazo.day);
    return dataPrazo.isBefore(hoje);
  }
}