import 'package:catalogo_livro_aikido/dao/livro.dart';
import 'package:catalogo_livro_aikido/dao/pessoa.dart';
import 'package:catalogo_livro_aikido/models/livro.dart';
import 'package:catalogo_livro_aikido/models/pessoa.dart';
import 'package:catalogo_livro_aikido/utils/constantes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BuscarPessoaScreen extends StatefulWidget {
  const BuscarPessoaScreen({super.key});

  @override
  State<BuscarPessoaScreen> createState() => _BuscarPessoaScreenState();
}

class _BuscarPessoaScreenState extends State<BuscarPessoaScreen> {
  String nome = "";

  static final LivroModel livroSelecionado = LivroModel(
      id: L_VAZIO,
      nome: L_VAZIO,
      autor: L_VAZIO,
      observacao: L_VAZIO,
      emprestado: L_NAO,
      nomeFoto: L_VAZIO);

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
        title: const Text(L_BUSCAR_PESSOAS),
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
                      labelText: L_PESSOA_NOME,
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
            child: FutureBuilder<List<PessoaModel>>(
              future: getPessoasPorNome(nome),
              initialData: const [],
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text(L_NENHUMA_PESSOA_ENCONTRADA),
                  );
                } else {
                  return SafeArea(
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        List<PessoaModel> pessoas = snapshot.data!;
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
          ),
        ],
      ),
    );
  }
}
