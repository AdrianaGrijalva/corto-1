#Utiliza la imagen de OpenJDK
FROM openjdk:17

#Establece el directorio de trabajo en el contenedor
WORKDIR /app

#Copiar el archivo mvnw y el archivo pom.xml
COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .

#Ejecuta el wrapper de maven para desargar las dependencias
RUN ./mvnw dependency:go-offline

#Copia el codigo fuente de la aplicacion
COPY src ./src

#Compila la app usando el wrapper de maven
RUN ./mvnw clean package -DskipTests

#Exponer el puerto en el que la aplicacion spring boot se ejecutara
EXPOSE 8080

#Comando para ejecutar la app cuando inicie el contenedor
CMD ["./mvnw", "spring-boot:run"]