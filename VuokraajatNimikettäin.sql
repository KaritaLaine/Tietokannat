-- Select rows from a Table or View 'TableOrViewName' in schema 'SchemaName'
SELECT nimike, SUM(DATEDIFF(day, alkamispaiva, paattymispaiva) * dbo.tuote.paivavuokra)
AS laskutus FROM dbo.tuote INNER JOIN dbo.vuokraus ON dbo.tuote.yksilointikoodi = 
dbo.vuokraus.yksilointikoodi
GROUP BY nimike
GO