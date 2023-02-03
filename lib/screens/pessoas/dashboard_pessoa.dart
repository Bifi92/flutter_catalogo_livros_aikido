import 'package:catalogo_livro_aikido/dao/pessoa.dart';
import 'package:catalogo_livro_aikido/models/livro.dart';
import 'package:catalogo_livro_aikido/models/pessoa.dart';
import 'package:catalogo_livro_aikido/utils/constantes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DashboardPessoaScreen extends StatelessWidget {
  const DashboardPessoaScreen({super.key});

  static final LivroModel livroSelecionado = LivroModel(
      id: L_VAZIO,
      nome: L_VAZIO,
      autor: L_VAZIO,
      observacao: L_VAZIO,
      emprestado: L_NAO);

  void initData(BuildContext context) {
    LivroModel livro = ModalRoute.of(context)!.settings.arguments as LivroModel;
    livroSelecionado.id = livro.id;
    livroSelecionado.nome = livro.nome;
    livroSelecionado.autor = livro.autor;
    livroSelecionado.observacao = livro.observacao;
  }

  @override
  Widget build(BuildContext context) {
    initData(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("$L_EMPRESTAR_LIVRO: ${livroSelecionado.nome}"),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, R_BUSCAR_PESSOA,
                    arguments: livroSelecionado);
              },
              child: const Icon(Icons.search)),
        ],
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: getPessoas(),
        initialData: null,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(L_NENHUMA_PESSOA_ENCONTRADA),
            );
          } else {
            final List<PessoaModel> pessoas =
                PessoaModel.mapToObjectList(snapshot.data!.docs);

            return SafeArea(
              child: ListView.builder(
                itemCount: pessoas.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(pessoas.elementAt(index).nome),
                    subtitle: Text(pessoas.elementAt(index).endereco),
                    leading: SizedBox(
                      height: 100,
                      width: 100,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            R_EMPRESTAR_LIVRO_PARA_PESSOA,
                            arguments: [
                              pessoas.elementAt(index),
                              livroSelecionado
                            ],
                          );
                        },
                        child: const Text(L_SELECIONAR),
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        R_EDITAR_PESSOA,
                        arguments: pessoas.elementAt(index),
                      );
                    },
                  );
                },
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            R_CADASTRAR_PESSOA,
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
