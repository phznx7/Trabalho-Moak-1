CREATE DATABASE ProjetoCuidaBem;
use ProjetoCuidaBem;

CREATE TABLE Administradores (
    idAdministracao INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    cargo ENUM('diretor', 'pedagogo') NOT NULL,
    email VARCHAR(225) NOT NULL,
    telefone VARCHAR(20)
);


CREATE TABLE Escolas (
    idEscola INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(225) NOT NULL,
    Tipo VARCHAR(7) NOT NULL,
    Endereco VARCHAR(255) NOT NULL,
    Telefone VARCHAR(20),
    Email VARCHAR(225),
    idAdministracao INT NOT NULL,
    FOREIGN KEY (idAdministracao) REFERENCES Administradores(idAdministracao)
);

CREATE TABLE Turmas (
    idTurma INT AUTO_INCREMENT PRIMARY KEY,
    nomeDaTurma VARCHAR(45) NOT NULL,
    anoLetivo INT NOT NULL,
    idEscola INT NOT NULL,
    FOREIGN KEY (idEscola) REFERENCES Escolas (idEscola)
);

CREATE TABLE Professores (
	idProfessor INT AUTO_INCREMENT PRIMARY KEY, 
    nome VARCHAR(150) NOT NULL,
    disciplina VARCHAR(150) NOT NULL,
    email VARCHAR(225) NOT NULL,
    idEscola INT NOT NULL,
    FOREIGN KEY (idEscola) REFERENCES Escolas (idEscola)    
);

CREATE TABLE Responsaveis (
	idResponsavel INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    relacionamento VARCHAR(50) NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    email VARCHAR(225) NOT NULL
);

CREATE TABLE Alunos (
	idAluno INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    dataDeNascimento DATE NOT NULL,
    idTurma INT NOT NULL,
    idResponsavel INT NOT NULL,
    FOREIGN KEY (idTurma) REFERENCES Turmas (idTurma),
    FOREIGN KEY (idResponsavel) REFERENCES Responsaveis (idResponsavel)
);

CREATE TABLE Avaliacoes (
	idAvaliacao INT AUTO_INCREMENT PRIMARY KEY,
    tipo ENUM ("Nota", "Comportamento", "Frequencia") NOT NULL,
    notaObtida FLOAT NOT NULL,
    idAluno INT NOT NULL,
    idProfessor INT NOT NULL,
    idEscola INT NOT NULL,
    FOREIGN KEY (idAluno) REFERENCES Alunos (idAluno),
    FOREIGN KEY (idProfessor) REFERENCES Professores (idProfessor),
    FOREIGN KEY (idEscola) REFERENCES Escolas (idEscola)
);

CREATE TABLE Pagamentos (
	idPagamento INT AUTO_INCREMENT PRIMARY KEY,
    tipo ENUM("Licenca", "Mensalidade") NOT NULL,
    valor FLOAT NOT NULL,
    dataDePagamento DATE NOT NULL,
    idEscola INT NOT NULL,
    sts ENUM ("A","I") NOT NULL,
    FOREIGN KEY (idEscola) REFERENCES Escolas (idEscola)
);

CREATE TABLE Comunicacoes (
	idComunicacao INT AUTO_INCREMENT PRIMARY KEY,
    mensagem VARCHAR (500),
    dataHora DATETIME,
    idEscola INT NOT NULL,
    idResponsavel INT NOT NULL,
    FOREIGN KEY (idEscola) REFERENCES Escolas (idEscola),
    FOREIGN KEY (idResponsavel) REFERENCES Responsaveis (idResponsavel)
);

ALTER TABLE Escolas MODIFY COLUMN Tipo VARCHAR(50); 

SELECT idEscola FROM Escolas WHERE idEscola IN (1, 2, 3);

SELECT idEscola FROM Escolas;

SHOW CREATE TABLE Turmas;

SHOW VARIABLES LIKE 'autocommit';

SHOW TABLES;

SET autocommit = 1;

SELECT * FROM Escolas;

INSERT INTO Administradores (nome, cargo, email, telefone) 
VALUES 
    ('Carlos Pereira', 'diretor', 'carlos.pereira@gov.com', '9999-8888'),
    ('Ana Souza', 'pedagogo', 'ana.souza@acesso.com', '8888-7777'),
    ('Maria Oliveira', 'diretor', 'maria.oliveira@senai.com', '5555-4444');


