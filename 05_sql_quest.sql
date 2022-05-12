-- choisir la DB -- 
USE wild_db_quest;

-- delete rows in table -- 
TRUNCATE wizard;

-- to show table creation query --
SHOW CREATE TABLE wizard;

-- remove the foreign key constraint --
ALTER TABLE wizard
DROP FOREIGN KEY fk_wizard_school;

-- delete columns -- 
ALTER TABLE wizard
DROP COLUMN birthday,
DROP COLUMN birth_place,
DROP COLUMN biography, 
DROP COLUMN is_muggle,
DROP COLUMN school_id;

-- create table team --
CREATE TABLE `team` (
 `id` INT NOT NULL AUTO_INCREMENT,
 `name` VARCHAR(80) NOT NULL,
  PRIMARY KEY (`id`)
  );
  
-- create table player --
CREATE TABLE `player` (
 `id` INT NOT NULL AUTO_INCREMENT,
 `wizard_id` INT NOT NULL,
 `team_id` INT,
 `role` VARCHAR(50),
 `enrollment_date` DATE,
 CONSTRAINT fk_player_wizard
   FOREIGN KEY (wizard_id)
   REFERENCES wizard(id),
 CONSTRAINT fk_player_team
   FOREIGN KEY (team_id)
   REFERENCES team(id),
 PRIMARY KEY (`id`)
 );

-- show schema of tables wizard, player & team --
DESCRIBE wizard;
DESCRIBE player;
DESCRIBE team;

-- check data import results --
SELECT *
FROM wizard;
SELECT *
FROM team;
SELECT *
FROM player;

-- Q1: nom, prenom, role, equipe par ordre alphabetique  --
SELECT wizard.lastname, wizard.firstname, player.role, team.name
FROM player
INNER JOIN wizard ON wizard.id = player.wizard_id
INNER JOIN team ON team.id = player.team_id
ORDER BY team.name, player.role, wizard.lastname, wizard.firstname;

-- Q2: nom et prenom des seekers par ordre alphabetique nom --
SELECT wizard.lastname, wizard.firstname, player.role
FROM player
INNER JOIN wizard ON wizard.id = player.wizard_id
WHERE player.role = 'seeker'
ORDER BY wizard.lastname, wizard.firstname;

-- Q3: -- 
SELECT *
FROM wizard
LEFT JOIN player ON wizard.id = player.wizard_id
WHERE player.wizard_id IS NULL;
