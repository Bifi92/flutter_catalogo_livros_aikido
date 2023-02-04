import 'package:catalogo_livro_aikido/utils/constantes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LivroModel {
  late String id;
  late String nome;
  late String autor;
  late String observacao;
  late String emprestado;
  late String nomeFoto;

  LivroModel({
    required this.id,
    required this.nome,
    required this.autor,
    required this.observacao,
    required this.emprestado,
    required this.nomeFoto,
  });

  static mapToObjectList(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> docs) {
    List<LivroModel> response = [];

    for (QueryDocumentSnapshot<Map<String, dynamic>> doc in docs) {
      response.add(queryMapToObject(doc));
    }
    return response;
  }

  static queryMapToObject(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    return LivroModel(
      id: doc[C_LIVRO_ID],
      nome: doc[C_LIVRO_NOME],
      autor: doc[C_LIVRO_AUTOR],
      observacao: doc[C_LIVRO_OBSERVACAO],
      emprestado: doc[C_LIVRO_EMPRESTADO],
      nomeFoto: doc[C_LIVRO_NOME_FOTO],
    );
  }

  static documentMapToObject(DocumentSnapshot<Map<String, dynamic>> doc) {
    return LivroModel(
      id: doc[C_LIVRO_ID],
      nome: doc[C_LIVRO_NOME],
      autor: doc[C_LIVRO_AUTOR],
      observacao: doc[C_LIVRO_OBSERVACAO],
      emprestado: doc[C_LIVRO_EMPRESTADO],
      nomeFoto: doc[C_LIVRO_NOME_FOTO],
    );
  }

  Map<String, dynamic> toDoc() {
    return {
      C_LIVRO_ID: id,
      C_LIVRO_NOME: nome,
      C_LIVRO_AUTOR: autor,
      C_LIVRO_OBSERVACAO: observacao,
      C_LIVRO_EMPRESTADO: emprestado,
      C_LIVRO_NOME_FOTO: nomeFoto,
    };
  }
}