INSERT INTO Escolas (idEscola, Nome, Tipo, Endereco, Telefone, Email, idAdministracao)
VALUES
    (1, 'Escola CECJ', 'Publica', 'Rua A, 123', '1111-1111', 'contato@escolacecj.com', 1),
    (2, 'Escola Acesso', 'Particular', 'Avenida B, 456', '2222-2222', 'contato@escolacesso.com', 2),
    (3, 'Escola Helios', 'Particular', 'Rua C, 789', '3333-3333', 'contato@escolahelios.com', 1);
    

INSERT INTO Turmas (idTurma, nomeDaTurma, anoLetivo, idEscola) 
VALUES 
    (1, '1º Ano A', 2024, 1),
    (2, '2º Ano B', 2024, 2),
    (3, '3º Ano C', 2024, 3);


INSERT INTO Professores (nome, disciplina, email, idEscola) 
VALUES 
    ('Carlos Silva', 'Matemática', 'carlos@escolacecj.com', 1),
    ('Ana Lima', 'Português', 'ana@escolaacesso.com', 2),
    ('Roberto Souza', 'História', 'roberto@escolahelios.com', 3),
    ('Luciana Torres', 'Ciências', 'luciana@escolacecj.com', 1);


INSERT INTO Responsaveis (nome, relacionamento, telefone, email) 
VALUES 
    ('João Santos', 'Pai', '3333-3333', 'joao@gmail.com'),
    ('Maria Oliveira', 'Mãe', '4444-4444', 'maria@hotmail.com'),
    ('Carlos Ferreira', 'Avô', '5555-5555', 'carlos@outlook.com');


INSERT INTO Alunos (idAluno, nome, dataDeNascimento, idTurma, idResponsavel) 
VALUES 
    (1, 'Pedro Santos', '2010-03-25', 1, 1),
    (2, 'Luana Oliveira', '2009-07-15', 2, 2),
    (3, 'Fernando Ferreira', '2011-11-01', 3, 3);



INSERT INTO Avaliacoes (tipo, notaObtida, idAluno, idProfessor, idEscola) 
VALUES 
    ('Nota', 8.5, 1, 1, 1),
    ('Comportamento', 9.0, 2, 2, 2),
    ('Frequencia', 7.5, 3, 3, 3);


INSERT INTO Pagamentos (tipo, valor, dataDePagamento, idEscola, sts) 
VALUES 
    ('Mensalidade', 500.00, '2024-10-05', 1, 'A'),
    ('Licenca', 200.00, '2024-10-15', 2, 'A'),
    ('Mensalidade', 550.00, '2024-11-01', 3, 'A'),
    ('Mensalidade', 480.00, '2024-10-20', 1, 'A'),
    ('Licenca', 220.00, '2024-10-10', 2, 'I');


INSERT INTO Comunicacoes (mensagem, dataHora, idEscola, idResponsavel) 
VALUES 
    ('Reunião de pais agendada para 25/10', '2024-10-15 09:00:00', 1, 1),
    ('Aviso sobre evento escolar no próximo mês', '2024-10-10 14:30:00', 2, 2),
    ('Falta de material escolar identificado', '2024-10-12 08:00:00', 3, 3),
    ('Cancelamento de aula devido ao feriado', '2024-10-15 16:30:00', 1, 2),
    ('Alteração no horário de atendimento da escola', '2024-10-14 10:00:00', 2, 3);


INSERT INTO Turmas (nomeDaTurma, anoLetivo, idEscola)
VALUES 
    ('4º Ano A', 2024, 1),
    ('5º Ano B', 2024, 2);


INSERT INTO Professores (nome, disciplina, email, idEscola) 
VALUES 
    ('Fernanda Alves', 'Geografia', 'fernanda@escolainovadora.com', 2),
    ('Ricardo Rocha', 'Educação Física', 'ricardo@escolacecj.com', 1);
    

INSERT INTO Responsaveis (nome, relacionamento, telefone, email) 
VALUES 
    ('Juliana Rocha', 'Mãe', '6666-6666', 'juliana@gmail.com'),
    ('Eduardo Silva', 'Pai', '7777-7777', 'eduardo@gmail.com');


