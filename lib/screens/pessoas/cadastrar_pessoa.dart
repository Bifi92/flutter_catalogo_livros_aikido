import 'package:catalogo_livro_aikido/dao/pessoa.dart';
import 'package:catalogo_livro_aikido/models/pessoa.dart';
import 'package:catalogo_livro_aikido/utils/constantes.dart';
import 'package:flutter/material.dart';

class CadastrarPessoaScreen extends StatelessWidget {
  const CadastrarPessoaScreen({super.key});

  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  static final TextEditingController nomeTextFormFieldController =
      TextEditingController();

  static final TextEditingController enderecoTextFormFieldController =
      TextEditingController();

  static final TextEditingController telefoneTextFormFieldController =
      TextEditingController();

  onSalvar(BuildContext context) {
    formKey.currentState?.validate();
    salvarPessoa(
      PessoaModel(
        id: L_VAZIO,
        nome: nomeTextFormFieldController.text,
        endereco: enderecoTextFormFieldController.text,
        telefone: telefoneTextFormFieldController.text,
      ),
    );
    Navigator.pop(context);
  }

  void initData() {
    nomeTextFormFieldController.text = "";
    enderecoTextFormFieldController.text = "";
    telefoneTextFormFieldController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    initData();
    return Scaffold(
      appBar: AppBar(
        title: const Text(L_CADASTRAR),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    enabled: true,
                    controller: nomeTextFormFieldController,
                    decoration: const InputDecoration(
                      labelText: L_PESSOA_NOME,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(25.0),
                        ),
                      ),
                    ),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return E_CAMPO_OBRIGATORIO;
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    enabled: true,
                    controller: enderecoTextFormFieldController,
                    decoration: const InputDecoration(
                      labelText: L_PESSOA_ENDERECO,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(25.0),
                        ),
                      ),
                    ),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return E_CAMPO_OBRIGATORIO;
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    enabled: true,
                    controller: telefoneTextFormFieldController,
                    decoration: const InputDecoration(
                      labelText: L_PESSOA_TELEFONE,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(25.0),
                        ),
                      ),
                    ),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return E_CAMPO_OBRIGATORIO;
                      }
                      return null;
                    },
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            onPressed: () {
                              onSalvar(context);
                            },
                            child: const Text(L_SALVAR)),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
