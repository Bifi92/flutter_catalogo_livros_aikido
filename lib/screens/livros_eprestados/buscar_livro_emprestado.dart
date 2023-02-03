import 'package:catalogo_livro_aikido/dao/emprestimo.dart';
import 'package:catalogo_livro_aikido/dao/livro.dart';
import 'package:catalogo_livro_aikido/models/emprestimo.dart';
import 'package:catalogo_livro_aikido/models/livro.dart';
import 'package:catalogo_livro_aikido/utils/constantes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BuscarLivroEmprestadoScreen extends StatefulWidget {
  const BuscarLivroEmprestadoScreen({super.key});

  @override
  State<BuscarLivroEmprestadoScreen> createState() =>
      _BuscarLivroEmprestadoScreenState();
}

class _BuscarLivroEmprestadoScreenState
    extends State<BuscarLivroEmprestadoScreen> {
  String nome = "";

  void onDevolver(EmprestimoModel emprestimo) {
    devolverLivro(emprestimo.idLivro);
    deletarEmprestimo(emprestimo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(L_BUSCAR_LIVROS),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    enabled: true,
                    decoration: const InputDecoration(
                      labelText: L_LIVRO_NOME,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(25.0),
                        ),
                      ),
                    ),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    onChanged: (value) {
                      setState(() {
                        nome = value;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: FutureBuilder<List<EmprestimoModel>>(
              future: getLivrosEmprestadosPorNomeDoLivro(nome),
              initialData: const [],
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text(L_NENHUM_LIVRO_ENCONTRADO),
                  );
                } else {
                  DateTime dataAtual = DateTime.now();
                  return SafeArea(
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        List<EmprestimoModel> emprestimos = snapshot.data!;

                        bool faltaUmaSemana = emprestimos
                            .elementAt(index)
                            .dataDevolucao
                            .isBefore(dataAtual.add(const Duration(days: 7)));

                        bool atrasado = emprestimos
                            .elementAt(index)
                            .dataDevolucao
                            .isBefore(dataAtual);

                        bool alteraCor = faltaUmaSemana || atrasado;

                        Color corTexto = Colors.black;

                        if (faltaUmaSemana) {
                          corTexto = Colors.yellow.shade800;
                        }

                        if (atrasado) {
                          corTexto = Colors.red;
                        }

                        return ListTile(
                          textColor: alteraCor ? corTexto : null,
                          title: Text(
                              '$L_LIVRO: ${emprestimos.elementAt(index).nomeLivro}'),
                          subtitle: Text(
                              '$L_PESSOA: ${emprestimos.elementAt(index).nomePessoa}'),
                          leading: SizedBox(
                            height: 100,
                            width: 100,
                            child: ElevatedButton(
                              onPressed: () {
                                onDevolver(emprestimos.elementAt(index));
                              },
                              child: const Text(L_DEVOLVER),
                            ),
                          ),
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              R_DETALHE_LIVRO_EMPRESTADO,
                              arguments: emprestimos.elementAt(index),
                            );
                          },
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
