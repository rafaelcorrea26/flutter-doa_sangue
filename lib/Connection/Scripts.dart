final createTableUsuario = "CREATE TABLE IF NOT EXISTS usuario("
    "  id INTEGER PRIMARY KEY"
    ", nome TEXT"
    ", login TEXT"
    ", email TEXT"
    ", senha TEXT"
    ", imagem TEXT)";

final createTableDoador = "CREATE TABLE IF NOT EXISTS doador("
    "  id INTEGER PRIMARY KEY"
    ", nome_completo TEXT"
    ", nome_mae TEXT"
    ", nome_pai TEXT"
    ", genero TEXT"
    ", data_nasc TEXT"
    ", cpf TEXT"
    ", celular TEXT"
    ", rg TEXT"
    ", tipo_sangue TEXT"
    ", uf TEXT"
    ", id_carteira_doador TEXT"
    ", email_doador TEXT"
    ", email_solicitante TEXT"
    ", local_internacao TEXT"
    ", motivo  TEXT"
    ", qtd_bolsas INTEGER"
    ", imagem TEXT )";