INSERT INTO Alunos (nome, dataDeNascimento, idTurma, idResponsavel) 
VALUES 
    ('Isabela Rocha', '2010-05-30', 1, 4),
    ('Lucas Silva', '2011-09-10', 2, 5);

INSERT INTO Pagamentos (tipo, valor, dataDePagamento, idEscola, sts) VALUES
    ('Licenca', 500.00, '2024-01-15', 1, 'A'),
    ('Mensalidade', 350.00, '2024-02-01', 2, 'A'),
    ('Licenca', 500.00, '2024-01-20', 3, 'A');
    
   

UPDATE Alunos SET nome = 'Pedro S. Santos' WHERE idAluno = 1;

UPDATE Escolas SET Telefone = '5555-5555' WHERE idEscola = 2;

UPDATE Professores SET disciplina = 'Física' WHERE idProfessor = 1;

UPDATE Turmas SET nomeDaTurma = '3º Ano A' WHERE idTurma = 3;

UPDATE Responsaveis SET telefone = '6666-6666' WHERE idResponsavel = 3;

UPDATE Avaliacoes SET notaObtida = 8.0 WHERE idAvaliacao = 1;

DELETE FROM Avaliacoes WHERE idAvaliacao = 2;

DELETE FROM Comunicacoes WHERE idComunicacao = 1;

DELETE FROM Pagamentos WHERE idPagamento = 5;


DELIMITER //
CREATE PROCEDURE InsereAluno(
    IN p_nome VARCHAR(255),
    IN p_dataNascimento DATE,
    IN p_email VARCHAR(255),
    IN p_telefone VARCHAR(15),
    IN p_escola_id INT,
    IN p_turma_id INT
)
BEGIN
    IF EXISTS (SELECT 1 FROM Alunos WHERE email = p_email) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Aluno já existe com esse email!';
    ELSE
        INSERT INTO Alunos (nome, dataNascimento, email, telefone, escola_id, turma_id)
        VALUES (p_nome, p_dataNascimento, p_email, p_telefone, p_escola_id, p_turma_id);
    END IF;
END //

CREATE PROCEDURE AtualizaNota (
    IN idAvaliacao INT,
    IN novaNota FLOAT
)
BEGIN
    UPDATE Avaliacoes SET notaObtida = novaNota WHERE idAvaliacao = idAvaliacao;
END //

CREATE PROCEDURE DeletaProfessor (
    IN idProfessor INT
)
BEGIN
    DELETE FROM Professores WHERE idProfessor = idProfessor;
END //

CREATE PROCEDURE InsereEscola (
    IN nomeEscola VARCHAR(225),
    IN tipo VARCHAR(7),
    IN endereco VARCHAR(255),
    IN telefone VARCHAR(20),
    IN email VARCHAR(225),
    IN idAdmin INT
)
BEGIN
    INSERT INTO Escolas (Nome, Tipo, Endereco, Telefone, Email, idAdministracao)
    VALUES (nomeEscola, tipo, endereco, telefone, email, idAdmin);
END //

DELIMITER ;

DELIMITER //

CREATE FUNCTION CalculaMediaAluno (idAluno INT) 
RETURNS FLOAT
DETERMINISTIC
BEGIN
    DECLARE media FLOAT;
    SELECT AVG(notaObtida) INTO media FROM Avaliacoes WHERE idAluno = idAluno;
    RETURN media;
END //

CREATE FUNCTION ContaAlunosTurma (idTurma INT) 
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total FROM Alunos WHERE idTurma = idTurma;
    RETURN total;
END;

CREATE FUNCTION TotalPagamentosEscola (idEscola INT) 
RETURNS FLOAT
BEGIN
    DECLARE total FLOAT;
    SELECT SUM(valor) INTO total FROM Pagamentos WHERE idEscola = idEscola;
    RETURN total;
END;


DELIMITER ;

DELIMITER //

CREATE TRIGGER AtualizaTelefoneResponsavel AFTER UPDATE ON Responsaveis
FOR EACH ROW
BEGIN
    INSERT INTO Comunicacoes (mensagem, dataHora, idEscola, idResponsavel)
    VALUES (CONCAT('Telefone atualizado para: ', NEW.telefone), NOW(), 1, NEW.idResponsavel);
END //

