import 'package:catalogo_livro_aikido/dao/livro.dart';
import 'package:catalogo_livro_aikido/models/livro.dart';
import 'package:catalogo_livro_aikido/utils/constantes.dart';
import 'package:flutter/material.dart';

class BuscarLivroScreen extends StatefulWidget {
  const BuscarLivroScreen({super.key});

  @override
  State<BuscarLivroScreen> createState() => _BuscarLivroScreenState();
}

class _BuscarLivroScreenState extends State<BuscarLivroScreen> {
  String nome = L_VAZIO;
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
            child: FutureBuilder<List<LivroModel>>(
              future: getLivrosPorNome(nome),
              initialData: const [],
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text(L_NENHUM_LIVRO_ENCONTRADO),
                  );
                } else {
                  return SafeArea(
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        List<LivroModel> livros = snapshot.data!;
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
          ),
        ],
      ),
    );
  }
}
