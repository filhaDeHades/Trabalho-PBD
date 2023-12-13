# Trabalho-PBD

Trabalho para a disciplina de Projeto de Banco de Dados para Sistemas de Informação 23.2


## O Projeto
Um banco de dados de um sistema bancário

## Exigências
- [X] O modelo conceitual
- [X] O esquema relacional no SGBD escolhido (mySQL)
- [X] Cada esquema deve conter **NO MÍNIMO** 15 tabelas
- [ ] Cada grupo deve implementar **NO MÍNIMO** 5 stored procedures/funções
- [ ] Cada grupo deve implementar **NO MÍNIMO** 2 triggers
- [ ] Cada grupo deve implementar **NO MÍNIMO** 2 visões
- [ ] Cada grupo deve propor 10 consultas sobre o banco de dados desenvolvido. **PS: não vale "SELECT * FROM CLIENTE"** (+)
- [ ] Cada grupo deve implementar os índices de forma a acelerar as consultas propostas no item (+)


## Opcionais
- [ ] Permissões no banco de dados
- [ ] Fragmentação de tabelas

## Grupo
- Gabriel Desmarais
- Giovanni Toledo
- João Vicente Gaidzinski
- Tamires da Hora

## Tabelas Normalizadas
1. ENDEREÇO( <u>id_endereço</u>, rua, número, bairro, cidade, complemento, UF);
2. USUÁRIO(<u>id_usuário</u>, CPF, nome, senha, data_nascimento, id_endereço);
3. FUNCIONALIDADE(<u>id_funcionalidade</u>, nome);
4. USUÁRIO_FUNCIONALIDADE(<u>id_usuário</u>, <u>id_funcionalidade</u>);
5. AGENCIA(<u>nu_agencia</u>, id_endereço);
6. CONTA_BANCÁRIA(<u>nu_conta</u>, saldo, nu_agencia);
7. CLIENTE(<u>id_usuário</u>, tipo_cliente, nu_conta_bancaria);
8. ADMINISTRADOR(<u>id_usuário</u>, tipo_adm);
9. SUPORTE(<u>id_suporte</u>,id_adm, id_usuário, dt_hora);
10. MSG(<u>id_msg</u>, id_suporte, pergunta, resposta);
11. TRANSFERÊNCIA(<u>id_transferência</u>, valor, dt_hora, conta_origem, conta_destino);
12. DEPÓSITO(<u>id_depósito</u>, valor,dt_hora, nu_conta, nu_agencia);
13. SAQUE(<u>id_saque</u>, valor, dt_hora, nu_conta, nu_agencia);
14. FUNDO(<u>id_fundo</u>, nome, valor_cota, valor_mínimo);
15. INVESTIMENTO(<u>id_investimento</u>, dt_hora, valor, qtd_cotas, valor_inicial, id_fundo);