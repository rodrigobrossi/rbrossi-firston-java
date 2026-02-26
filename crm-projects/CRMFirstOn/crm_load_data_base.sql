//Tipo relação
INSERT INTO CRM_TIPO_RELACAO (TIR_TIPO_RELACAO, TIR_OBSERVACAO) VALUES ('CLIENTE', '');
INSERT INTO CRM_TIPO_RELACAO (TIR_TIPO_RELACAO, TIR_OBSERVACAO) VALUES ('FUNCIONARIO', '');
INSERT INTO CRM_TIPO_RELACAO (TIR_TIPO_RELACAO, TIR_OBSERVACAO) VALUES ('PRESTADOR DE SERVICO', '');
INSERT INTO CRM_TIPO_RELACAO (TIR_TIPO_RELACAO, TIR_OBSERVACAO) VALUES ('FORNECEDOR', '');

//Clube Cliente
insert into crm_clube_cliente(ccl_titulo,ccl_observacao) values ('Beneficiário','Just a fake test');
insert into crm_clube_cliente(ccl_titulo,ccl_observacao) values ('Caliber','Just a fake test');
insert into crm_clube_cliente(ccl_titulo,ccl_observacao) values ('Baunce','Just a fake test');
insert into crm_clube_cliente(ccl_titulo,ccl_observacao) values ('Prospect needs','Just a fake test');


//Software para pesquisa de elementos na base
insert into public.crm_crenca_cliente(crc_titulo,crc_observacao,crc_dica_relacionamento) values('Católica','Fanatico','Não comentar de outras religiões perto dele')
insert into public.crm_profissao_cliente(pfc_titulo) values('Engenheiro desoftware Jr')
insert into public.crm_esporte_cliente(esp_titulo,esp_observacao) values('Judô','Campeão Brasileiro')
insert into public.crm_lazer_cliente(laz_titulo,laz_observacao, laz_dica_relacionamento) values('Futebol','Tricolor de coração','Gosta de camisetas do time')
insert into public.crm_usuarios(usr_nome_usuario,usr_senha_usuario,laz_id_fk,esp_id_fk,crc_id_fk,tir_id_fk,pfc_id_fk ) values('Rodrigo','kazu99',1,1,1,1,1)

//Users
insert into crm_lazer_cliente(laz_titulo,laz_observacao,laz_dica_relacionamento)
values ('Futebol','Zagueiro','Futebol Arte')

insert into crm_esporte_cliente(esp_titulo,esp_observacao)
values ('Tenis','Iniciante')

insert into crm_crenca_cliente(crc_titulo,crc_observacao,crc_dica_relacionamento)
values ('Catolico','Praticante','Irmao')

insert into crm_profissao_cliente(pfc_titulo,pfc_observacao,pfc_dca_relacionamento)
values ('Engenheiro','Junior','CLT')

insert into crm_usuarios(usr_nome_usuario,laz_id_fk,esp_id_fk,crc_id_fk,tir_id_fk,pfc_id_fk)
values ('Rodrigo Rocha Costa',1,1,1,103,1)

insert into crm_usuarios(usr_nome_usuario,laz_id_fk,esp_id_fk,crc_id_fk,tir_id_fk,pfc_id_fk)
values ('Priscila Rocha Costa',1,1,1,103,1)

insert into crm_usuarios(usr_nome_usuario,laz_id_fk,esp_id_fk,crc_id_fk,tir_id_fk,pfc_id_fk)
values ('Rodrigo Nolli Brossi',1,1,1,103,1)