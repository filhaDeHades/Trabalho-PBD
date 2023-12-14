-- Trigger para atualizar saldo ao fazer um SAQUE
create or replace function atualizar_saldo_saque() RETURNS trigger AS $$
	begin
		update conta_bancaria set saldo = saldo - new.valor where nu_conta_bancaria = new.id_conta;
		return new;
	end;
 $$ LANGUAGE plpgsql;

create or replace trigger att_saldo_saque
after insert on saque
for each row
execute function atualizar_saldo_saque();

insert into saque (valor, dt_hora, id_conta, id_agencia) values (100, CURRENT_TIMESTAMP, 3, 3);

-- Trigger para atualizar saldo ao fazer um DEPOSITO
create or replace function atualizar_saldo_deposito() RETURNS trigger AS $$
	begin
		update conta_bancaria set saldo = saldo + new.valor where nu_conta_bancaria = new.id_conta;
		return new;
	end;
 $$ LANGUAGE plpgsql;

create or replace trigger att_saldo_saque
after insert on deposito
for each row
execute function atualizar_saldo_deposito();

insert into deposito (valor, dt_hora, id_conta, id_agencia) values (100, CURRENT_TIMESTAMP, 4, 3);

-- Trigger para atualizar saldo das contas ao fazer um TRANSFERENCIA (somar para destino, subtrair para origem)
create or replace function atualizar_saldo_transf() RETURNS trigger AS $$
	begin
		update conta_bancaria set saldo = saldo - new.valor where nu_conta_bancaria = new.id_conta_origem;
		update conta_bancaria set saldo = saldo + new.valor where nu_conta_bancaria = new.id_conta_destino;
		return new;
	end;
 $$ LANGUAGE plpgsql;

create or replace trigger att_saldo_transf
after insert on transferencia
for each row
execute function atualizar_saldo_transf();

insert into transferencia(id_conta_origem, id_conta_destino, valor, dt_hora) values (1, 7, 20, CURRENT_TIMESTAMP);

-- Trigger para remover adicionar DEPOSITO e atualizar saldo quando o usuario resgatar um investimento
create or replace function resgate_investimento() RETURNS trigger AS $$
	declare valorResgatado float;
	begin
		select i.qt_cotas * f.valor_cota into valorResgatado from investimento i join fundo f on i.fundo_idfundo = f.idfundo where i.idinvestimento = old.idinvestimento;
		insert INTO deposito (valor, dt_hora, id_conta, id_agencia) values (valorResgatado, CURRENT_TIMESTAMP, old.conta_bancaria_nu_conta_bancaria, 1);
		--update conta_bancaria set saldo = saldo + valorResgatado where nu_conta_bancaria = old.conta_bancaria_nu_conta_bancaria;
		return old;
	end;
 $$ LANGUAGE plpgsql;

create or replace trigger resgatar_investimento
before delete on investimento
for each row
execute function resgate_investimento();

delete from investimento where idinvestimento = 8;

select i.qt_cotas * f.valor_cota valor from investimento i join fundo f on i.fundo_idfundo = f.idfundo where i.idinvestimento = 7;











