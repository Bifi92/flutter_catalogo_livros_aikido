// Geral
const String L_FORMADO_DATA = "dd/MM/yyyy";
const String L_SIM = "SIM";
const String L_NAO = "NAO";

// Erros
const String E_CAMPO_OBRIGATORIO = "Campo obrigatório";

// Coleções
const String C_LIVRO = "livros";
const String C_PESSOA = "pessoas";
const String C_EMPRESTIMO = "emprestimos";

// Campos
// Livros
const String C_LIVRO_ID = "id";
const String C_LIVRO_NOME = "nome";
const String C_LIVRO_AUTOR = "autor";
const String C_LIVRO_OBSERVACAO = "observacao";
const String C_LIVRO_EMPRESTADO = "emprestado";
// Pessoas
const String C_PESSOA_ID = "id";
const String C_PESSOA_NOME = "nome";
const String C_PESSOA_ENDERECO = "endereco";
const String C_PESSOA_TELEFONE = "telefone";
//Emprestimos
const String C_EMPRESTIMO_ID = "id";
const String C_EMPRESTIMO_LIVRO_ID = "idLivro";
const String C_EMPRESTIMO_PESSOA_ID = "idPessoa";
const String C_EMPRESTIMO_LIVRO_NOME = "nomeLivro";
const String C_EMPRESTIMO_PESSOA_NOME = "nomePessoa";
const String C_EMPRESTIMO_DATA_RETIRADA = "dataRetirada";
const String C_EMPRESTIMO_DATA_DEVOLUCAO = "dataDevolucao";
const String C_EMPRESTIMO_PESSOA_TELEFONE = "telefonePessoa";

// Labels
const String L_VAZIO = "";
const String L_SALVAR = "Salvar";
const String L_DELETAR = "Deletar";
const String L_EMPRESTAR = "Emprestar";
const String L_SELECIONAR = "Selecionar";
// Livros
const String L_CATALOGO_DE_LIVROS = 'Catalogo de livros';
const String L_NENHUM_LIVRO_ENCONTRADO = "Nenhum livro encontrado";
const String L_CADASTRAR = "Cadastrar Livro";
const String L_LIVRO_NOME = "Nome";
const String L_LIVRO_AUTOR = "Autor";
const String L_LIVRO_OBSERVACAO = "Observação";
const String L_EDITAR = "Editar Livro";
const String L_EMPRESTADOS = "Emprestados";
const String L_BUSCAR = "Buscar";
const String L_BUSCAR_LIVROS = "Buscar Livros";
// Pessoas
const String L_NENHUMA_PESSOA_ENCONTRADA = "Nenhuma pessoa encontrada";
const String L_PESSOA_NOME = "Nome";
const String L_PESSOA_ENDERECO = "Endereço";
const String L_PESSOA_TELEFONE = "Telefone";
const String L_BUSCAR_PESSOAS = "Buscar Pessoas";
//Emprestar Livros
const String L_EMPRESTAR_LIVRO = "Emprestar Livro";
const String L_EMPRESTAR_LIVRO_DATA_DEVOLUCAO = "Data de devolução";
// Livros Emprestados
const String L_CATALOGO_DE_LIVROS_EMPRESTADOS = "Livros emprestados";
const String L_DEVOLVER = "Devolver";
const String L_LIVRO = "Livro";
const String L_PESSOA = "Pessoa";
const String L_EMPRESTAR_LIVRO_DATA_RETIRADA = "Data de retirada";

// Rotas
// Livros
const String R_DASHBOARD_LIVRO = "/dashboard_livro";
const String R_CADASTRAR_LIVRO = "/cadastrar_livro";
const String R_EDITAR_LIVRO = "/editar_livro";
const String R_BUSCAR_LIVRO = "/buscar_livro";
// Pessoas
const String R_DASHBOARD_PESSOA = "/dashboard_pessoa";
const String R_EDITAR_PESSOA = "/editar_pessoa";
const String R_CADASTRAR_PESSOA = "/cadastrar_pessoa";
const String R_BUSCAR_PESSOA = "/buscar_pessoa";
// Emprestar Livros
const String R_EMPRESTAR_LIVRO_PARA_PESSOA = "/emprestar_livro_para_pessoa";
// Livros Emprestados
const String R_DASHBOARD_LIVRO_EMPRESTADO = "/dashboard_livro_emprestado";
const String R_DETALHE_LIVRO_EMPRESTADO = "/detalhe_livro_emprestado";
const String R_BUSCAR_LIVRO_EMPRESTADO = "/buscar_livro_emprestado";
