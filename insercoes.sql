-- INSERE ENDEREÇOS
insert into pbd.endereco (rua, numero, bairro, cidade, complemento, uf) values ('Rua A', '1', 'Bairro A', 'Niterói', '100', 'RJ'),
('Rua B', '2', 'Bairro A', 'Niterói', '201', 'RJ'),
('Rua C', '3', 'Bairro A', 'Niterói', '103', 'RJ'),
('Rua D', '4', 'Bairro A', 'Niterói', '803', 'RJ'),
('Rua E', '5', 'Bairro A', 'Niterói', '904', 'RJ'),
('Rua F', '6', 'Bairro A', 'Niterói', '103', 'RJ'),
('Rua G', '7', 'Bairro A', 'Niterói', '207', 'RJ'),
('Rua H', '8', 'Bairro A', 'Niterói', '210', 'RJ'),
('Rua I', '9', 'Bairro A', 'Niterói', '708', 'RJ'),
('Rua J', '10', 'Bairro B', 'Rio de Janeiro', '1001', 'RJ'),
('Rua K', '11', 'Bairro B', 'Rio de Janeiro', '10', 'RJ'),
('Rua L', '12', 'Bairro B', 'Rio de Janeiro', '15', 'RJ'),
('Rua M', '13', 'Bairro B', 'Rio de Janeiro', '104', 'RJ'),
('Rua N', '14', 'Bairro B', 'Rio de Janeiro', '1402', 'RJ'),
('Rua O', '15', 'Bairro B', 'Rio de Janeiro', '901', 'RJ'),
('Rua P', '16', 'Bairro C', 'Rio de Janeiro', '1903', 'RJ'),
('Rua Q', '17', 'Bairro C', 'Rio de Janeiro', '701', 'RJ'),
('Rua R', '18', 'Bairro C', 'Rio de Janeiro', '707', 'RJ'),
('Rua S', '19', 'Bairro D', 'Maricá', '1006', 'RJ'),
('Rua T', '20', 'Bairro D', 'Maricá', '501', 'RJ'),
('Rua U', '21', 'Bairro D', 'Maricá', '920', 'RJ'),
('Rua V', '22', 'Bairro D', 'Maricá', '830', 'RJ');

-- INSERE USUARIOS
insert into pbd.usuario (cpf, nome, senha, id_endereco, data_nasc) values ('11111111111', 'João Vicente', 'abc123', 1, '1998-10-21'),
('22222222222', 'Gabriel Desmarais', 'abc123', 2, '2000-01-01'),
('33333333333', 'Tamires Da Hora', 'abc123', 3, '2000-01-01'),
('44444444444', 'Giovanni Toledo', 'abc123', 4, '2000-01-01'),
('55555555555', 'Hermes Renato da Silva', 'abc123', 5, '2000-01-01'),
('66666666666', 'Alexandra Mattos', 'abc123', 6, '2000-01-01'),
('77777777777', 'Lucia Barbosa', 'abc123', 7, '2000-01-01'),
('88888888888', 'Ednaldo Pereira', 'abc123', 8, '2000-01-01'),
('99999999999', 'Emile Rodrigues', 'abc123', 9, '2000-01-01'),
('12121212121', 'Marta Vieira', 'abc123', 10, '2000-01-01');

-- INSERE FUNCIONALIDADES
insert into pbd.funcionalidade(nome) values ('Transferencia'), ('Emissão de Extrato'), ('Deleção de usuário'), ('Investimento'), ('Inclusão de usuário'), ('Cadastro de agencia'), ('Cadastro de correntista');

-- INSERE USUARIO_FUNCIONALIDADES
insert into pbd.usuario_funcionalidade (id_usuario, id_funcionalidade) values
	--clientes
