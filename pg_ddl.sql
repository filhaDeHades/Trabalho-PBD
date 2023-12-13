-- Criação do Schema
CREATE SCHEMA IF NOT EXISTS pbd;

-- Tabela endereco
CREATE TABLE IF NOT EXISTS pbd.endereco (
  idendereco SERIAL PRIMARY KEY,
  rua VARCHAR(45) NOT NULL,
  numero VARCHAR(20),
  bairro VARCHAR(45) NOT NULL,
  cidade VARCHAR(45) NOT NULL,
  complemento VARCHAR(120),
  UF VARCHAR(45) NOT NULL
);

-- Tabela usuario
CREATE TABLE IF NOT EXISTS pbd.usuario (
  idusuario SERIAL PRIMARY KEY,
  cpf VARCHAR(45) NOT NULL,
  nome VARCHAR(45) NOT NULL,
  senha VARCHAR(20) NOT NULL,
  id_endereco INT NOT NULL,
  data_nasc TIMESTAMP NOT NULL,
  UNIQUE (idusuario),
  UNIQUE (cpf),
  FOREIGN KEY (id_endereco) REFERENCES pbd.endereco (idendereco) ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- Tabela funcionalidade
CREATE TABLE IF NOT EXISTS pbd.funcionalidade (
  idfuncionalidade SERIAL PRIMARY KEY,
  nome VARCHAR(45) NOT NULL,
  UNIQUE (idfuncionalidade)
);

-- Tabela usuario_funcionalidade
CREATE TABLE IF NOT EXISTS pbd.usuario_funcionalidade (
  idusuario_funcionalidade SERIAL PRIMARY KEY,
  id_usuario INT NOT NULL,
  id_funcionalidade INT NOT NULL,
  UNIQUE (id_usuario),
  UNIQUE (id_funcionalidade),
  FOREIGN KEY (id_usuario) REFERENCES pbd.usuario (idusuario) ON DELETE NO ACTION ON UPDATE NO ACTION,
  FOREIGN KEY (id_funcionalidade) REFERENCES pbd.funcionalidade (idfuncionalidade) ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- Tabela agencia
CREATE TABLE IF NOT EXISTS pbd.agencia (
  nu_agencia SERIAL PRIMARY KEY,
  id_endereco INT NOT NULL,
  UNIQUE (nu_agencia),
  FOREIGN KEY (id_endereco) REFERENCES pbd.endereco (idendereco) ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- Tabela conta_bancaria
CREATE TABLE IF NOT EXISTS pbd.conta_bancaria (
  nu_conta_bancaria SERIAL PRIMARY KEY,
  nu_agencia INT NOT NULL,
  saldo DOUBLE PRECISION NOT NULL,
  UNIQUE (nu_conta_bancaria),
  FOREIGN KEY (nu_agencia) REFERENCES pbd.agencia (nu_agencia) ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- Tabela cliente
CREATE TABLE IF NOT EXISTS pbd.cliente (
  idcliente SERIAL PRIMARY KEY,
  id_usuario INT NOT NULL,
  tipo_cliente VARCHAR(45) NOT NULL,
  nu_conta_bancaria INT NOT NULL,
  UNIQUE (idcliente),
  UNIQUE (id_usuario),
  UNIQUE (nu_conta_bancaria),
  FOREIGN KEY (id_usuario) REFERENCES pbd.usuario (idusuario) ON DELETE NO ACTION ON UPDATE NO ACTION,
  FOREIGN KEY (nu_conta_bancaria) REFERENCES pbd.conta_bancaria (nu_conta_bancaria) ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- Tabela administrador
CREATE TABLE IF NOT EXISTS pbd.administrador (
  idadministrador SERIAL PRIMARY KEY,
  id_usuario INT NOT NULL,
  tipo_adm VARCHAR(45) NOT NULL,
  UNIQUE (idadministrador),
  UNIQUE (id_usuario),
  FOREIGN KEY (id_usuario) REFERENCES pbd.usuario (idusuario) ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- Tabela suporte
CREATE TABLE IF NOT EXISTS pbd.suporte (
  idsuporte SERIAL PRIMARY KEY,
  id_adm INT NOT NULL,
  id_cliente INT NOT NULL,
  dt_hora TIMESTAMP NOT NULL,
  UNIQUE (idsuporte),
  FOREIGN KEY (id_adm) REFERENCES pbd.administrador (idadministrador) ON DELETE NO ACTION ON UPDATE NO ACTION,
  FOREIGN KEY (id_cliente) REFERENCES pbd.cliente (idcliente) ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- Tabela mensagem
CREATE TABLE IF NOT EXISTS pbd.mensagem (
  idmensagem SERIAL PRIMARY KEY,
  id_suporte INT NOT NULL,
  pergunta VARCHAR(200) NOT NULL,
  resposta VARCHAR(200) NOT NULL,
  suporte_idsuporte INT NOT NULL,
  UNIQUE (idmensagem),
  FOREIGN KEY (suporte_idsuporte) REFERENCES pbd.suporte (idsuporte) ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- Tabela fundo
CREATE TABLE IF NOT EXISTS pbd.fundo (
  idfundo SERIAL PRIMARY KEY,
  nome VARCHAR(45) NOT NULL,
  valor_cota DOUBLE PRECISION NOT NULL,
  valor_minimo DOUBLE PRECISION NOT NULL,
  UNIQUE (idfundo)
);

-- Tabela transferencia
CREATE TABLE IF NOT EXISTS pbd.transferencia (
  idtransferencia SERIAL PRIMARY KEY,
  id_conta_origem INT NOT NULL,
  id_conta_destino INT NOT NULL,
  valor DOUBLE PRECISION NOT NULL,
  dt_hora TIMESTAMP NOT NULL,
  UNIQUE (idtransferencia),
  FOREIGN KEY (id_conta_origem) REFERENCES pbd.conta_bancaria (nu_conta_bancaria) ON DELETE NO ACTION ON UPDATE NO ACTION,
  FOREIGN KEY (id_conta_destino) REFERENCES pbd.conta_bancaria (nu_conta_bancaria) ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- Tabela deposito
CREATE TABLE IF NOT EXISTS pbd.deposito (
  iddeposito SERIAL PRIMARY KEY,
  valor DOUBLE PRECISION NOT NULL,
  dt_hora TIMESTAMP NOT NULL,
  id_conta INT NOT NULL,
  id_agencia INT NOT NULL,
  UNIQUE (iddeposito),
  FOREIGN KEY (id_conta) REFERENCES pbd.conta_bancaria (nu_conta_bancaria) ON DELETE NO ACTION ON UPDATE NO ACTION,
  FOREIGN KEY (id_agencia) REFERENCES pbd.agencia (nu_agencia) ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- Tabela saque
CREATE TABLE IF NOT EXISTS pbd.saque (
  idsaque SERIAL PRIMARY KEY,
  valor DOUBLE PRECISION NOT NULL,
  dt_hora TIMESTAMP NOT NULL,
  id_conta INT NOT NULL,
  id_agencia INT NOT NULL,
  UNIQUE (idsaque),
  FOREIGN KEY (id_conta) REFERENCES pbd.conta_bancaria (nu_conta_bancaria) ON DELETE NO ACTION ON UPDATE NO ACTION,
  FOREIGN KEY (id_agencia) REFERENCES pbd.agencia (nu_agencia) ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- Tabela investimento
CREATE TABLE IF NOT EXISTS pbd.investimento (
  idinvestimento SERIAL PRIMARY KEY,
  id_fundo INT NOT NULL,
  valor DOUBLE PRECISION NOT NULL,
  dt_hora TIMESTAMP NOT NULL,
  qt_cotas INT NOT NULL,
  vr_inicio DOUBLE PRECISION NOT NULL,
  conta_bancaria_nu_conta_bancaria INT NOT NULL,
  fundo_idfundo INT NOT NULL,
  UNIQUE (idinvestimento),
  FOREIGN KEY (conta_bancaria_nu_conta_bancaria) REFERENCES pbd.conta_bancaria (nu_conta_bancaria) ON DELETE NO ACTION ON UPDATE NO ACTION,
  FOREIGN KEY (fundo_idfundo) REFERENCES pbd.fundo (idfundo) ON DELETE NO ACTION ON UPDATE NO ACTION
);
