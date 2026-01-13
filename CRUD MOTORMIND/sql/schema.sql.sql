CREATE DATABASE motormind;
USE motormind;
-- Tabela de fabricantes
CREATE TABLE fabricantes (
    id_fabricante INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);
-- Tabela de tipos de motores
CREATE TABLE tipos_motor (
    id_tipo INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(100) NOT NULL
);
-- Tabela de locais onde os motores ficam armazenados/instalados
CREATE TABLE locais (
    id_local INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);
-- Tabela principal: motores
CREATE TABLE motores(
    id_motor INT AUTO_INCREMENT PRIMARY KEY,
    modelo VARCHAR(100),
    potencia VARCHAR(30),
    tensao VARCHAR(30),
    corrente VARCHAR(50),
    rpm VARCHAR(40),
    modo_fixacao VARCHAR(100),
    id_fabricante INT,
    id_tipo INT,
    id_local INT,    
    FOREIGN KEY (id_fabricante) REFERENCES fabricantes(id_fabricante),
    FOREIGN KEY (id_tipo) REFERENCES tipos_motor(id_tipo),
    FOREIGN KEY (id_local) REFERENCES locais(id_local)
);

-- Tabela de usuários (quem realiza manutenção/inspeção)
CREATE TABLE usuarios (
    id_usuario INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);
-- Tabela de inspeções
CREATE TABLE inspecoes (
    id_inspecao INT AUTO_INCREMENT PRIMARY KEY,
    id_motor INT NOT NULL,
    id_usuario INT,
    data_inspecao DATE,
    observacoes TEXT,
    
    FOREIGN KEY (id_motor) REFERENCES motores(id_motor),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);
-- Tabela de manutenções
CREATE TABLE manutencoes (
    id_manutencao INT AUTO_INCREMENT PRIMARY KEY,
    id_motor INT NOT NULL,
    id_usuario INT,
    tipo VARCHAR(50),     -- preventiva / corretiva
    data_manutencao DATE,
    descricao TEXT,
    
    FOREIGN KEY (id_motor) REFERENCES motores(id_motor),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);


INSERT INTO fabricantes (id_fabricante, nome)
VALUES
(1, 'Buscarioli'),
(2, 'Electro ADDA'),
(3, 'LOWARA'),
(4, 'MareiliMotori'),
(5, 'SIEMENS'),
(6, 'Versatronic'),
(7, 'WEG');

INSERT INTO tipos_motor (id_tipo, descricao)
VALUES
(1, 'Motor abastecimento sistema desmi'),
(2, 'Motor abastecimento tanque água desmi'),
(3, 'Motor de desengraxe'),
(4, 'Motor de elevação do disco'),
(5, 'Motor ecoal'),
(6, 'Motor elevação de Rolo'),
(7, 'Motor elevação ponte robô'),
(8, 'Motor Exaustor'),
(9, 'Motor Exaustor - Filtro manga'),
(10, 'Motor insuflador (1)'),
(11, 'Motor insuflador (2)'),
(12, 'Motor lavador de gás'),
(13, 'Motor lavagem agua potável'),
(14, 'Motor lavagem água desmi'),
(15, 'Motor Rolos de polir'),
(16, 'Motor tanque coloração'),
(17, 'Motor translação Mesa Lateral'),
(18, 'Motor translação Mesa principal politriz'),
(19, 'Motor translação ponte robô'),
(20, 'Motor Translação Pinça politriz'),
(21, 'Motor U.H Jateadora'),
(22, 'Motor do carregador/descarregador'),
(23, 'Motor do Tracionador Linha de Pintura'),
(24, 'Motor queimador'),
(25, 'Motor reserva bomba ácido/soda'),
(26, 'Motoredutor de translação'),
(27, 'Motoredutor elevador de canecos'),
(28, 'Motoredutor rolete de entrada'),
(29, 'Motoredutor rolete de saída'),
(30, 'Motoredutor turbina Jateadora'),
(31, 'Rosca sem fim'),
(32, 'TQ 14'),
(33, 'TQ 16'),
(34, 'TQ 20'),
(35, 'TQ 22'),
(36, 'TQ 27'),
(37, 'TQ 29');

