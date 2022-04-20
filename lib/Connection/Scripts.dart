final createTableUsuario = "CREATE TABLE IF NOT EXISTS usuario("
    "  id INTEGER PRIMARY KEY"
    ", nome TEXT NOT NULL"
    ", login TEXT NOT NULL"
    ", email TEXT NOT NULL"
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
    ", tipo_usuario TEXT"
    ", uf TEXT"
    ", id_carteira_doador TEXT"
    ", email_doador TEXT"
    ", email_solicitante TEXT"
    ", local_internacao TEXT"
    ", motivo  TEXT"
    ", qtd_bolsas INTEGER"
    ", imagem TEXT      "
    ", id_usuario INTEGER "
    ", FOREIGN KEY(id_usuario) REFERENCES usuario (id) )";

final createTableAgendamento = "CREATE TABLE IF NOT EXISTS agendamento("
    "  id INTEGER PRIMARY KEY     "
    ", local_doacao    TEXT       "
    ", horario_doacao  TEXT       "
    ", idade           TEXT       "
    ", sit_saude       TEXT       "
    ", id_doador       INT        "
    ", status          TEXT       "
    ", FOREIGN KEY(id_doador) REFERENCES doador (id) "
    ", id_usuario INTEGER "
    ", FOREIGN KEY(id_usuario) REFERENCES usuario (id) )";
