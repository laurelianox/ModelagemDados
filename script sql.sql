create table Livros (
id_livro int not null,
nome_livro varchar(100) not null,
autoria varchar(100) not null,
editora varchar(100) not null,
categoria varchar(100) not null,
preco decimal(5,2) not null,

primary key (id_livro)
);

create table Estoque(
id_livro int not null,
qtd_estoque int not null,

primary key(id_livro)
);

create table Vendas (
id_pedido int not null,
id_vendedor int not null,
id_livro int not null,
qtd_vendida int not null,
data_venda date not null,
primary key (id_vendedor, id_pedido)
);

create table Vendedores (
id_vendedor int not null,
nome_vendedor varchar(255),
primary key (id_vendedor)
);

alter table Estoque add constraint ce_estoque_livros
foreign key (id_livro)
references livros (id_livro)
on delete no action
on update no action;

alter table Vendas add constraint ce_vendas_livros
foreign key (id_livro)
references livros (id_livro)
on delete no action
on update no action;

alter table Vendas add constraint ce_vendas_vendedores
foreign key (id_vendedor)
references vendedores (id_vendedor)
on delete no action
on update no action;

set FOREIGN_KEY_CHECKS = 0;

INSERT INTO livros values (
1,
"Percy Jackson e o Ladrão de Raios",
"Rick Riordan",
"Intriseca",
"Aventura",
34.65);

INSERT INTO LIVROS VALUES
(2,    'A Volta ao Mundo em 80 Dias',    'Júlio Verne',         'Principis',     'Aventura',    21.99),
(3,    'O Cortiço',                     'Aluísio de Azevedo',  'Panda Books',   'Romance',    47.8),
(4,    'Dom Casmurro',                     'Machado de Assis',    'Via Leitura',   'Romance',    19.90),
(5,    'Memórias Póstumas de Brás Cubas',    'Machado de Assis',    'Antofágica',    'Romance',    45),
(6,    'Quincas Borba',                 'Machado de Assis',    'L&PM Editores', 'Romance',    48.5),
(7,    'Ícaro',                             'Gabriel Pedrosa',     'Ateliê',          'Poesia',    36),
(8,    'Os Lusíadas',                     'Luís Vaz de Camões',  'Montecristo',   'Poesia',    18.79),
(9,    'Outros Jeitos de Usar a Boca',    'Rupi Kaur',          'Planeta',          'Poesia',    34.8);

INSERT INTO VENDEDORES 
VALUES
(1,'Paula Rabelo'),
(2,'Juliana Macedo'),
(3,'Roberto Barros'),
(4,'Barbara Jales');

INSERT INTO VENDAS 
VALUES 
(1, 3, 7, 1, '2020-11-02'),
(2, 4, 8, 2, '2020-11-02'),
(3, 4, 4, 3, '2020-11-02'),
(4, 1, 7, 1, '2020-11-03'),
(5, 1, 6, 3, '2020-11-03'),
(6, 1, 9, 2, '2020-11-04'),
(7, 4, 1, 3, '2020-11-04'),
(8, 1, 5, 2, '2020-11-05'),
(9, 1, 2, 1, '2020-11-05'),
(10, 3, 8, 2, '2020-11-11'),
(11, 1, 1, 4, '2020-11-11'),
(12, 2, 10, 10, '2020-11-11'),
(13, 1, 12, 5, '2020-11-18'),
(14, 2, 4, 1, '2020-11-25'),
(15, 3, 13, 2,'2021-01-05'),
(16, 4, 13, 1, '2021-01-05'),
(17, 4, 4, 3, '2021-01-06'),
(18, 2, 12, 2, '2021-01-06');

INSERT INTO ESTOQUE 
VALUES
(1,  7),
(2,  10),
(3,  2),
(8,  4),
(10, 5),
(11, 3),
(12, 3);

insert into livros
(categoria, autoria, nome_livro, editora, id_livro, preco)
values
("Biografia", "Anne Frank", "Diário de Anne Frank", "Pé da Letra", 12, 34.90);

#Inserindo valores fora de ordem
INSERT INTO LIVROS 
(CATEGORIA, AUTORIA, NOME_LIVRO, EDITORA, ID_LIVRO, PRECO)
VALUES
('Biografia' ,    'Malala Yousafzai', 'Eu sou Malala'       , 'Companhia das Letras', 11, 22.32),
('Biografia' ,    'Michelle Obama'  , 'Minha história'      , 'Objetiva'            ,    13,    57.90);

# Excluindo uma tabela
DROP TABLE VENDEDORES;

SELECT * FROM LIVROS;

SELECT NOME_LIVRO FROM LIVROS;

SELECT ID_LIVRO AS "Código do Livro" from livros;

select * from livros
where categoria = "biografia";

select * from livros
where categoria = "romance" and preco <48;

select * from livros
where categoria = "poesia" and not
(autoria = "Luís Vaz de Camões" or autoria = "Gabriel Pedrosa");

select distinct id_livro from vendas
where id_vendedor = 1
order by id_livro;

select * from livros;

delete from livros where id_livro = 8;

update livros set preco = 0.9*preco;
select * from livros;

select vendas.id_vendedor, vendedores.nome_vendedor, sum(vendas.qtd_vendida) as "Vendas Totais"
from vendas, vendedores
where vendas.id_vendedor = vendedores.id_vendedor
group by vendas.id_vendedor;

select vendas.id_vendedor, vendedores.nome_vendedor, sum(vendas.qtd_vendida) as "Vendas Totais"
from vendas inner join vendedores
on vendas.id_vendedor = vendedores.id_vendedor
group by vendas.id_vendedor
order by "Vendas Totais";

select livros.nome_livro, vendas.qtd_vendida
from livros left join vendas
on livros.id_livro = vendas.id_livro
group by livros.nome_livro
order by vendas.qtd_vendida;
