#MYSQL
resource "docker_image" "mysql"{
    name = var.version_mysql
    keep_locally = false
}

resource "docker_volume" "mysql_data"{
    name = "mysql_data_container"
}

resource "docker_container" "mysql"{
    image = docker_image.mysql.image_id
    name = "mysql_container"
    networks_advanced {
        name = docker_network.private_network.name
    }
    ports {
        internal = var.port_internal
        external = var.port_external
    }
    #Volumes para persistencia de datos
    volumes{
        volume_name = docker_volume.mysql_data.name
        #Ruta de guardado de datos
        container_path = "/var/lib/mysql"
    }
    env = [
        "MYSQL_ROOT_PASSWORD=${var.mysql_root_password}",
        "MYSQL_DATABASE=${var.mysql_database}",
        "MYSQL_USER=${var.mysql_user}",
        "MYSQL_PASSWORD=${var.mysql_password}"
    ]
    restart = "always"
}






#RED INTERNA
resource "docker_network" "private_network"{
    name = "private_network_phpmyadmin_mysql_nginx"
}