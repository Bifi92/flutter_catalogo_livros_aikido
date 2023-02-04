import 'package:catalogo_livro_aikido/models/emprestimo.dart';
import 'package:catalogo_livro_aikido/utils/constantes.dart';
import 'package:catalogo_livro_aikido/utils/widgets/image_picker_custom.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class DetalheLivroEmprestadoScreen extends StatelessWidget {
  const DetalheLivroEmprestadoScreen({super.key});

  static final TextEditingController nomePessoaTextFormFieldController =
      TextEditingController();

  static final TextEditingController nomeLivroTextFormFieldController =
      TextEditingController();

  static final TextEditingController dataRetiradaTextFormFieldController =
      TextEditingController();

  static final TextEditingController dataDevolucaoTextFormFieldController =
      TextEditingController();

  static final TextEditingController telefonePessoaTextFormFieldController =
      TextEditingController();

  static final TextEditingController nomeFotoLivroTextFormFieldController =
      TextEditingController();

  void initData(BuildContext context) {
    EmprestimoModel emprestimo =
        ModalRoute.of(context)!.settings.arguments as EmprestimoModel;

    nomePessoaTextFormFieldController.text = emprestimo.nomePessoa;
    nomeLivroTextFormFieldController.text = emprestimo.nomeLivro;
    dataRetiradaTextFormFieldController.text =
        emprestimo.dataRetirada.toString();
    dataDevolucaoTextFormFieldController.text =
        emprestimo.dataDevolucao.toString();
    telefonePessoaTextFormFieldController.text = emprestimo.telefonePessoa;
    nomeFotoLivroTextFormFieldController.text = emprestimo.nomeFotoLivro;
  }

  @override
  Widget build(BuildContext context) {
    initData(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(nomeLivroTextFormFieldController.text),
      ),
      body: Column(
        children: [
          Center(
              child: ImagePickerCustomWidget(
                  usaBotoes: false,
                  nomeFoto: nomeFotoLivroTextFormFieldController.text)),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: DateTimePicker(
                        enabled: false,
                        controller: dataRetiradaTextFormFieldController,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                        dateLabelText: L_EMPRESTAR_LIVRO_DATA_RETIRADA,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: DateTimePicker(
                        enabled: false,
                        controller: dataDevolucaoTextFormFieldController,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                        dateLabelText: L_EMPRESTAR_LIVRO_DATA_DEVOLUCAO,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        enabled: false,
                        controller: nomeLivroTextFormFieldController,
                        decoration: const InputDecoration(
                          labelText: L_LIVRO,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(25.0),
                            ),
                          ),
                        ),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        enabled: false,
                        controller: nomePessoaTextFormFieldController,
                        decoration: const InputDecoration(
                          labelText: L_PESSOA,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(25.0),
                            ),
                          ),
                        ),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        enabled: false,
                        controller: telefonePessoaTextFormFieldController,
                        decoration: const InputDecoration(
                          labelText: L_PESSOA_TELEFONE,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(25.0),
                            ),
                          ),
                        ),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
