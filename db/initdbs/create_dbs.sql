CREATE DATABASE IF NOT EXISTS `pennylanetask_production`;
GRANT ALL ON `pennylanetask_production`.* TO 'processor'@'%';

CREATE DATABASE IF NOT EXISTS `pennylanetask_production`;
GRANT ALL ON `pennylanetask_development`.* TO 'processor'@'%';

CREATE DATABASE IF NOT EXISTS `pennylanetask_production`;
GRANT ALL ON `pennylanetask_testing`.* TO 'processor'@'%';