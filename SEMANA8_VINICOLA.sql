drop database if exists LojaDeVinhos;
create database LojaDeVinhos;
use LojaDeVinhos;
create table LojaDeVinhos.Regiao(
	codRegiao BIGINT not null,
    nomeRegiao VARCHAR(100) not null,
    descricaoRegiao TEXT,
    primary key (codRegiao)
);

create table LojaDeVinhos.Vinicola(
	codVinicola BIGINT not null,
    nomeVinicola VARCHAR(100) not null, 
    descricaoVinicola TEXT,
    foneVinicola VARCHAR(15),
    emailVinicola VARCHAR(15),
    Regiao_codRegiao BIGINT not null,
    primary key (codVinicola),
    foreign key (Regiao_codRegiao) references LojaDeVinhos.Regiao (codRegiao)
);

create table LojaDeVinhos.Vinho(
	codVinho BIGINT not null,
    nomeVinho VARCHAR(50) not null,
    tipoVinho VARCHAR(30) not null,
    anoVinho INT not null,
    descricaoVinho TEXT,
    Vinicola_codVinicola BIGINT not null,
    primary key (codVinho),
    foreign key (Vinicola_codVinicola) references LojaDeVinhos.Vinicola (codVinicola)
);


insert into Regiao (codRegiao, nomeRegiao) values
	(3034, "Serra Gaucha"),
    (8974, "Campanha"),
    (7839, "Vale do Sao Francisco"),
    (1380, "Planalto Catarinense"),
    (2120, "Campos de Cima da Serra");
    
insert into Vinicola (codVinicola, nomeVinicola, Regiao_codRegiao) values
	(07190, "Miolo", 3034),
    (09599, "Casa Valduga", 3034),
    (08249, "Peterlongo", 3034),
    (01352, "Salton", 3034),
    (06962, "Casa Perini", 3034);
    
insert into Vinho (codVinho, nomeVinho, tipoVinho, anoVinho, Vinicola_codVinicola) values
	(14918, "Miolo Reserva Tannat", "Tannat", 2018, 07190),
    (23281, "Miolo Reserva Pinot Noir", "Pinot Noir", 2018, 07190),
    (46731, "Miolo Reserva Merlot", "Merlot", 2018, 07190),
    (77519, "Miolo Reserva Cabernet Sauvignon", "Cabernet Sauvignon", 2018, 07190),
    (39628, "Miolo Reserva Pinot Grigio", "Pinot Grigio", 2020, 07190);
    
select nomeVinho as Vinho, anoVinho as Ano, nomeVinicola as Vinicola, nomeRegiao as Regiao
from LojaDeVinhos.Vinho
inner join LojaDeVinhos.Vinicola on codVinicola = Vinicola_codVinicola
inner join LojaDeVinhos.Regiao on codRegiao = Regiao_codRegiao;

drop user if exists sommelier@'localhost';
create user sommelier@'localhost' with max_queries_per_hour 40;
grant select on LojaDeVinhos.Vinho to sommelier@'localhost';
grant select (codVinicola, nomeVinicola) on LojaDeVinhos.Vinicola to sommelier@'localhost'; 


