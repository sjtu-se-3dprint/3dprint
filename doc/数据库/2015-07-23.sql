CREATE TABLE `3dprint3`.`cart` (
  `cart_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '',
  `model_id` INT(10) UNSIGNED NOT NULL COMMENT '',
  `user_id` INT(10) UNSIGNED NOT NULL COMMENT '',
  `material_id` INT(11) NULL COMMENT '',
  `amount` INT(11) UNSIGNED NOT NULL COMMENT '',
  `selected` INT(11) NULL DEFAULT 0 COMMENT '',
  `addtime` DATETIME NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
  `updatetime` DATETIME NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
  `status` VARCHAR(128) NULL DEFAULT 'normal' COMMENT '',
  PRIMARY KEY (`cart_id`)  COMMENT '',
  UNIQUE INDEX `cart_id_UNIQUE` (`cart_id` ASC)  COMMENT '',
  INDEX `user_id_idx` (`user_id` ASC)  COMMENT '',
  INDEX `model_id_idx` (`model_id` ASC)  COMMENT '',
  CONSTRAINT `user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `3dprint3`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `model_id`
    FOREIGN KEY (`model_id`)
    REFERENCES `3dprint3`.`model` (`model_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
