/*
 * DIO - Trilha .NET - Banco de Dados
 * 
 * Repositório do Desafio: https://github.com/enionsouza/trilha-net-banco-de-dados-desafio
 * 
 * Objetivo
 * Você deverá criar diversas consultas, com o objetivo de retornar os dados a seguir.
 * Abaixo de cada pedido tem o retorno esperado. O seu retorno deve ser igual ao da imagem (conforme README.md).
 * 
 * Itens do Desafio:
 * 1 - Buscar o nome e ano dos filmes
 * 2 - Buscar o nome e ano dos filmes, ordenados por ordem crescente pelo ano
 * 3 - Buscar pelo filme de volta para o futuro, trazendo o nome, ano e a duração
 * 4 - Buscar os filmes lançados em 1997
 * 5 - Buscar os filmes lançados APÓS o ano 2000
 * 6 - Buscar os filmes com a duracao maior que 100 e menor que 150, ordenando pela duracao em ordem crescente
 * 7 - Buscar a quantidade de filmes lançadas no ano, agrupando por ano, ordenando pela duracao em ordem decrescente
 * 8 - Buscar os Atores do gênero masculino, retornando o PrimeiroNome, UltimoNome
 * 9 - Buscar os Atores do gênero feminino, retornando o PrimeiroNome, UltimoNome, e ordenando pelo PrimeiroNome
 * 10 - Buscar o nome do filme e o gênero
 * 11 - Buscar o nome do filme e o gênero do tipo "Mistério"
 * 12 - Buscar o nome do filme e os atores, trazendo o PrimeiroNome, UltimoNome e seu Papel
 * 
 * */

-- 1 - Buscar o nome e ano dos filmes
SELECT
	f.Nome,
	f.Ano
FROM
	dbo.Filmes f;

-- 2 - Buscar o nome e ano dos filmes, ordenados por ordem crescente pelo ano
-- Observação: como no gabarito da solução estava presente também a coluna de "Duração", ela foi incorporada à solução.
SELECT
	f.Nome,
	f.Ano,
	f.Duracao
FROM
	dbo.Filmes f
ORDER BY
	f.Ano;
	
-- 3 - Buscar pelo filme de volta para o futuro, trazendo o nome, ano e a duração
SELECT
	f.Nome,
	f.Ano,
	f.Duracao
FROM
	dbo.Filmes f
WHERE
	UPPER(f.Nome) = 'DE VOLTA PARA O FUTURO';
	
-- 4 - Buscar os filmes lançados em 1997
SELECT
	f.Nome,
	f.Ano,
	f.Duracao
FROM
	dbo.Filmes f
WHERE
	f.Ano = 1997;

-- 5 - Buscar os filmes lançados APÓS o ano 2000
SELECT
	f.Nome,
	f.Ano,
	f.Duracao
FROM
	dbo.Filmes f
WHERE
	f.Ano > 2000;

-- 6 - Buscar os filmes com a duracao maior que 100 e menor que 150, ordenando pela duracao em ordem crescente
SELECT
	f.Nome,
	f.Ano,
	f.Duracao
FROM
	dbo.Filmes f
WHERE
	f.Duracao > 100
	AND
	f.Duracao < 150
ORDER BY
	f.Duracao;

-- 7 - Buscar a quantidade de filmes lançadas no ano, agrupando por ano, ordenando pela duracao em ordem decrescente
-- Observação: Considerando que a "duração" referida no enunciado seja o somatório das durações dos filmes lançados em cada ano,
-- foi encontrada uma divergência entre o gabarito apresentado no README.md e o resultado da query deste item do desafio.
SELECT
	f.Ano,
--	SUM(f.Duracao) AS [Somatório das Durações dos Filmes Lançados no Ano],
	COUNT(f.Ano) AS Quantidade
FROM
	dbo.Filmes f
GROUP BY
	f.Ano
ORDER BY
	SUM(f.Duracao) DESC;

-- 8 - Buscar os Atores do gênero masculino, retornando o PrimeiroNome, UltimoNome
SELECT
	*
FROM
	dbo.Atores a
WHERE
	a.Genero = 'M';

-- 9 - Buscar os Atores do gênero feminino, retornando o PrimeiroNome, UltimoNome, e ordenando pelo PrimeiroNome
SELECT
	*
FROM
	dbo.Atores a
WHERE
	a.Genero = 'F'
ORDER BY
	a.PrimeiroNome;

-- 10 - Buscar o nome do filme e o gênero
SELECT
	f.Nome,
	g.Genero
FROM
	dbo.Filmes f
JOIN
	dbo.FilmesGenero fg ON f.Id = fg.IdFilme
JOIN
	dbo.Generos g ON fg.IdGenero = g.Id;

-- 11 - Buscar o nome do filme e o gênero do tipo "Mistério"
SELECT
	f.Nome,
	g.Genero
FROM
	dbo.Filmes f
JOIN
	dbo.FilmesGenero fg ON f.Id = fg.IdFilme
JOIN
	dbo.Generos g ON fg.IdGenero = g.Id
WHERE
	UPPER(g.Genero) = 'MISTÉRIO';

-- 12 - Buscar o nome do filme e os atores, trazendo o PrimeiroNome, UltimoNome e seu Papel
SELECT
	f.Nome,
	a.PrimeiroNome,
	a.UltimoNome,
	ef.Papel
FROM
	dbo.Filmes f
JOIN
	dbo.ElencoFilme ef ON f.Id = ef.IdFilme
JOIN
	dbo.Atores a ON ef.IdAtor = a.Id;
