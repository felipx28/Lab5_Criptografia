# aUtiliza la imagen base de Ubuntu 20.10
FROM ubuntu:20.10

RUN sed -i 's/archive/old-releases/g' /etc/apt/sources.list
RUN sed -i '/^deb.*security.ubuntu.com/s/^/#/' /etc/apt/sources.list

# Actualiza los paquetes e instala sudo, net-tools, 
# openssh-client y tshark
RUN apt-get update && apt-get install -y sudo net-tools openssh-server \
openssh-client tshark

# Configura el usuario "test" con la contraseña "test"
RUN useradd -m test && echo "test:test" | chpasswd && adduser test sudo

# Exponer el puerto 22 para SSH
EXPOSE 22

# Inicia el servicio SSH
CMD ["/usr/sbin/sshd", "-D"]
