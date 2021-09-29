-- SQLiteä varten muokattu versio
-- VARCHAR -> TEXT
-- FLOAT -> REAL

CREATE TABLE tuoteryhma (
                tuoteryhma TEXT PRIMARY KEY
);


CREATE TABLE tuote (
                yksilointikoodi INTEGER PRIMARY KEY,
                tuoteryhma TEXT NOT NULL,
                nimike TEXT NOT NULL,
                merkki TEXT NOT NULL,
                malli TEXT NOT NULL,
                paivavuokra REAL NOT NULL,
                FOREIGN KEY (tuoteryhma) REFERENCES tuoteryhma (tuoteryhma)
);


CREATE TABLE yhteystyyppi (
                yhteystyyppi TEXT PRIMARY KEY,
);
-- COMMENT ON COLUMN yhteystyyppi.yhteystyyppi IS 'Taulu on luotu vain k�ytt�liittym�� varten. 


CREATE TABLE asiakas (
                asiakasnumero INTEGER PRIMARY KEY,
                yritys TEXT NOT NULL,
                laskutusosoite TEXT NOT NULL,
                postinumero TEXT NOT NULL,
                postitoimipaikka TEXT NOT NULL,
);
-- COMMENT ON TABLE asiakas IS 'Asiakkaan perustiedot';
-- COMMENT ON COLUMN asiakas.laskutusosoite IS 'Yrityksen laskujen katu- tai PL-osoite';


CREATE TABLE yhteyshenkilo (
                yhteyshenkilo_id INTEGER PRIMARY KEY,
                yhteystyyppi TEXT NOT NULL,
                etunimi TEXT NOT NULL,
                sukunimi TEXT NOT NULL,
                puhelin TEXT,
                sahkoposti TEXT NOT NULL,
                asiakasnumero INTEGER NOT NULL,
                FOREIGN KEY (yhteystyyppi) REFERENCES yhteystyyppi (yhteystyyppi),
                FOREIGN KEY (asiakasnumero) REFERENCES asiakasnumero (asiakasnumero)
);
-- COMMENT ON COLUMN yhteyshenkilo.yhteyshenkilo_id IS 'Dummy perusavain. Tulevaisuuden tarpeita varten.';
-- COMMENT ON COLUMN yhteyshenkilo.yhteystyyppi IS 'Taulu on luotu vain k�ytt�liittym�� varten. Se est�� k�ytt�j�� sy�tt�m�st� Yhteyshenkil�-tauluun muita kuin ennalta m��r�ttyj� arvoja.';


CREATE TABLE vuokraus (
                tapahtuma_id INTEGER PRIMARY KEY,
                alkamispaiva DATE NOT NULL,
                paattymispaiva DATE NOT NULL,
                asiakasnumero INTEGER NOT NULL,
                yksilointikoodi INTEGER NOT NULL,
                FOREIGN KEY (asiakasnumero) REFERENCES asiakas (asiakasnumero),
                FOREIGN KEY (yksilointikoodi) REFERENCES tuote (yksilointikoodi)
);
-- COMMENT ON COLUMN vuokraus.tapahtuma_id IS 'Dummy id tulevia k�ytt�tarkoituksia varten';