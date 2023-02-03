import 'package:catalogo_livro_aikido/models/emprestimo.dart';
import 'package:catalogo_livro_aikido/utils/constantes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

Future<void> salvarEmprestimo(EmprestimoModel emprestimo) async {
  final emprestimoId = _firestore.collection(C_EMPRESTIMO).doc().id;

  _firestore.collection(C_EMPRESTIMO).add({
    C_EMPRESTIMO_ID: emprestimoId,
    C_EMPRESTIMO_LIVRO_ID: emprestimo.idLivro,
    C_EMPRESTIMO_PESSOA_ID: emprestimo.idPessoa,
    C_EMPRESTIMO_LIVRO_NOME: emprestimo.nomeLivro,
    C_EMPRESTIMO_PESSOA_NOME: emprestimo.nomePessoa,
    C_EMPRESTIMO_PESSOA_TELEFONE: emprestimo.telefonePessoa,
    C_EMPRESTIMO_DATA_RETIRADA: emprestimo.dataRetirada,
    C_EMPRESTIMO_DATA_DEVOLUCAO: emprestimo.dataDevolucao,
  });
}

Stream<QuerySnapshot<Map<String, dynamic>>> getLivrosEmprestados() {
  return _firestore
      .collection(C_EMPRESTIMO)
      .orderBy(C_EMPRESTIMO_DATA_DEVOLUCAO, descending: false)
      .snapshots();
}

Future<List<EmprestimoModel>> getLivrosEmprestadosPorNomeDoLivro(String nome) {
  return _firestore
      .collection(C_EMPRESTIMO)
      .where(C_EMPRESTIMO_LIVRO_NOME, isEqualTo: nome)
      .get()
      .then((QuerySnapshot<Map<String, dynamic>> snapshot) async {
    if (snapshot.docs.isEmpty) return [];
    return EmprestimoModel.mapToObjectList(snapshot.docs);
  });
}

void deletarEmprestimo(EmprestimoModel emprestimo) {
  _firestore
      .collection(C_EMPRESTIMO)
      .where(C_EMPRESTIMO_ID, isEqualTo: emprestimo.id)
      .get()
      .then((QuerySnapshot<Map<String, dynamic>> snapshot) async {
    if (snapshot.docs.isEmpty) return;
    for (DocumentSnapshot<Map<String, dynamic>> doc in snapshot.docs) {
      await doc.reference.delete();
    }
  });
}