DELIMITER //
CREATE TRIGGER VerificaNotaAntesInsercao
BEFORE INSERT ON Avaliacoes
FOR EACH ROW
BEGIN
   
    IF NEW.notaObtida < 0 OR NEW.notaObtida > 10 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nota deve estar entre 0 e 10!';
    END IF;
END //

CREATE TRIGGER InsereComunicacaoDepoisDeInserirAluno AFTER INSERT ON Alunos
FOR EACH ROW
BEGIN
    INSERT INTO Comunicacoes (mensagem, dataHora, idEscola, idResponsavel)
    VALUES ('Novo aluno cadastrado: ' || NEW.nome, NOW(), (SELECT idEscola FROM Turmas WHERE idTurma = NEW.idTurma), NEW.idResponsavel);
END //

CREATE TRIGGER DeletaAvaliacoesComAluno AFTER DELETE ON Alunos
FOR EACH ROW
BEGIN
    DELETE FROM Avaliacoes WHERE idAluno = OLD.idAluno;
END //

CREATE TRIGGER AtualizaEmailEscola AFTER UPDATE ON Escolas
FOR EACH ROW
BEGIN
    INSERT INTO Comunicacoes (mensagem, dataHora, idEscola, idResponsavel)
    VALUES ('Email da escola atualizado', NOW(), NEW.idEscola, NULL);
END //

CREATE TRIGGER LogInsercaoPagamento AFTER INSERT ON Pagamentos
FOR EACH ROW
BEGIN
    INSERT INTO Comunicacoes (mensagem, dataHora, idEscola, idResponsavel)
    VALUES (CONCAT('Pagamento registrado: ', NEW.valor), NOW(), NEW.idEscola, NULL);
END //

DELIMITER ;


CREATE VIEW vw_alunos_responsaveis_turmas AS
SELECT 
    a.idAluno, 
    a.nome AS aluno_nome, 
    a.dataDeNascimento, 
    r.nome AS responsavel_nome, 
    r.relacionamento, 
    t.nomeDaTurma,
    t.anoLetivo
FROM 
    Alunos a
JOIN 
    Responsaveis r ON a.idResponsavel = r.idResponsavel
JOIN 
    Turmas t ON a.idTurma = t.idTurma;
    
    SELECT * FROM vw_alunos_responsaveis_turmas;

CREATE VIEW vw_pagamentos_por_escola AS
SELECT 
    p.idPagamento, 
    p.tipo, 
    p.valor, 
    p.dataDePagamento, 
    e.Nome AS escola_nome,
    p.sts AS status_pagamento
FROM 
    Pagamentos p
JOIN 
    Escolas e ON p.idEscola = e.idEscola;
    
SELECT * FROM vw_pagamentos_por_escola;    

CREATE VIEW vw_avaliacoes_alunos AS
SELECT 
    a.idAluno, 
    a.nome AS aluno_nome,
    av.tipo AS tipo_avaliacao, 
    av.notaObtida, 
    av.idProfessor,
    p.nome AS professor_nome,
    e.Nome AS escola_nome  
FROM 
    Avaliacoes av
JOIN 
    Alunos a ON av.idAluno = a.idAluno
JOIN 
    Professores p ON av.idProfessor = p.idProfessor
JOIN
    Turmas t ON a.idTurma = t.idTurma 
JOIN
    Escolas e ON t.idEscola = e.idEscola;  


SELECT * FROM vw_avaliacoes_alunos;  
    
CREATE VIEW vw_professores_disciplinas AS
SELECT 
    p.idProfessor, 
    p.nome AS professor_nome, 
    p.disciplina,
    e.Nome AS escola_nome
FROM 
    Professores p
JOIN 
    Escolas e ON p.idEscola = e.idEscola;
    
SELECT * FROM vw_professores_disciplinas;     

CREATE VIEW vw_comunicacoes_responsaveis AS
SELECT 
    c.idComunicacao, 
    c.mensagem, 
    c.dataHora, 
    r.nome AS responsavel_nome, 
    r.telefone, 
    e.Nome AS escola_nome
FROM 
    Comunicacoes c
JOIN 
    Responsaveis r ON c.idResponsavel = r.idResponsavel
JOIN 
    Escolas e ON c.idEscola = e.idEscola;
    
SELECT * FROM vw_comunicacoes_responsaveis;      

