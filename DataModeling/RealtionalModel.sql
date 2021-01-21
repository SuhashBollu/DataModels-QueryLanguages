-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`User` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `display_name` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) CHARACTER SET 'binary' NOT NULL,
  `email_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `display_name_UNIQUE` (`display_name` ASC) VISIBLE,
  UNIQUE INDEX `email_id_UNIQUE` (`email_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Student` (
  `student_id` INT NOT NULL,
  PRIMARY KEY (`student_id`),
  CONSTRAINT `fk_Student_User1`
    FOREIGN KEY (`student_id`)
    REFERENCES `mydb`.`User` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Department`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Department` (
  `department_id` INT NOT NULL,
  `department_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`department_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Professor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Professor` (
  `professor_id` INT NOT NULL,
  `department_id` INT NOT NULL,
  PRIMARY KEY (`professor_id`),
  INDEX `department_id_idx` (`department_id` ASC) VISIBLE,
  CONSTRAINT `professor_ibfk_1`
    FOREIGN KEY (`department_id`)
    REFERENCES `mydb`.`Department` (`department_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `professor_ibfk_2`
    FOREIGN KEY (`professor_id`)
    REFERENCES `mydb`.`User` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`staff` (
  `staff_id` INT NOT NULL,
  `department_id` INT NOT NULL,
  INDEX `department_id_idx` (`department_id` ASC) VISIBLE,
  UNIQUE INDEX `emailId_UNIQUE` (`staff_id` ASC) VISIBLE,
  PRIMARY KEY (`staff_id`),
  CONSTRAINT `staff_ibfk_1`
    FOREIGN KEY (`department_id`)
    REFERENCES `mydb`.`Department` (`department_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `staff_ibfk_2`
    FOREIGN KEY (`staff_id`)
    REFERENCES `mydb`.`User` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Program`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Program` (
  `program_id` INT NOT NULL,
  `program_name` VARCHAR(45) NULL,
  `department_id` INT NULL,
  PRIMARY KEY (`program_id`),
  INDEX `program_bfk_1_idx` (`department_id` ASC) VISIBLE,
  CONSTRAINT `program_bfk_1`
    FOREIGN KEY (`department_id`)
    REFERENCES `mydb`.`Department` (`department_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Course`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Course` (
  `course_id` INT NOT NULL AUTO_INCREMENT,
  `course_name` VARCHAR(45) NULL,
  `department_id` INT NOT NULL,
  PRIMARY KEY (`course_id`),
  INDEX `fk_Courses_Department1_idx` (`department_id` ASC) VISIBLE,
  CONSTRAINT `fk_Courses_Department1`
    FOREIGN KEY (`department_id`)
    REFERENCES `mydb`.`Department` (`department_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`prerequisite`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`prerequisite` (
  `pre_id` INT NOT NULL,
  `course_id` INT NOT NULL,
  PRIMARY KEY (`pre_id`, `course_id`),
  CONSTRAINT `fk_prerequisities_Courses1`
    FOREIGN KEY (`pre_id`)
    REFERENCES `mydb`.`Course` (`course_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Semester`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Semester` (
  `semester_year` INT NOT NULL,
  `season` VARCHAR(45) NOT NULL,
  `semester_id` INT NOT NULL,
  PRIMARY KEY (`semester_id`),
  UNIQUE INDEX `semester_uni` (`semester_year` ASC, `season` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Open_Courses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Open_Courses` (
  `course_id` INT NOT NULL,
  `capacity` INT NOT NULL,
  `professor_id` INT NOT NULL,
  `semester_id` INT NOT NULL,
  PRIMARY KEY (`course_id`, `semester_id`),
  INDEX `fk_Courses_has_Semester_Courses1_idx` (`course_id` ASC) VISIBLE,
  INDEX `fk_Opened_Courses_Professor1_idx` (`professor_id` ASC) VISIBLE,
  INDEX `fk_Opened_Courses_Semester1_idx` (`semester_id` ASC) VISIBLE,
  CONSTRAINT `fk_Courses_has_Semester_Courses1`
    FOREIGN KEY (`course_id`)
    REFERENCES `mydb`.`Course` (`course_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Opened_Courses_Professor1`
    FOREIGN KEY (`professor_id`)
    REFERENCES `mydb`.`Professor` (`professor_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Opened_Courses_Semester1`
    FOREIGN KEY (`semester_id`)
    REFERENCES `mydb`.`Semester` (`semester_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Student_Program`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Student_Program` (
  `program_id` INT NOT NULL,
  `student_id` INT NOT NULL,
  PRIMARY KEY (`program_id`, `student_id`),
  INDEX `fk_Student_Program_Student1_idx` (`student_id` ASC) VISIBLE,
  CONSTRAINT `fk_Student_Program_Student1`
    FOREIGN KEY (`student_id`)
    REFERENCES `mydb`.`Student` (`student_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Course_Session`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Course_Session` (
  `session_id` INT NOT NULL,
  `capacity` INT NOT NULL,
  `course_id` INT NOT NULL,
  `semester_id` INT NOT NULL,
  PRIMARY KEY (`session_id`),
  INDEX `fk_Course_Session_Opened_Courses1_idx` (`course_id` ASC, `semester_id` ASC) VISIBLE,
  CONSTRAINT `fk_Course_Session_Opened_Courses1`
    FOREIGN KEY (`course_id` , `semester_id`)
    REFERENCES `mydb`.`Open_Courses` (`course_id` , `semester_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`registered_student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`registered_student` (
  `student_id` INT NOT NULL,
  `semester_id` INT NOT NULL,
  PRIMARY KEY (`student_id`, `semester_id`),
  INDEX `fk_registered_student_Student1_idx` (`student_id` ASC) VISIBLE,
  INDEX `fk_Semester_has_Student_Semester1_idx` (`semester_id` ASC) VISIBLE,
  CONSTRAINT `fk_Semester_has_Student_Semester1`
    FOREIGN KEY (`semester_id`)
    REFERENCES `mydb`.`Semester` (`semester_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_registered_student_Student1`
    FOREIGN KEY (`student_id`)
    REFERENCES `mydb`.`Student` (`student_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`course_enrolled_students`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`course_enrolled_students` (
  `course_id` INT NOT NULL,
  `final_grade` ENUM("A", "B", "C", "D", "F") NULL,
  `student_id` INT NOT NULL,
  `semester_id` INT NOT NULL,
  PRIMARY KEY (`course_id`, `student_id`, `semester_id`),
  INDEX `fk_Opened_Courses_has_registered_student_Opened_Courses1_idx` (`course_id` ASC) VISIBLE,
  INDEX `fk_course_enrolled_students_registered_student1_idx` (`student_id` ASC, `semester_id` ASC) VISIBLE,
  CONSTRAINT `fk_Opened_Courses_has_registered_student_Opened_Courses1`
    FOREIGN KEY (`course_id`)
    REFERENCES `mydb`.`Open_Courses` (`course_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_course_enrolled_students_registered_student1`
    FOREIGN KEY (`student_id` , `semester_id`)
    REFERENCES `mydb`.`registered_student` (`student_id` , `semester_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Exam`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Exam` (
  `Exam_id` INT NOT NULL,
  `course_id` INT NOT NULL,
  PRIMARY KEY (`Exam_id`),
  INDEX `fk_Exams_Courses1_idx` (`course_id` ASC) VISIBLE,
  CONSTRAINT `fk_Exams_Courses1`
    FOREIGN KEY (`course_id`)
    REFERENCES `mydb`.`Course` (`course_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Problem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Problem` (
  `problem_id` INT NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  `exam_id` INT NOT NULL,
  PRIMARY KEY (`problem_id`),
  INDEX `fk_Problems_Exams1_idx` (`exam_id` ASC) VISIBLE,
  CONSTRAINT `fk_Problems_Exams1`
    FOREIGN KEY (`exam_id`)
    REFERENCES `mydb`.`Exam` (`Exam_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Students_Exam`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Students_Exam` (
  `exam_id` INT NOT NULL,
  `grades` ENUM("A", "B", "C", "D", "F") NULL,
  `course_id` INT NOT NULL,
  `student_id` INT NOT NULL,
  `semester_id` INT NOT NULL,
  PRIMARY KEY (`exam_id`, `course_id`, `student_id`, `semester_id`),
  INDEX `fk_Enrolled_students_has_Exams_Exams1_idx` (`exam_id` ASC) VISIBLE,
  INDEX `fk_Students_Exam_course_enrolled_students1_idx` (`course_id` ASC, `student_id` ASC, `semester_id` ASC) VISIBLE,
  CONSTRAINT `fk_Enrolled_students_has_Exams_Exams1`
    FOREIGN KEY (`exam_id`)
    REFERENCES `mydb`.`Exam` (`Exam_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Students_Exam_course_enrolled_students1`
    FOREIGN KEY (`course_id` , `student_id` , `semester_id`)
    REFERENCES `mydb`.`course_enrolled_students` (`course_id` , `student_id` , `semester_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Students_Problem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Students_Problem` (
  `problem_id` INT NOT NULL,
  `exam_id` INT NOT NULL,
  `course_id` INT NOT NULL,
  `student_id` INT NOT NULL,
  `semester_id` INT NOT NULL,
  PRIMARY KEY (`problem_id`, `exam_id`, `course_id`, `student_id`, `semester_id`),
  INDEX `fk_Students_take_Exams_has_Problems_Problems1_idx` (`problem_id` ASC) VISIBLE,
  INDEX `fk_Students_Problem_Students_Exam1_idx` (`exam_id` ASC, `course_id` ASC, `student_id` ASC, `semester_id` ASC) VISIBLE,
  CONSTRAINT `fk_Students_take_Exams_has_Problems_Problems1`
    FOREIGN KEY (`problem_id`)
    REFERENCES `mydb`.`Problem` (`problem_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Students_Problem_Students_Exam1`
    FOREIGN KEY (`exam_id` , `course_id` , `student_id` , `semester_id`)
    REFERENCES `mydb`.`Students_Exam` (`exam_id` , `course_id` , `student_id` , `semester_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Book`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Book` (
  `ISBN` INT NOT NULL,
  `title` VARCHAR(45) NOT NULL,
  `page_count` INT NOT NULL,
  `publication_date` DATE NOT NULL,
  PRIMARY KEY (`ISBN`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Author`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Author` (
  `author_id` INT NOT NULL AUTO_INCREMENT,
  `author_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`author_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Book_Author`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Book_Author` (
  `Book_ISBN` INT NOT NULL,
  `Author_author_id` INT NOT NULL,
  PRIMARY KEY (`Book_ISBN`, `Author_author_id`),
  INDEX `fk_Book_has_Author_Author1_idx` (`Author_author_id` ASC) VISIBLE,
  INDEX `fk_Book_has_Author_Book1_idx` (`Book_ISBN` ASC) VISIBLE,
  CONSTRAINT `fk_Book_has_Author_Book1`
    FOREIGN KEY (`Book_ISBN`)
    REFERENCES `mydb`.`Book` (`ISBN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Book_has_Author_Author1`
    FOREIGN KEY (`Author_author_id`)
    REFERENCES `mydb`.`Author` (`author_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`library_site`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`library_site` (
  `site_id` INT NOT NULL AUTO_INCREMENT,
  `library_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`site_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`book_unit`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`book_unit` (
  `book_unit_id` INT NOT NULL AUTO_INCREMENT,
  `price` INT NOT NULL,
  `purchase_date` DATE NOT NULL,
  `Book_ISBN` INT NOT NULL,
  `library_site_site_id` INT NOT NULL,
  `rental_date` DATETIME NULL,
  `due_date` DATETIME NULL,
  `return_date` DATETIME NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`book_unit_id`),
  INDEX `fk_Book_copy_Book1_idx` (`Book_ISBN` ASC) VISIBLE,
  INDEX `fk_Book_copy_library_site1_idx` (`library_site_site_id` ASC) VISIBLE,
  INDEX `fk_book_unit_User1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_Book_copy_Book1`
    FOREIGN KEY (`Book_ISBN`)
    REFERENCES `mydb`.`Book` (`ISBN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Book_copy_library_site1`
    FOREIGN KEY (`library_site_site_id`)
    REFERENCES `mydb`.`library_site` (`site_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_book_unit_User1`
    FOREIGN KEY (`user_id`)
    REFERENCES `mydb`.`User` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`feedback`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`feedback` (
  `course_id` INT NOT NULL,
  `student_id` INT NOT NULL,
  `semester_id` INT NOT NULL,
  `professor_id` INT NOT NULL,
  PRIMARY KEY (`course_id`, `student_id`, `semester_id`, `professor_id`),
  INDEX `fk_course_enrolled_students_has_Professor_Professor1_idx` (`professor_id` ASC) VISIBLE,
  INDEX `fk_course_enrolled_students_has_Professor_course_enrolled_s_idx` (`course_id` ASC, `student_id` ASC, `semester_id` ASC) VISIBLE,
  CONSTRAINT `fk_course_enrolled_students_has_Professor_course_enrolled_stu1`
    FOREIGN KEY (`course_id` , `student_id` , `semester_id`)
    REFERENCES `mydb`.`course_enrolled_students` (`course_id` , `student_id` , `semester_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_course_enrolled_students_has_Professor_Professor1`
    FOREIGN KEY (`professor_id`)
    REFERENCES `mydb`.`Professor` (`professor_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`teaching_assistant`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`teaching_assistant` (
  `course_id` INT NOT NULL,
  `semester_id` INT NOT NULL,
  `student_id` INT NOT NULL,
  PRIMARY KEY (`course_id`, `semester_id`, `student_id`),
  INDEX `fk_Open_Courses_has_Student_Student1_idx` (`student_id` ASC) VISIBLE,
  INDEX `fk_Open_Courses_has_Student_Open_Courses1_idx` (`course_id` ASC, `semester_id` ASC) VISIBLE,
  CONSTRAINT `fk_Open_Courses_has_Student_Open_Courses1`
    FOREIGN KEY (`course_id` , `semester_id`)
    REFERENCES `mydb`.`Open_Courses` (`course_id` , `semester_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Open_Courses_has_Student_Student1`
    FOREIGN KEY (`student_id`)
    REFERENCES `mydb`.`Student` (`student_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
