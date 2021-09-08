
CREATE TABLE tuoteryhma (
                tuoteryhma VARCHAR(20) NOT NULL,
                CONSTRAINT tuoteryhma_pk PRIMARY KEY (tuoteryhma)
);


CREATE TABLE tuote (
                yksilointikoodi INTEGER NOT NULL,
                tuoteryhma VARCHAR(20) NOT NULL,
                nimike VARCHAR(40) NOT NULL,
                merkki VARCHAR(20) NOT NULL,
                malli VARCHAR(20) NOT NULL,
                paivavuokra FLOAT NOT NULL,
                CONSTRAINT tuote_pk PRIMARY KEY (yksilointikoodi)
);


CREATE TABLE yhteystyyppi (
                yhteystyyppi VARCHAR(20) NOT NULL,
                CONSTRAINT yhteystyyppi_pk PRIMARY KEY (yhteystyyppi)
);
COMMENT ON COLUMN yhteystyyppi.yhteystyyppi IS 'Taulu on luotu vain käyttöliittymää varten. Se estää käyttäjää syöttämästä Yhteyshenkilö-tauluun muita kuin ennalta määrättyjä arvoja.';


CREATE TABLE asiakas (
                asiakasnumero INTEGER NOT NULL,
                yritys VARCHAR(30) NOT NULL,
                laskutusosoite VARCHAR(30) NOT NULL,
                postinumero VARCHAR(10) NOT NULL,
                postitoimipaikka VARCHAR(30) NOT NULL,
                CONSTRAINT asiakas_pk PRIMARY KEY (asiakasnumero)
);
COMMENT ON TABLE asiakas IS 'Asiakkaan perustiedot';
COMMENT ON COLUMN asiakas.laskutusosoite IS 'Yrityksen laskujen katu- tai PL-osoite';


CREATE TABLE vuokraus (
                tapahtuma_id INTEGER NOT NULL,
                alkamispaiva DATE NOT NULL,
                paattymispaiva DATE NOT NULL,
                asiakasnumero INTEGER NOT NULL,
                yksilointikoodi INTEGER NOT NULL,
                CONSTRAINT vuokraus_pk PRIMARY KEY (tapahtuma_id)
);
COMMENT ON COLUMN vuokraus.tapahtuma_id IS 'Dummy id tulevia käyttötarkoituksia varten';


CREATE TABLE yhteyshenkilo (
                yhteyshenkilo_id INTEGER NOT NULL,
                yhteystyyppi VARCHAR(20) NOT NULL,
                etunimi VARCHAR(20) NOT NULL,
                sukunimi VARCHAR(30) NOT NULL,
                puhelin VARCHAR(15),
                sahkoposti VARCHAR(40) NOT NULL,
                asiakasnumero INTEGER NOT NULL,
                CONSTRAINT yhteyshenkilo_pk PRIMARY KEY (yhteyshenkilo_id)
);
COMMENT ON COLUMN yhteyshenkilo.yhteyshenkilo_id IS 'Dummy perusavain. Tulevaisuuden tarpeita varten.';
COMMENT ON COLUMN yhteyshenkilo.yhteystyyppi IS 'Taulu on luotu vain käyttöliittymää varten. Se estää käyttäjää syöttämästä Yhteyshenkilö-tauluun muita kuin ennalta määrättyjä arvoja.';


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