INSERT INTO locais (id_local, nome)
VALUES
(1, 'Cabine de Jateamento'),
(2, 'Cabine de pintura'),
(3, 'Encima da cabine de Polimento'),
(4, 'Forno de tratamento'),
(5, 'Mesa de Entrada'),
(6, 'Mesa de Entrada/Saída'),
(7, 'Osmose pintura'),
(8, 'Tanque anodização'),
(9, 'Tracionador'),
(10, 'Túnel de Lavagem'),
(11, 'Túnel de lavagem'),
(12, 'Unidade Hidráulica'),
(13, 'Utilidades');

INSERT INTO motores (modelo, potencia, tensao, corrente, rpm, id_fabricante, id_tipo, id_local)
VALUES
('112M', '7.5CV', '220/380/440V', '20.2/11.7/10.1A', '1740rpm', 7, 25, 13),
('280S/M', '125CV', '440V', '146A', '1785rpm', 7, 12, 13),
('112M', '6CV', '220/380/440V', '15.3/8.88/7.67A', '3500rpm', 7, 30, 1),
('1LG0 108-4AA91-Z', '1.15CV', '220 / 440V', '3.70 / 2.10 / 1.86A', '1710rpm', 5, 28, 5),
('112M', '6CV', '440V', '8.28A', '1740rpm', 7, 21, 12),
('MAA 80 MC4', '1.5CV', '440V', '4.86A', '1670rpm', 4, 17, 6),
('MAA 71 MC4', '0.81CV', '440V', '2.92A', '1650rpm', 4, 20, 6),
('225S-4', '41CV', '440V', '66A', '1480rpm', 2, 15, 3),
('MAA 90 L4', '2.71CV', '440V', '5.16A', '1680rpm', 4, 6, 3),
('1LA9083-4KA10-Z', '1.5CV', '460V', '1.74A', '1700rpm', 5, 23, 9),
('ST 80 S2U', '1.53CV', '208 - 230 / 380 - 450V', NULL, '3400rpm', NULL, 24, 4),
('180M', '15CV', '220 / 380 V', '22 A / 12,7 A', '1740rpm', 7, 32, 8),
('180M', '25CV', '220 / 380 / 440 / 660V', '40.6 / 23.4 / 20.2 / 11.7 A', '1760rpm', 7, 35, 8),
('132M/L', '15CV', '440V', '18,6 A', '1760rpm', 7, 36, 8),
('132M/L', '15CV', '440V', '16,6 A', '1760rpm', 7, 37, 8),
('132', '7.5CV', '440V', '12.7A', '3560rpm', 6, 3, 10),
('132', '7.5CV', '440V', '12.7A', '3560rpm', 6, 5, 11),
('132', '7.5CV', '440V', '12.7A', '3560rpm', 6, 13, 10),
('132', '7.5CV', '440V', '12.7A', '3560rpm', 6, 14, 11),
('160M', '15cv', '220 / 380 / 440V', '39.6 / 22.9 / 19.8A', '1175rpm', 7, 10, 2),
('160M', '20cv', '440V', '26.7A', '1765rpm', 7, 11, 2),
('PLM100RB14/330', NULL, '440 / 480V', '3.60A', NULL, 3, 2, 7),
('132 S', '3CV', '220/380V', '9.3 / 5.3A', '3480RPM', 1, 24, 2),
('Rosca sem fim', '0.89CV', '277 / 480V', '2.63 / 1.52 A', '1700rpm', 1, 31, 1);

INSERT INTO usuarios(nome) VALUES
('Matheus R.'),
("Jonathan"),
("Bruno"),
("Matheus A."),
("Gustavo"),
("Gabriel");

