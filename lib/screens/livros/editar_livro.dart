import 'package:catalogo_livro_aikido/dao/livro.dart';
import 'package:catalogo_livro_aikido/models/livro.dart';
import 'package:catalogo_livro_aikido/utils/constantes.dart';
import 'package:catalogo_livro_aikido/utils/widgets/image_picker_custom.dart';
import 'package:flutter/material.dart';

class EditarLivroScreen extends StatelessWidget {
  const EditarLivroScreen({super.key});
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  static final TextEditingController idTextFormFieldController =
      TextEditingController();

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
        id: idTextFormFieldController.text,
        nome: nomeTextFormFieldController.text,
        autor: autorTextFormFieldController.text,
        observacao: observacaoTextFormFieldController.text,
        emprestado: L_NAO,
        nomeFoto: nomeArquivoTextFormFieldController.text,
      ),
    );
    Navigator.pop(context);
  }

  onDeletar(BuildContext context) {
    deletarLivro(idTextFormFieldController.text);
    Navigator.pop(context);
  }

  void initData(BuildContext context) {
    LivroModel livro = ModalRoute.of(context)!.settings.arguments as LivroModel;

    idTextFormFieldController.text = livro.id;
    nomeTextFormFieldController.text = livro.nome;
    autorTextFormFieldController.text = livro.autor;
    observacaoTextFormFieldController.text = livro.observacao;
    nomeArquivoTextFormFieldController.text = livro.nomeFoto;
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
                ImagePickerCustomWidget(
                    usaBotoes: true,
                    nomeFoto: nomeArquivoTextFormFieldController.text),
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
