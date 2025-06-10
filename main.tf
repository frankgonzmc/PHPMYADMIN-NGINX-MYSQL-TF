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

#PHPMYADMIN
resource "docker_image" "phpmyadmin"{
    name = "phpmyadmin/phpmyadmin:latest"
    keep_locally = false
}

resource "docker_container" "phpmyadmin"{
    name = "phpmyadmin_container"
    image = docker_image.phpmyadmin.image_id
    env = [
        "PMA_HOST=mysql_container",
        "PMA_PORT=3306"
    ]
    ports {
        internal = var.phpmyadmin_port_internal
        external = var.phpmyadmin_port_external
    }
    networks_advanced {
        name = docker_network.private_network.name
    }
    depends_on = [docker_container.mysql]
}

# NGINX
resource "docker_image" "nginx"{
    name = var.nginx_version
    keep_locally = false
}

resource "docker_container" "nginx"{
    name = "nginx_container"
    image =  docker_image.nginx.image_id
    ports {
        internal = var.nginx_port_internal
        external = var.nginx_port_external
    }
    networks_advanced {
        name = docker_network.private_network.name
    }
    depends_on = [ docker_container.mysql ]
}



#RED INTERNA
resource "docker_network" "private_network"{
    name = "private_network_phpmyadmin_mysql_nginx"
}