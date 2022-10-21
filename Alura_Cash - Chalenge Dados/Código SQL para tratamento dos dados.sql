USE alura_cash;

SELECT * FROM dados_mutuarios;
SELECT * FROM emprestimos;
SELECT * FROM historicos_banco;
SELECT * FROM ids;

SELECT * FROM dados_mutuarios WHERE 
	person_id IS NULL OR 
	person_age IS NULL OR 
    person_income IS NULL OR 
    person_home_ownership IS NULL OR 
    person_emp_length IS NULL;
SELECT * FROM emprestimos WHERE 
	loan_id IS NULL OR 
    loan_intent IS NULL OR 
    loan_grade IS NULL OR 
    loan_amnt IS NULL OR 
    loan_int_rate IS NULL OR 
    loan_status IS NULL OR 
    loan_percent_income IS NULL;
SELECT * FROM historicos_banco WHERE 
	cb_id IS NULL OR 
    cb_person_default_on_file IS NULL OR 
    cb_person_cred_hist_length IS NULL;
SELECT * FROM ids WHERE 
	person_id IS NULL OR 
    loan_id IS NULL OR 
    cb_id IS NULL;
    
DELETE FROM dados_mutuarios WHERE 
	person_id IS NULL OR 
	person_age IS NULL OR 
    person_income IS NULL OR 
    person_home_ownership IS NULL OR 
    person_emp_length IS NULL;
DELETE FROM emprestimos WHERE 
	loan_id IS NULL OR 
    loan_intent IS NULL OR 
    loan_grade IS NULL OR 
    loan_amnt IS NULL OR 
    loan_int_rate IS NULL OR 
    loan_status IS NULL OR 
    loan_percent_income IS NULL;
DELETE FROM historicos_banco WHERE 
	cb_id IS NULL OR 
    cb_person_default_on_file IS NULL OR 
    cb_person_cred_hist_length IS NULL;

SELECT * FROM dados_mutuarios WHERE 
	person_id = '' OR 
	person_home_ownership = '';
SELECT * FROM emprestimos WHERE 
	loan_id = '' OR 
    loan_intent = '' OR 
    loan_grade = '';
SELECT * FROM historicos_banco WHERE 
	cb_id = '' OR 
    cb_person_default_on_file = '';
SELECT * FROM ids WHERE 
	person_id = '' OR 
    loan_id = '' OR 
    cb_id = '';
    
DELETE FROM dados_mutuarios WHERE 
	person_id = '' OR 
	person_home_ownership = '';
DELETE FROM emprestimos WHERE 
	loan_id = '' OR 
    loan_intent = '' OR 
    loan_grade = '';
DELETE FROM historicos_banco WHERE 
	cb_id = '' OR 
    cb_person_default_on_file = '';

SELECT ids.*, `dados_mutuarios`.`person_age`, `dados_mutuarios`.`person_income`, 
`dados_mutuarios`.`person_home_ownership`, `dados_mutuarios`.`person_emp_length`,
`emprestimos`.`loan_intent`, `emprestimos`.`loan_grade`, `emprestimos`.`loan_amnt`, 
`emprestimos`.`loan_int_rate`, `emprestimos`.`loan_status`, `emprestimos`.`loan_percent_income`,
`historicos_banco`.`cb_person_default_on_file`, `historicos_banco`.`cb_person_cred_hist_length`
FROM ids INNER JOIN 
dados_mutuarios ON ids.person_id = dados_mutuarios.person_id INNER JOIN
emprestimos ON ids.loan_id = emprestimos.loan_id INNER JOIN 
historicos_banco ON ids.cb_id = historicos_banco.cb_id;

CREATE TABLE dados_agrupados AS
SELECT ids.*, `dados_mutuarios`.`person_age`, `dados_mutuarios`.`person_income`, 
`dados_mutuarios`.`person_home_ownership`, `dados_mutuarios`.`person_emp_length`,
`emprestimos`.`loan_intent`, `emprestimos`.`loan_grade`, `emprestimos`.`loan_amnt`, 
`emprestimos`.`loan_int_rate`, `emprestimos`.`loan_status`, `emprestimos`.`loan_percent_income`,
`historicos_banco`.`cb_person_default_on_file`, `historicos_banco`.`cb_person_cred_hist_length`
FROM ids INNER JOIN 
dados_mutuarios ON ids.person_id = dados_mutuarios.person_id INNER JOIN
emprestimos ON ids.loan_id = emprestimos.loan_id INNER JOIN 
historicos_banco ON ids.cb_id = historicos_banco.cb_id;