(1, 1), (1, 2), (1, 4),
(2, 1), (2, 2), (2, 4),
(3, 1), (3, 2), (3, 4),
(4, 1), (4, 2), (4, 4),
(5, 1), (5, 2), (5, 4),
(6, 1), (6, 2), (6, 4),
(7, 1), (7, 2), (7, 4),
	--administradores
(8, 3), (8, 5), (8, 6), (8,7),
(9, 3), (9, 5), (9, 6), (9,7),
(10, 3), (10, 5), (10, 6), (10,7);

-- INSERE AGENCIAS
insert into pbd.agencia(id_endereco) values (11), (12), (13), (14);

-- INSERE CONTAS BANCARIAS
insert into pbd.conta_bancaria(nu_agencia, saldo) values (1, 2000), (2, 20), (1, 100), (3, 132.92), (3, 42.99), (2, 0.32), (2, 9398.72);

-- INSERE CLIENTES
insert into pbd.cliente(id_usuario, tipo_cliente, nu_conta_bancaria) values (1, 'Correntista', 7),
(2, 'Correntista', 6),
(3, 'Correntista', 5),
(4, 'Platinum', 4),
(5, 'Gold', 3),
(6, 'Correntista', 2),
(7, 'Gold', 1);

-- INSERE ADMINISTRADORES
insert into pbd.administrador (id_usuario, tipo_adm) values (8, 'Gerente'),
(9, 'Gerente'),
(10, 'Gerente');

--INSERE SUPORTE
insert into pbd.suporte (id_adm, id_cliente, dt_hora) values (1, 2, CURRENT_TIMESTAMP), (3, 5, CURRENT_TIMESTAMP);

--INSERE MENSAGENS
insert into pbd.mensagem (id_suporte, pergunta, resposta, suporte_idsuporte) values
(1, 'Boa noite, como eu faço para realizar uma transferência?', 'Boa noite, você deve acessar o menu Operações > Transferência no app.', 1),
(1, 'Ok, muito obrigado', 'Tenha uma ótima noite', 1),
(2, 'Olá, gostaria de cadastrar uma transação recorrente para enviar a mesada do meu filho', 'Bom dia, essa funcionalidade não existe em nosso banco, irei passar a sugestão para a equipe de desenvolvimento', 2),
(2, 'Certo, fico muito grato', 'Nós agradecemos a sugestão, tenha um bom dia!', 2);

--INSERE FUNDOS
insert into pbd.fundo (nome, valor_cota, valor_minimo) values ('Lojas Americanas', 3.2, 6.4), ('777 Partners', 700, 70), ('Magazine Luiza', 10, 30);


--INSERE TRANSFERENCIAS
insert into pbd.transferencia(id_conta_origem, id_conta_destino, valor, dt_hora) values (1, 7, 20, CURRENT_TIMESTAMP), (2, 6, 45, CURRENT_TIMESTAMP), (1, 2, 450, CURRENT_TIMESTAMP);

-- INSERE DEPOSITOS
insert into pbd.deposito (valor, dt_hora, id_conta, id_agencia) values (100, CURRENT_TIMESTAMP, 4, 3), (150, CURRENT_TIMESTAMP, 1, 1), (50, CURRENT_TIMESTAMP, 5, 2);

--INSERE SAQUES
insert into pbd.saque (valor, dt_hora, id_conta, id_agencia) values (100, CURRENT_TIMESTAMP, 3, 3), (150, CURRENT_TIMESTAMP, 3, 1), (50, CURRENT_TIMESTAMP, 7, 2);

--INSERE INVESTIMENTOS
insert into pbd.investimento (id_fundo, valor, dt_hora, qt_cotas, vr_inicio, conta_bancaria_nu_conta_bancaria, fundo_idfundo) values (1, 100, CURRENT_TIMESTAMP, 31.25, 3.2, 4, 1),
(2, 700, CURRENT_TIMESTAMP, 1, 700, 4, 2),
(3, 1000, CURRENT_TIMESTAMP, 100, 10, 4, 3);
















