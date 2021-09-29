-- Lisätään testiasiakkaat asiakas-tauluun

USE Vuokraus
GO

INSERT INTO asiakas (asiakasnumero,yritys,laskutusosoite,postinumero,postitoimipaikka) VALUES
	 ('Raseko','Purokatu 1','21200','Raisio'),
	 ('Autoliike','Keskuskatu 3','23100','Mynämäki'),
	 ('Mähönen Oy','Kuormakatu 2','21200','Raisio'),
	 ('Huttu ja keitto Ay','Puoskarinkatu 2 A 11','20100','Turku');
