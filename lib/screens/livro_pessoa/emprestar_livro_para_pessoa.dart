import 'package:catalogo_livro_aikido/dao/emprestimo.dart';
import 'package:catalogo_livro_aikido/dao/livro.dart';
import 'package:catalogo_livro_aikido/models/emprestimo.dart';
import 'package:catalogo_livro_aikido/models/livro.dart';
import 'package:catalogo_livro_aikido/models/pessoa.dart';
import 'package:catalogo_livro_aikido/utils/constantes.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

class EmprestarLivroParaPessoaScreen extends StatelessWidget {
  const EmprestarLivroParaPessoaScreen({super.key});
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  static final TextEditingController idPessoaTextFormFieldController =
      TextEditingController();

  static final TextEditingController nomePessoaTextFormFieldController =
      TextEditingController();

  static final TextEditingController idLivroTextFormFieldController =
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

  onSalvar(BuildContext context) {
    formKey.currentState?.validate();
    emprestarLivro(idLivroTextFormFieldController.text);
    salvarEmprestimo(EmprestimoModel(
      id: L_VAZIO,
      idLivro: idLivroTextFormFieldController.text,
      idPessoa: idPessoaTextFormFieldController.text,
      nomeLivro: nomeLivroTextFormFieldController.text,
      nomePessoa: nomePessoaTextFormFieldController.text,
      telefonePessoa: telefonePessoaTextFormFieldController.text,
      dataRetirada: DateTime.parse(dataRetiradaTextFormFieldController.text),
      dataDevolucao: DateTime.parse(dataDevolucaoTextFormFieldController.text),
      nomeFotoLivro: nomeFotoLivroTextFormFieldController.text,
    ));

    Navigator.pushNamedAndRemoveUntil(
        context, R_DASHBOARD_LIVRO, (Route<dynamic> route) => false);
  }

  void initData(BuildContext context) {
    List lista = ModalRoute.of(context)!.settings.arguments as List;

    PessoaModel pessoa = lista.elementAt(0);
    LivroModel livro = lista.elementAt(1);

    idPessoaTextFormFieldController.text = pessoa.id;
    nomePessoaTextFormFieldController.text = pessoa.nome;
    telefonePessoaTextFormFieldController.text = pessoa.telefone;
    idLivroTextFormFieldController.text = livro.id;
    nomeLivroTextFormFieldController.text = livro.nome;
    dataRetiradaTextFormFieldController.text = DateTime.now().toString();
    dataDevolucaoTextFormFieldController.text = "";
    nomeFotoLivroTextFormFieldController.text = livro.nomeFoto;
  }

  @override
  Widget build(BuildContext context) {
    initData(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
            '$L_EMPRESTAR ${nomeLivroTextFormFieldController.text} para ${nomePessoaTextFormFieldController.text}'),
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
                  child: DateTimePicker(
                    controller: dataDevolucaoTextFormFieldController,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                    dateLabelText: L_EMPRESTAR_LIVRO_DATA_DEVOLUCAO,
                    onChanged: (value) =>
                        dataDevolucaoTextFormFieldController.text = value,
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
