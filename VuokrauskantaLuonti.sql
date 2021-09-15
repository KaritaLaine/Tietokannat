-- SQLiteä varten muokattu versio
-- VARCHAR -> TEXT
-- FLOAT -> REAL


CREATE TABLE tuoteryhma (
                tuoteryhma TEXT NOT NULL,
                CONSTRAINT tuoteryhma_pk PRIMARY KEY (tuoteryhma)
);


CREATE TABLE tuote (
                yksilointikoodi INTEGER NOT NULL,
                tuoteryhma TEXT NOT NULL,
                nimike TEXT NOT NULL,
                merkki TEXT NOT NULL,
                malli TEXT NOT NULL,
                paivavuokra REAL NOT NULL,
                CONSTRAINT tuote_pk PRIMARY KEY (yksilointikoodi)
);


CREATE TABLE yhteystyyppi (
                yhteystyyppi TEXT NOT NULL,
                CONSTRAINT yhteystyyppi_pk PRIMARY KEY (yhteystyyppi)
);
-- COMMENT ON COLUMN yhteystyyppi.yhteystyyppi IS 'Taulu on luotu vain k�ytt�liittym�� varten. 
-- Se est�� k�ytt�j�� sy�tt�m�st� Yhteyshenkil�-tauluun muita kuin ennalta m��r�ttyj� arvoja.';


CREATE TABLE asiakas (
                asiakasnumero INTEGER NOT NULL,
                yritys TEXT NOT NULL,
                laskutusosoite TEXT NOT NULL,
                postinumero TEXT NOT NULL,
                postitoimipaikka TEXT NOT NULL,
                CONSTRAINT asiakas_pk PRIMARY KEY (asiakasnumero)
);
-- COMMENT ON TABLE asiakas IS 'Asiakkaan perustiedot';
-- COMMENT ON COLUMN asiakas.laskutusosoite IS 'Yrityksen laskujen katu- tai PL-osoite';


CREATE TABLE vuokraus (
                tapahtuma_id INTEGER NOT NULL,
                alkamispaiva DATE NOT NULL,
                paattymispaiva DATE NOT NULL,
                asiakasnumero INTEGER NOT NULL,
                yksilointikoodi INTEGER NOT NULL,
                CONSTRAINT vuokraus_pk PRIMARY KEY (tapahtuma_id)
);
-- COMMENT ON COLUMN vuokraus.tapahtuma_id IS 'Dummy id tulevia k�ytt�tarkoituksia varten';


CREATE TABLE yhteyshenkilo (
                yhteyshenkilo_id INTEGER NOT NULL,
                yhteystyyppi TEXT NOT NULL,
                etunimi TEXT NOT NULL,
                sukunimi TEXT NOT NULL,
                puhelin TEXT,
                sahkoposti TEXT NOT NULL,
                asiakasnumero INTEGER NOT NULL,
                CONSTRAINT yhteyshenkilo_pk PRIMARY KEY (yhteyshenkilo_id)
);
-- COMMENT ON COLUMN yhteyshenkilo.yhteyshenkilo_id IS 'Dummy perusavain. 
-- Tulevaisuuden tarpeita varten.';
-- COMMENT ON COLUMN yhteyshenkilo.yhteystyyppi IS 'Taulu on luotu vain k�ytt�liittym�� varten. 
-- Se est�� k�ytt�j�� sy�tt�m�st� Yhteyshenkil�-tauluun muita kuin ennalta m��r�ttyj� arvoja.';


ALTER TABLE tuote ADD CONSTRAINT tuoteryhma_tuote_fk
FOREIGN KEY (tuoteryhma)
REFERENCES tuoteryhma (tuoteryhma)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE vuokraus ADD CONSTRAINT tuote_vuokraus_fk
FOREIGN KEY (yksilointikoodi)
REFERENCES tuote (yksilointikoodi)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE yhteyshenkilo ADD CONSTRAINT yhteystyyppi_yhteyshenkilo_fk
FOREIGN KEY (yhteystyyppi)
REFERENCES yhteystyyppi (yhteystyyppi)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE yhteyshenkilo ADD CONSTRAINT asiakas_yhteyshenkilo_fk
FOREIGN KEY (asiakasnumero)
REFERENCES asiakas (asiakasnumero)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE vuokraus ADD CONSTRAINT asiakas_vuokraus_fk
FOREIGN KEY (asiakasnumero)
REFERENCES asiakas (asiakasnumero)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
