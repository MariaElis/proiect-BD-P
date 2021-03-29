select * from departament;
select * from angajat;
select * from confidential;
select * from manager;
select * from croitor;
select * from marime;
select * from produs;
select * from material;
select * from material_manager;
select * from produs_croitor


--Afisare prenume,salariu,data angajare si nume departament pentru fiecare angajat
SELECT a.prenume,a.salariu,a.data_angajare,d.nume_departament
FROM angajat a,departament d
WHERE d.id_departament=a.id_departament;

--Afisare nume,prenume,nume_departament si adresa fiecarui angajat
SELECT a.nume || ' ' || a.prenume Angajati, d.nume_departament,c.adresa
FROM angajat a, departament d, confidential c
WHERE d.id_departament=a.id_departament 
AND a.id_angajat=c.id_angajat;

--Afisare nume,prenume,data angajare,cnp,numar telefon,adresa pentru fiecare angajat
SELECT a.nume,a.prenume,a.data_angajare,c.cnp,c.telefon,c.adresa
FROM angajat a,confidential c
WHERE c.id_angajat=a.id_angajat;


--Afisare nr. produse realizate pe categorie si id_marime
select p.nume_produs, p.categorie, id_marime, pc.nr_produse
from produs p,produs_croitor pc
where p.id_produs=pc.id_produs;

--Afisare nr. produse realizate pe categorie si marime
select p.nume_produs, p.categorie, m.marime_cm ,pc.nr_produse
from produs p,produs_croitor pc, marime m
where p.id_produs=pc.id_produs
AND m.id_marime=p.id_marime;

--Afisarea materialului,culorii si categoriei unui anumit produs 
SELECT p.nume_produs,p.categorie,mat.nume_material,mat.culoare
FROM produs p,produs_material pm, material mat
WHERE p.id_produs = pm.id_produs
AND pm.id_material=mat.id_material
AND p.nume_produs='palton';

--Afisarea materialului,culoarea, categoria si marimea unui anumit produs 
SELECT p.nume_produs,p.categorie,m.marime_cm,mat.nume_material,mat.culoare
FROM produs p,produs_material pm, material mat, marime m
WHERE p.id_produs = pm.id_produs
AND pm.id_material=mat.id_material
AND p.id_marime=m.id_marime
AND p.nume_produs='palton';

--Afisarea numarului de produse realizate de un anumit croitor si data realizarii
SELECT  a.nume || ' ' || a.prenume CROITOR , p.nume_produs PRODUS,p.categorie,pc.nr_produse,pc.data_realizarii
FROM angajat a, croitor c, produs_croitor pc, produs p
WHERE a.id_angajat=c.id_angajat
AND c.id_croitor=pc.id_croitor
AND pc.id_produs=p.id_produs
AND a.nume='Maftei';


--Afisarea materialului si a detaliilor sale, procurat de managerii cu nume specificat
SELECT  a.nume || ' ' || a.prenume MANAGER,mt.nume_material MATERIAL, mt.culoare,mm.cant_material,mm.data_achizitionarii,mm.origine 
FROM manager m, material_manager mm, material mt,angajat a
WHERE m.id_manager=mm.id_manager
AND MM.ID_MATERIAL=MT.ID_MATERIAL
AND a.id_angajat=m.id_angajat
AND a.nume='Iancu';

--Afisarea pretului total pt fiecare material cumparat de catre un manager specificat
SELECT a.nume || ' ' || a.prenume MANAGER,m.buget_alocat,mt.nume_material MATERIAL, mt.culoare,mm.pret PRET_METRU,mm.cant_material,mm.cant_material*mm.pret TOTAL
FROM manager m, material_manager mm, material mt,angajat a
WHERE m.id_manager=mm.id_manager
AND MM.ID_MATERIAL=MT.ID_MATERIAL
AND a.id_angajat=m.id_angajat
AND a.nume='Tudurache';

--Calcul suma totala a bugetului primit de catre un manager (el primind aceeasi suma pt fiecare tip de material
--achizitionat), suma cheltuita si suma ramasa
SELECT SUM(m.buget_alocat) TOTAL_BUGET,SUM(mm.cant_material*mm.pret) CHELTUIELI,SUM(m.buget_alocat)-SUM(mm.cant_material*mm.pret) SUMA_RAMASA
FROM manager m, material_manager mm, material mt,angajat a
WHERE m.id_manager=mm.id_manager
AND MM.ID_MATERIAL=MT.ID_MATERIAL
AND a.id_angajat=m.id_angajat
AND a.nume='Tudurache';

--Afisarea costului pt fiecare produs ,avand in vedere pretul metrului de material
SELECT p.nume_produs,p.categorie,mar.marime_cm,m.nume_material MATERIAL,m.culoare,pm.cantitate_material,mm.pret PRET_METRU ,pm.cantitate_material*mm.pret PRET_PRODUS
FROM produs p,produs_material pm,material m,material_manager mm,marime mar
WHERE mm.id_material=m.id_material
AND m.id_material=pm.id_material
AND pm.id_produs=p.id_produs
AND mar.id_marime=p.id_marime;