import 'package:flutter/material.dart';
import '../models/tarefa.dart';
import '../utils/data_formatter.dart';
import '../widgets/tarefa_card.dart';

class ListaTarefasPage extends StatefulWidget {
  const ListaTarefasPage({super.key});

  @override
  State<ListaTarefasPage> createState() => _ListaTarefasPageState();
}

class _ListaTarefasPageState extends State<ListaTarefasPage> {
  final TextEditingController _nomeController = TextEditingController();
  DateTime? _dataSelecionada;
  final List<Tarefa> _tarefas = [];

  Future<void> _selecionarData() async {
    final DateTime? escolhida = await showDatePicker(
      context: context,
      initialDate: _dataSelecionada ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (escolhida != null) {
      setState(() {
        _dataSelecionada = escolhida;
      });
    }
  }

  void _adicionarTarefa() {
    final nome = _nomeController.text.trim();

    if (nome.isEmpty || _dataSelecionada == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Informe o nome da tarefa e a data de conclusão.'),
        ),
      );
      return;
    }

    setState(() {
      _tarefas.add(Tarefa(nome: nome, prazo: _dataSelecionada!));
      _nomeController.clear();
      _dataSelecionada = null;
    });
  }

  void _alternarConclusao(int index, bool? valor) {
    setState(() {
      _tarefas[index].concluida = valor ?? false;
    });
  }

  void _removerTarefa(int index) {
    setState(() {
      _tarefas.removeAt(index);
    });
  }

  @override
  void dispose() {
    _nomeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Tarefas'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(
                labelText: 'Nome da tarefa',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _selecionarData,
                    icon: const Icon(Icons.calendar_today),
                    label: Text(
                      _dataSelecionada == null
                          ? 'Selecionar prazo'
                          : 'Prazo: ${formatarData(_dataSelecionada!)}',
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                FilledButton.icon(
                  onPressed: _adicionarTarefa,
                  icon: const Icon(Icons.add),
                  label: const Text('Adicionar'),
                ),
              ],
            ),
            const Divider(height: 32),
            Expanded(
              child: _tarefas.isEmpty
                  ? const Center(child: Text('Nenhuma tarefa cadastrada.'))
                  : ListView.builder(
                      itemCount: _tarefas.length,
                      itemBuilder: (context, index) {
                        return TarefaCard(
                          tarefa: _tarefas[index],
                          onToggle: (valor) => _alternarConclusao(index, valor),
                          onDelete: () => _removerTarefa(index),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}