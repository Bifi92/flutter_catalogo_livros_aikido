import 'package:catalogo_livro_aikido/dao/livro.dart';
import 'package:catalogo_livro_aikido/models/livro.dart';
import 'package:catalogo_livro_aikido/utils/constantes.dart';
import 'package:flutter/material.dart';

import '../../utils/widgets/image_picker_custom.dart';

class CadastrarLivroScreen extends StatelessWidget {
  const CadastrarLivroScreen({super.key});

  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  static final TextEditingController nomeTextFormFieldController =
      TextEditingController();

  static final TextEditingController autorTextFormFieldController =
      TextEditingController();

  static final TextEditingController observacaoTextFormFieldController =
      TextEditingController();

  static final TextEditingController nomeArquivoTextFormFieldController =
      TextEditingController();

  onSalvar(BuildContext context) {
    formKey.currentState?.validate();
    salvarLivro(
      LivroModel(
        id: L_VAZIO,
        nome: nomeTextFormFieldController.text,
        autor: autorTextFormFieldController.text,
        observacao: observacaoTextFormFieldController.text,
        emprestado: L_NAO,
        nomeFoto: nomeArquivoTextFormFieldController.text,
      ),
    );
    Navigator.pop(context);
  }

  void initData() {
    nomeTextFormFieldController.text = "";
    autorTextFormFieldController.text = "";
    observacaoTextFormFieldController.text = "";
    nomeArquivoTextFormFieldController.text = DateTime.now().toString();
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
                ImagePickerCustomWidget(
                  usaBotoes: true,
                  nomeFoto: nomeArquivoTextFormFieldController.text,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    enabled: true,
                    controller: nomeTextFormFieldController,
                    decoration: const InputDecoration(
                      labelText: L_LIVRO_NOME,
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
                    controller: autorTextFormFieldController,
                    decoration: const InputDecoration(
                      labelText: L_LIVRO_AUTOR,
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
                    maxLines: null,
                    minLines: 5,
                    controller: observacaoTextFormFieldController,
                    decoration: const InputDecoration(
                      labelText: L_LIVRO_OBSERVACAO,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(25.0),
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.multiline,
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
