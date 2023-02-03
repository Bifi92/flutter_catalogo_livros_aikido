import 'package:catalogo_livro_aikido/models/livro.dart';
import 'package:catalogo_livro_aikido/utils/constantes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

Stream<QuerySnapshot<Map<String, dynamic>>> getLivros() {
  return _firestore
      .collection(C_LIVRO)
      .where(C_LIVRO_EMPRESTADO, isEqualTo: L_NAO)
      .orderBy(C_LIVRO_NOME, descending: false)
      .snapshots();
}

Future<List<LivroModel>> getLivrosPorNome(String nome) {
  return _firestore
      .collection(C_LIVRO)
      .where(C_LIVRO_EMPRESTADO, isEqualTo: L_NAO)
      .where(C_LIVRO_NOME, isEqualTo: nome)
      .get()
      .then((QuerySnapshot<Map<String, dynamic>> snapshot) async {
    if (snapshot.docs.isEmpty) return [];
    return LivroModel.mapToObjectList(snapshot.docs);
  });
}

Future<void> salvarLivro(LivroModel livro) async {
  final livroId = _firestore.collection(C_LIVRO).doc().id;

  if (livro.id != L_VAZIO) {
    _firestore
        .collection(C_LIVRO)
        .where(C_LIVRO_ID, isEqualTo: livro.id)
        .get()
        .then((QuerySnapshot<Map<String, dynamic>> snapshot) async {
      if (snapshot.docs.isEmpty) return;
      for (DocumentSnapshot<Map<String, dynamic>> doc in snapshot.docs) {
        await doc.reference.update(livro.toDoc());
      }
    });
  } else {
    _firestore.collection(C_LIVRO).add({
      C_LIVRO_ID: livroId,
      C_LIVRO_NOME: livro.nome,
      C_LIVRO_AUTOR: livro.autor,
      C_LIVRO_OBSERVACAO: livro.observacao,
      C_LIVRO_EMPRESTADO: livro.emprestado,
    });
  }
}

void deletarLivro(String idLivro) {
  _firestore
      .collection(C_LIVRO)
      .where(C_LIVRO_ID, isEqualTo: idLivro)
      .get()
      .then((QuerySnapshot<Map<String, dynamic>> snapshot) async {
    if (snapshot.docs.isEmpty) return;
    for (DocumentSnapshot<Map<String, dynamic>> doc in snapshot.docs) {
      await doc.reference.delete();
    }
  });
}

void emprestarLivro(String idLivro) {
  _firestore
      .collection(C_LIVRO)
      .where(C_LIVRO_ID, isEqualTo: idLivro)
      .get()
      .then((QuerySnapshot<Map<String, dynamic>> snapshot) async {
    if (snapshot.docs.isEmpty) return;
    for (DocumentSnapshot<Map<String, dynamic>> doc in snapshot.docs) {
      LivroModel livro = LivroModel.documentMapToObject(doc);
      livro.emprestado = L_SIM;
      await doc.reference.update(livro.toDoc());
    }
  });
}

void devolverLivro(String idLivro) {
  _firestore
      .collection(C_LIVRO)
      .where(C_LIVRO_ID, isEqualTo: idLivro)
      .get()
      .then((QuerySnapshot<Map<String, dynamic>> snapshot) async {
    if (snapshot.docs.isEmpty) return;
    for (DocumentSnapshot<Map<String, dynamic>> doc in snapshot.docs) {
      LivroModel livro = LivroModel.documentMapToObject(doc);
      livro.emprestado = L_NAO;
      await doc.reference.update(livro.toDoc());
    }
  });
}
