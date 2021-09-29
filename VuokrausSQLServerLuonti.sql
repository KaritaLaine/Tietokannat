-- VUOKRAUS-TIETOKANNAN TAULUJEN LUONTISKRIPTI

-- Luodaan uusi tietokanta Vuokraus
-- USE MASTER 
-- GO

-- CREATE DATABASE Vuokraus

-- Varmistetaan, ett‰ skripti ajetaan oikeassa tietokannassa.
USE vuokraus
GO

-- Luodaan tarvittavat taulut
CREATE TABLE tuoteryhma (
                tuoteryhma NVARCHAR(20) NOT NULL,
                CONSTRAINT tuoteryhma_pk PRIMARY KEY (tuoteryhma)
)

CREATE TABLE tuote (
                yksilointikoodi INT IDENTITY NOT NULL,
                tuoteryhma NVARCHAR(20) NOT NULL,
                nimike NVARCHAR(40) NOT NULL,
                merkki NVARCHAR(20) NOT NULL,
                malli NVARCHAR(20) NOT NULL,
                paivavuokra FLOAT NOT NULL,
                CONSTRAINT tuote_pk PRIMARY KEY (yksilointikoodi)
)

CREATE TABLE yhteystyyppi (
                yhteystyyppi NVARCHAR(20) NOT NULL,
                CONSTRAINT yhteystyyppi_pk PRIMARY KEY (yhteystyyppi)
)

CREATE TABLE asiakas (
                asiakasnumero INT IDENTITY NOT NULL,
                yritys NVARCHAR(30) NOT NULL,
                laskutusosoite NVARCHAR(30) NOT NULL,
                postinumero NVARCHAR(10) NOT NULL,
                postitoimipaikka NVARCHAR(30) NOT NULL,
                CONSTRAINT asiakas_pk PRIMARY KEY (asiakasnumero)
)

-- Comment for table [asiakas]: Asiakkaan perustiedot
-- Comment for column [Laskutusosoite]: Yrityksen laskujen katu- tai PL-osoite


CREATE TABLE vuokraus (
                tapahtuma_id INT IDENTITY NOT NULL,
                alkamispaiva DATETIME NOT NULL,
                paattymispaiva DATETIME NOT NULL,
                asiakasnumero INT NOT NULL,
                yksilointikoodi INT NOT NULL,
                CONSTRAINT vuokraus_pk PRIMARY KEY (tapahtuma_id)
)

CREATE TABLE yhteyshenkilo (
                yhteyshenkilo_id INT IDENTITY NOT NULL,
                yhteystyyppi NVARCHAR(20) NOT NULL,
                etunimi NVARCHAR(20) NOT NULL,
                sukunimi NVARCHAR(30) NOT NULL,
                puhelin NVARCHAR(15),
                sahkoposti NVARCHAR(40) NOT NULL,
                asiakasnumero INT NOT NULL,
                CONSTRAINT yhteyshenkilo_pk PRIMARY KEY (yhteyshenkilo_id)
)

-- Luodaan relaatiot m‰‰rittelem‰ll‰ viiteavaimet
ALTER TABLE tuote ADD CONSTRAINT tuoteryhma_tuote_fk
FOREIGN KEY (tuoteryhma)
REFERENCES tuoteryhma (tuoteryhma)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE vuokraus ADD CONSTRAINT tuote_vuokraus_fk
FOREIGN KEY (yksilointikoodi)
REFERENCES tuote (yksilointikoodi)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE yhteyshenkilo ADD CONSTRAINT yhteystyyppi_yhteyshenkilo_fk
FOREIGN KEY (yhteystyyppi)
REFERENCES yhteystyyppi (yhteystyyppi)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE yhteyshenkilo ADD CONSTRAINT asiakas_yhteyshenkilo_fk
FOREIGN KEY (asiakasnumero)
REFERENCES asiakas (asiakasnumero)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE vuokraus ADD CONSTRAINT asiakas_vuokraus_fk
FOREIGN KEY (asiakasnumero)
REFERENCES asiakas (asiakasnumero)
ON DELETE NO ACTION
ON UPDATE NO ACTION