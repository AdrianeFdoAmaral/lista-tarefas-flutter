import 'package:flutter/material.dart';
import '../models/tarefa.dart';
import '../utils/data_formatter.dart';

class TarefaCard extends StatelessWidget {
  final Tarefa tarefa;
  final ValueChanged<bool?> onToggle;
  final VoidCallback onDelete;

  const TarefaCard({
    super.key,
    required this.tarefa,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final atrasada = tarefa.estaAtrasada;

    return Card(
      color: atrasada ? Colors.red.shade50 : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: atrasada ? Colors.red.shade400 : Colors.grey.shade300,
          width: atrasada ? 1.5 : 1,
        ),
      ),
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Checkbox(
          value: tarefa.concluida,
          onChanged: onToggle,
        ),
        title: Text(
          tarefa.nome,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            decoration: tarefa.concluida ? TextDecoration.lineThrough : null,
            color: tarefa.concluida ? Colors.grey : null,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Row(
            children: [
              Icon(
                atrasada ? Icons.warning_amber_rounded : Icons.event,
                size: 16,
                color: atrasada ? Colors.red.shade700 : Colors.grey.shade700,
              ),
              const SizedBox(width: 6),
              Text(
                atrasada
                    ? 'Conclusão: ${formatarData(tarefa.prazo)} (ATRASADA)'
                    : 'Conclusão: ${formatarData(tarefa.prazo)}',
                style: TextStyle(
                  color: atrasada ? Colors.red.shade700 : Colors.grey.shade700,
                  fontWeight: atrasada ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline),
          color: Colors.grey.shade700,
          onPressed: onDelete,
        ),
      ),
    );
  }
}