CREATE VIEW vw_turmas_alunos AS
SELECT 
    t.nomeDaTurma, 
    t.anoLetivo, 
    a.nome AS aluno_nome,
    e.Nome AS escola_nome  
FROM 
    Turmas t
JOIN 
    Alunos a ON t.idTurma = a.idTurma
JOIN
    Escolas e ON t.idEscola = e.idEscola;  


SELECT * FROM vw_turmas_alunos;    


DROP VIEW vw_quantidade_alunos_por_turma;

CREATE VIEW vw_quantidade_alunos_por_turma AS
SELECT 
    t.nomeDaTurma, 
    t.anoLetivo, 
    e.Nome AS escola_nome,  
    COUNT(a.idAluno) AS quantidade_alunos
FROM 
    Turmas t
LEFT JOIN 
    Alunos a ON t.idTurma = a.idTurma
JOIN 
    Escolas e ON t.idEscola = e.idEscola  
GROUP BY 
    t.idTurma, e.Nome;  

    
SELECT * FROM vw_quantidade_alunos_por_turma;      

CREATE VIEW vw_responsaveis_alunos AS
SELECT 
    r.nome AS responsavel_nome, 
    r.relacionamento, 
    a.nome AS aluno_nome,
    e.Nome AS escola_nome,  
    e.Nome AS escola_responsavel_nome  
FROM 
    Responsaveis r
JOIN 
    Alunos a ON r.idResponsavel = a.idResponsavel
JOIN
    Turmas t ON a.idTurma = t.idTurma  
JOIN
    Escolas e ON t.idEscola = e.idEscola; 

 SELECT * FROM vw_responsaveis_alunos;    


CREATE VIEW vw_escolas_administradores AS
SELECT 
    e.Nome AS escola_nome, 
    e.Tipo, 
    a.nome AS administrador_nome
FROM 
    Escolas e
JOIN 
    Administradores a ON e.idAdministracao = a.idAdministracao;
 
 SELECT * FROM vw_escolas_administradores; 


CREATE VIEW vw_frequencia_alunos_turma AS
SELECT 
    t.nomeDaTurma, 
    t.anoLetivo, 
    a.nome AS aluno_nome,
    av.notaObtida AS frequencia
FROM 
    Turmas t
JOIN 
    Alunos a ON t.idTurma = a.idTurma
JOIN 
    Avaliacoes av ON a.idAluno = av.idAluno
WHERE 
    av.tipo = 'Frequencia';

SELECT * FROM vw_frequencia_alunos_turma;     


CREATE VIEW vw_pagamentos_pendentes AS
SELECT 
    p.idPagamento, 
    p.tipo, 
    p.valor, 
    p.dataDePagamento, 
    e.Nome AS escola_nome
FROM 
    Pagamentos p
JOIN 
    Escolas e ON p.idEscola = e.idEscola
WHERE 
    p.sts = 'I';
    
SELECT * FROM vw_pagamentos_pendentes;    

CREATE VIEW vw_turmas_com_maior_numero_de_alunos AS
SELECT 
    t.idTurma, 
    t.nomeDaTurma, 
    t.anoLetivo,
    e.Nome AS EscolaNome,
    COUNT(a.idAluno) AS TotalAlunos
FROM 
    Turmas t
JOIN 
    Escolas e ON t.idEscola = e.idEscola
LEFT JOIN 
    Alunos a ON t.idTurma = a.idTurma
GROUP BY 
    t.idTurma, t.nomeDaTurma, t.anoLetivo, e.Nome
HAVING 
    COUNT(a.idAluno) > 1;  

    
SELECT * FROM vw_turmas_com_maior_numero_de_alunos;

CREATE VIEW vw_professores_media_notas AS
SELECT 
    p.idProfessor, 
    p.nome AS professor_nome, 
    e.Nome AS escola_nome, 
    COUNT(DISTINCT a.idAluno) AS alunos_avaliados,  
    AVG(av.notaObtida) AS media_notas 
FROM 
    Professores p
JOIN 
    Escolas e ON p.idEscola = e.idEscola
JOIN 
    Avaliacoes av ON p.idProfessor = av.idProfessor
JOIN 
    Alunos a ON av.idAluno = a.idAluno
GROUP BY 
    p.idProfessor, p.nome, e.Nome 
ORDER BY 
    media_notas DESC;  

SELECT * FROM vw_professores_media_notas;


