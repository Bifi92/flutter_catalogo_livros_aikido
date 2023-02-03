import 'package:catalogo_livro_aikido/dao/livro.dart';
import 'package:catalogo_livro_aikido/models/livro.dart';
import 'package:catalogo_livro_aikido/utils/constantes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DashboardLivroScreen extends StatelessWidget {
  const DashboardLivroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(L_CATALOGO_DE_LIVROS),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  R_BUSCAR_LIVRO,
                );
              },
              child: const Icon(Icons.search)),
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  R_DASHBOARD_LIVRO_EMPRESTADO,
                );
              },
              child: const Text(L_EMPRESTADOS))
        ],
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: getLivros(),
        initialData: null,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(L_NENHUM_LIVRO_ENCONTRADO),
            );
          } else {
            final List<LivroModel> livros =
                LivroModel.mapToObjectList(snapshot.data!.docs);

            return SafeArea(
              child: ListView.builder(
                itemCount: livros.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(livros.elementAt(index).nome),
                    subtitle: Text(livros.elementAt(index).autor),
                    leading: SizedBox(
                      height: 100,
                      width: 100,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            R_DASHBOARD_PESSOA,
                            arguments: livros.elementAt(index),
                          );
                        },
                        child: const Text(L_EMPRESTAR),
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        R_EDITAR_LIVRO,
                        arguments: livros.elementAt(index),
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
            R_CADASTRAR_LIVRO,
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
