import 'package:catalogo_livro_aikido/screens/livro_pessoa/emprestar_livro_para_pessoa.dart';
import 'package:catalogo_livro_aikido/screens/livros/buscar_livro.dart';
import 'package:catalogo_livro_aikido/screens/livros/cadastrar_livro.dart';
import 'package:catalogo_livro_aikido/screens/livros/dashboard_livro.dart';
import 'package:catalogo_livro_aikido/screens/livros/editar_livro.dart';
import 'package:catalogo_livro_aikido/screens/livros_eprestados/buscar_livro_emprestado.dart';
import 'package:catalogo_livro_aikido/screens/livros_eprestados/dashboard_livro_emprestado.dart';
import 'package:catalogo_livro_aikido/screens/livros_eprestados/detalhe_livro_emprestado.dart';
import 'package:catalogo_livro_aikido/screens/pessoas/buscar_pessoa.dart';
import 'package:catalogo_livro_aikido/screens/pessoas/cadastrar_pessoa.dart';
import 'package:catalogo_livro_aikido/screens/pessoas/dashboard_pessoa.dart';
import 'package:catalogo_livro_aikido/screens/pessoas/editar_pessoa.dart';
import 'package:catalogo_livro_aikido/utils/constantes.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> rotas = {
  R_DASHBOARD_LIVRO: (context) => const DashboardLivroScreen(),
  R_CADASTRAR_LIVRO: (context) => const CadastrarLivroScreen(),
  R_EDITAR_LIVRO: (context) => const EditarLivroScreen(),
  R_DASHBOARD_PESSOA: (context) => const DashboardPessoaScreen(),
  R_CADASTRAR_PESSOA: (context) => const CadastrarPessoaScreen(),
  R_EDITAR_PESSOA: (context) => const EditarPessoaScreen(),
  R_EMPRESTAR_LIVRO_PARA_PESSOA: (context) =>
      const EmprestarLivroParaPessoaScreen(),
  R_DASHBOARD_LIVRO_EMPRESTADO: (context) =>
      const DashboardLivroEmprestadoScreen(),
  R_DETALHE_LIVRO_EMPRESTADO: (context) => const DetalheLivroEmprestadoScreen(),
  R_BUSCAR_LIVRO: (context) => const BuscarLivroScreen(),
  R_BUSCAR_LIVRO_EMPRESTADO: (context) => const BuscarLivroEmprestadoScreen(),
  R_BUSCAR_PESSOA: (context) => const BuscarPessoaScreen(),
};
