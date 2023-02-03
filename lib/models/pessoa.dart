import 'package:catalogo_livro_aikido/utils/constantes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PessoaModel {
  late String id;
  late String nome;
  late String endereco;
  late String telefone;

  PessoaModel({
    required this.id,
    required this.nome,
    required this.endereco,
    required this.telefone,
  });

  static mapToObjectList(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> docs) {
    List<PessoaModel> response = [];

    for (QueryDocumentSnapshot<Map<String, dynamic>> doc in docs) {
      response.add(queryMapToObject(doc));
    }
    return response;
  }

  static queryMapToObject(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    return PessoaModel(
      id: doc[C_PESSOA_ID],
      nome: doc[C_PESSOA_NOME],
      endereco: doc[C_PESSOA_ENDERECO],
      telefone: doc[C_PESSOA_TELEFONE],
    );
  }

  Map<String, dynamic> toDoc() {
    return {
      C_PESSOA_ID: id,
      C_PESSOA_NOME: nome,
      C_PESSOA_ENDERECO: endereco,
      C_PESSOA_TELEFONE: telefone,
    };
  }
}
