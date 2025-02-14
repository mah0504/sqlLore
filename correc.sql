set search_path to pokemon;

-- 
-- a) Noms de pokémons dont les points de vie sont supérieurs ou égaux à 200
--
SELECT nom_pokemon FROM pokemon WHERE points_de_vie >= 200
;

-- b)
-- Noms des pokémons des dresseurs nommés Agatha dont l'âge est supérieur à 40
--
WITH r1 as (SELECT id_dresseur FROM dresseur 
            WHERE nom_dresseur = 'Agatha' AND age > 40)
  SELECT nom_pokemon FROM r1 NATURAL JOIN pokemon
;

--
-- c) Noms des attaques pour lesquelles il existe un pokémon qui a le même niveau que la
--    valeure de la puissance d'une attaque
--
SELECT nom_attaque FROM attaque WHERE EXISTS
 (SELECT * FROM pokemon WHERE pokemon.niveau = attaque.puissance)
;

--
-- d) Le nom des dresseurs avec  au moins 2 pokemons avec le nombre de pokémons qu'ils possèdent.
--    Ordonner les nombs alphabétiquement
-- 
WITH r1 as (SELECT * FROM dresseur NATURAL JOIN pokemon)
 SELECT nom_dresseur,count(nom_pokemon) as nb_pokemons FROM r1
 GROUP BY nom_dresseur
 HAVING count(nom_pokemon) >= 2
 ORDER BY nom_dresseur
;

--
-- e) Les noms des attaques dont la puissance est égale à 40 ou 120
--

SELECT nom_attaque FROM attaque WHERE puissance in (40,120)
;
-- ou encore
SELECT nom_attaque FROM attaque WHERE puissance = 40 or puissance = 120