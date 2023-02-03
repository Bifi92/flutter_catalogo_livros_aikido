import 'package:catalogo_livro_aikido/dao/pessoa.dart';
import 'package:catalogo_livro_aikido/models/pessoa.dart';
import 'package:catalogo_livro_aikido/utils/constantes.dart';
import 'package:flutter/material.dart';

class EditarPessoaScreen extends StatelessWidget {
  const EditarPessoaScreen({super.key});
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  static final TextEditingController idTextFormFieldController =
      TextEditingController();

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
        id: idTextFormFieldController.text,
        nome: nomeTextFormFieldController.text,
        endereco: enderecoTextFormFieldController.text,
        telefone: telefoneTextFormFieldController.text,
      ),
    );
    Navigator.pop(context);
  }

  onDeletar(BuildContext context) {
    deletarPessoa(idTextFormFieldController.text);
    Navigator.pop(context);
  }

  void initData(BuildContext context) {
    PessoaModel pessoa =
        ModalRoute.of(context)!.settings.arguments as PessoaModel;

    idTextFormFieldController.text = pessoa.id;
    nomeTextFormFieldController.text = pessoa.nome;
    enderecoTextFormFieldController.text = pessoa.endereco;
    telefoneTextFormFieldController.text = pessoa.telefone;
  }

  @override
  Widget build(BuildContext context) {
    initData(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(L_EDITAR),
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
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            onPressed: () {
                              onDeletar(context);
                            },
                            child: const Text(L_DELETAR)),
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
