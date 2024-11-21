CREATE DATABASE ProjetoCuidaBem;
use ProjetoCuidaBem;

CREATE TABLE Administradores (
	idAdministracao INT AUTO_INCREMENT PRIMARY KEY,
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