USE alura_cash;
SELECT * FROM dados_agrupados;

ALTER TABLE dados_agrupados
CHANGE COLUMN `person_id` `id_pessoa` VARCHAR(16) NULL DEFAULT NULL ,
CHANGE COLUMN `loan_id` `id_emprestimo` VARCHAR(16) NULL DEFAULT NULL ,
CHANGE COLUMN `cb_id` `id_historico_solicitacao` VARCHAR(16) NULL DEFAULT NULL ,
CHANGE COLUMN `person_age` `idade` INT NULL DEFAULT NULL ,
CHANGE COLUMN `person_income` `salario` INT NULL DEFAULT NULL ,
CHANGE COLUMN `person_home_ownership` `situacao_casa` VARCHAR(8) CHARACTER SET 'utf8mb3' NULL DEFAULT NULL ,
CHANGE COLUMN `person_emp_length` `tempo_trabalhando` DOUBLE NULL DEFAULT NULL ,
CHANGE COLUMN `loan_intent` `motivo_emprestimo` VARCHAR(32) CHARACTER SET 'utf8mb3' NULL DEFAULT NULL ,
CHANGE COLUMN `loan_grade` `pontuacao_emprestimo` VARCHAR(1) CHARACTER SET 'utf8mb3' NULL DEFAULT NULL ,
CHANGE COLUMN `loan_amnt` `valor_total_emprestimo` INT NULL DEFAULT NULL ,
CHANGE COLUMN `loan_int_rate` `juros_emprestimo` DOUBLE NULL DEFAULT NULL ,
CHANGE COLUMN `loan_status` `risco_inadimplencia` INT NULL DEFAULT NULL ,
CHANGE COLUMN `loan_percent_income` `percentual_ocup_salario` DOUBLE NULL DEFAULT NULL ,
CHANGE COLUMN `cb_person_default_on_file` `ja_foi_inadimplente` VARCHAR(1) CHARACTER SET 'utf8mb3' NULL DEFAULT NULL ,
CHANGE COLUMN `cb_person_cred_hist_length` `tempo_primeira_solicitacao` INT NULL DEFAULT NULL ;

UPDATE dados_agrupados SET situacao_casa = 'Alugada' WHERE situacao_casa = 'Rent';
UPDATE dados_agrupados SET situacao_casa = 'Própria' WHERE situacao_casa = 'Own';

ALTER TABLE `alura_cash`.`dados_agrupados` 
CHANGE COLUMN `situacao_casa` `situacao_casa` VARCHAR(12) CHARACTER SET 'utf8mb3' NULL DEFAULT NULL ;

UPDATE dados_agrupados SET situacao_casa = 'Hipotecada' WHERE situacao_casa = 'Mortgage';
UPDATE dados_agrupados SET situacao_casa = 'Outros' WHERE situacao_casa = 'Other';

UPDATE dados_agrupados SET motivo_emprestimo = 'Pessoal' WHERE motivo_emprestimo = 'Personal';
UPDATE dados_agrupados SET motivo_emprestimo = 'Educativo' WHERE motivo_emprestimo = 'Education';
UPDATE dados_agrupados SET motivo_emprestimo = 'Medico' WHERE motivo_emprestimo = 'Medical';
UPDATE dados_agrupados SET motivo_emprestimo = 'Emprendimento' WHERE motivo_emprestimo = 'Venture';
UPDATE dados_agrupados SET motivo_emprestimo = 'Reforma casa' WHERE motivo_emprestimo = 'Homeimprovement';
UPDATE dados_agrupados SET motivo_emprestimo = 'Pagamento dividas' WHERE motivo_emprestimo = 'Debtconsolidation';

UPDATE dados_agrupados SET ja_foi_inadimplente = 'S' WHERE ja_foi_inadimplente = 'Y';

UPDATE dados_agrupados SET situacao_casa = 'Propria' WHERE situacao_casa = 'Própria';
UPDATE dados_agrupados SET motivo_emprestimo = 'Reforma_casa' WHERE motivo_emprestimo = 'Reforma casa';
UPDATE dados_agrupados SET motivo_emprestimo = 'Pagamento_dividas' WHERE motivo_emprestimo = 'Pagamento dividas';

SELECT * FROM dados_agrupados;