SELECT * from motores;


#Primeira View

CREATE VIEW quantidade_motores_por_tipo AS

SELECT tipos_motor.descricao AS descricao_do_tipo_de_motor, COUNT(motores.id_motor) AS quantidade_de_motores
FROM motores

JOIN tipos_motor ON motores.id_tipo = tipos_motor.id_tipo #
GROUP BY tipos_motor.descricao;

Select * from quantidade_motores_por_tipo;


# VIEW 2, RENOMEIA COLUNA E FACILITA LEITURA

CREATE VIEW lista_de_fabricantes AS

SELECT id_fabricante AS identificador_do_fabricante, nome AS nome_do_fabricante

FROM fabricantes;

SELECT * from lista_de_fabricantes


#MUDAR OS DADOS DO MOTOR -- STORED PROCEDURES 1
DELIMITER $$

CREATE PROCEDURE atualizar_motor (
    IN parametro_id_motor INT, #Parametro é apenas um nome, para evidenciar que o valor de input vem de fora da procedure
    IN parametro_corrente INT,
    IN parametro_tensao INT,
    IN parametro_modelo VARCHAR(100),
    IN parametro_modo_fixacao VARCHAR(100),
    IN parametro_potencia VARCHAR(30)
)
BEGIN
    UPDATE motores #Inserimos os valores de entrada, atualizando os antigos valores do banco de dados
    SET 
        corrente = parametro_corrente,
        tensao = parametro_tensao,
        modelo = parametro_modelo,
        modo_fixacao = parametro_modo_fixacao,
        potencia = parametro_potencia
    WHERE id_motor = parametro_id_motor; #Atualiza apenas o motor QUE o id seja igual ao que foi selecionado para mudar.
END $$

DELIMITER ;

#ALTERAÇÃO DOS DADOS 
CALL atualizar_motor( 
    5,      # id do motor
    10,     # corrente
    220,    # tensao
    'Modelo B-20', #modelo  
    'Fixação por Flange', # modo_fixação
    "5.3CV"     # potencia
);

select * from motores;



#Registrar uma inspeção --- STORED PROCEDURES 2

DELIMITER $$

CREATE PROCEDURE registrar_inspecao (
    IN id_motor_inserir INT,
    IN id_usuario_inserir INT,
    IN data_da_inspecao DATE,
    IN texto_observacao TEXT
)
BEGIN
    INSERT INTO inspecoes (
        id_motor, 
        id_usuario, 
        data_inspecao, 
        observacoes
    ) 
    VALUES (
        id_motor_inserir,
        id_usuario_inserir,
        data_da_inspecao,
        texto_observacao
    );
END $$

DELIMITER ;

#INSERIR RELATORIO DE INSPEÇÃO

CALL registrar_inspecao (5, 1, '2025-02-10', 'Vibração leve no eixo.');

SELECT * FROM inspecoes;

DELETE FROM inspecoes WHERE id_inspecao = 3;


# TRIGGER 1 -- potência e modelo inválidos

DELIMITER $

CREATE TRIGGER trg_motores
BEFORE INSERT ON motores
FOR EACH ROW
BEGIN
    IF NEW.potencia = '' then
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'A potência do motor não pode ser vazia.';
    END IF;

     IF NEW.modelo = '' then
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'O modelo do motor deve ser registrado.';
    END IF;
END$
DELIMITER ; 


# TRIGGER 2 -- Log delete
CREATE TABLE log_motores (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_motor INT,
    modelo VARCHAR(100),
    quando DATETIME,
    usuario varchar(40)
);

DELIMITER $$
CREATE TRIGGER trg_log_motores
AFTER DELETE ON motores
FOR EACH ROW
BEGIN
    INSERT INTO log_motores VALUES (null, OLD.id_motor, OLD.modelo, sysdate(), user());
END $$

DELIMITER ;
	







