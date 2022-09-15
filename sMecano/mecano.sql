INSERT INTO `addon_account` (`name`, `label`, `shared`) VALUES
('society_mecano', 'Mécano', 1);

INSERT INTO `addon_inventory` (`name`, `label`, `shared`) VALUES
('society_mecano', 'Mécano', 1);

INSERT INTO `jobs` (`name`, `label`) VALUES
('mecano', 'Mécano');

INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
('mecano', 0, 'novice', 'Recrue', 100, '', ''),
('mecano', 1, 'experimente', 'Mécano', 100, '', ''),
('mecano', 2, 'experimente', 'Chef Equipe', 100, '', ''),
('mecano', 3, 'experimente', 'Co-Patron', 100, '', ''),
('mecano', 4, 'boss', 'Patron', 100, '', '');


INSERT INTO `items` (name, label, `weight`) VALUES
	('fixkit', 'Kit réparation', 3),
	('carokit', 'Kit carosserie', 10);
