#Variables para el modulo de mysql
variable "version_mysql"{
    description = "Version de mysql a instalar"
    type = string
}

variable "port_internal" {
    description = "Puerto interno de contenedor Mysql"
    type = number
}

variable "port_external"{
    description = "Puerto externo de contenedor Mysql"
    type = number
}

variable "mysql_root_password" {
    description = "Contraseña del usuario root de Mysql"
    type = string
}

variable "mysql_database" {
    description = "Base de datos a crear en Mysql"
    type = string
}

variable "mysql_user" {
    description = "Usuario a crear en Mysql"
    type = string
}

variable "mysql_password" {
    description = "Contraseña del usuario Mysql"
    type = string
}

#Variables para el modulo de phpmyadmin
variable "phpmyadmin_port_internal" {
    description = "Puerto interno de phpmyadmin"
    type = number
}

variable "phpmyadmin_port_external" {
    description = "Puerto externo de phpmyadmin"
    type = number
}

#Variables para el modulo de nginx
variable "nginx_port_internal" {
    description = "Puerto interno de nginx"
    type = number
}

variable "nginx_port_external" {
    description = "Puerto externo de nginx"
    type = number
}

variable "nginx_version"{
    description = "Version de nginx a instalar"
    type = string
}