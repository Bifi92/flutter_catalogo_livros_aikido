import 'package:catalogo_livro_aikido/models/pessoa.dart';
import 'package:catalogo_livro_aikido/utils/constantes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

Stream<QuerySnapshot<Map<String, dynamic>>> getPessoas() {
  return _firestore
      .collection(C_PESSOA)
      .orderBy(C_PESSOA_NOME, descending: false)
      .snapshots();
}

Future<List<PessoaModel>> getPessoasPorNome(String nome) {
  return _firestore
      .collection(C_PESSOA)
      .where(C_PESSOA_NOME, isEqualTo: nome)
      .get()
      .then((QuerySnapshot<Map<String, dynamic>> snapshot) async {
    if (snapshot.docs.isEmpty) return [];
    return PessoaModel.mapToObjectList(snapshot.docs);
  });
}

Future<void> salvarPessoa(PessoaModel pessoa) async {
  final pessoaId = _firestore.collection(C_LIVRO).doc().id;

  if (pessoa.id != L_VAZIO) {
    _firestore
        .collection(C_PESSOA)
        .where(C_PESSOA_ID, isEqualTo: pessoa.id)
        .get()
        .then((QuerySnapshot<Map<String, dynamic>> snapshot) async {
      if (snapshot.docs.isEmpty) return;
      for (DocumentSnapshot<Map<String, dynamic>> doc in snapshot.docs) {
        await doc.reference.update(pessoa.toDoc());
      }
    });
  } else {
    _firestore.collection(C_PESSOA).add({
      C_PESSOA_ID: pessoaId,
      C_PESSOA_NOME: pessoa.nome,
      C_PESSOA_ENDERECO: pessoa.endereco,
      C_PESSOA_TELEFONE: pessoa.telefone,
    });
  }
}

void deletarPessoa(String idPessoa) {
  _firestore
      .collection(C_PESSOA)
      .where(C_PESSOA_ID, isEqualTo: idPessoa)
      .get()
      .then((QuerySnapshot<Map<String, dynamic>> snapshot) async {
    if (snapshot.docs.isEmpty) return;
    for (DocumentSnapshot<Map<String, dynamic>> doc in snapshot.docs) {
      await doc.reference.delete();
    }
  });
}
