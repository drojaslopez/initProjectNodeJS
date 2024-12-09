#!/bin/bash
#Create by Daniel Rojas drojaslopez.ing 

#./initProject.sh project_name project_author type_installation
# if you want to install the npm components you must indicate as the third argument the value
# type_installation = X 

# Example 
#./initProject.sh hito_2_Backend_Node_Express Daniel_Rojas X


# Nombre del proyecto
project_name="$1"
project_author="$2"
type_installation="$3"

# Verificar si se proporcionó un nombre
if [ -z "$project_name" ]; then
  echo "Por favor, proporciona un nombre para el proyecto."
  exit 1
fi

if [ -z "$project_author" ]; then
  echo "Por favor, proporciona un nombre para el autor."
  exit 1
fi

# Inicializar un nuevo proyecto Node.js
npm init -y

touch main.ts README.md .gitignore tsconfig.json docker-compose.yml

echo "node_modules
.env
/dist
/tmp
/out-tsc
postgres-data
.DS_Store
initProject.sh
"> .gitignore

echo "Archivo .gitignore"

echo "# $project_name
## $project_author
"> README.md

echo "Archivo README.md creado"

# Crear un archivo main.ts
main_template='import express from "express";
import dotenv from "dotenv";

dotenv.config({ path: ".env" });
const app = express();
const port = process.env.PORT || 5000;

app.use(express.json());
app.use(express.urlencoded({ extended: true }));


//app.use(pathAuth, authRoute);
//app.use("/api/v1/user", userRoute);


app.listen(port, () => {
  console.log(`Server running on port : ${port}`);
});'

echo "$main_template" > main.ts
echo "Archivo main.ts creado"


tsconfig_template='{
    "compilerOptions": {
    "target": "es2022",
    "strict": true,
    "outDir": "./dist",
    "moduleDetection": "force",
    "module": "Preserve",
    "resolveJsonModule": true,
    "allowJs": true,
    "esModuleInterop": true,
    "isolatedModules": true
    }
  }'

echo "$tsconfig_template" > tsconfig.json

echo "Archivo tsconfig.json creado"

docker_compose_template='# Define la versión del archivo Compose (opcional pero recomendable)
# version: "3.8"

# Sección para definir los servicios del proyecto
services:
  # Nombre del servicio (puedes cambiarlo según prefieras)
  db:
    # Imagen Docker que se usará para este servicio
    image: postgres:15 # Usa PostgreSQL versión 15

    # Nombre del contenedor
    container_name: postgres-1 # Nombre del contenedor

    # Variables de entorno para configurar la base de datos
    environment:
      POSTGRES_USER: postgres # Usuario predeterminado de la base de datos
      POSTGRES_PASSWORD: root # Contraseña del usuario
      POSTGRES_DB: dbexample # Nombre de la base de datos que se creará

    # Puertos: mapea el puerto 5432 (dentro del contenedor) al 5434 (en tu máquina host)
    ports:
      - "5434:5432" # host:contenedor

    # Volúmenes: mapea una carpeta local a la ruta de datos de PostgreSQL en el contenedor
    volumes:
      - ./postgres-data:/var/lib/postgresql/data
        # ./postgres-data es una carpeta en tu máquina local
        # /var/lib/postgresql/data es donde PostgreSQL guarda sus datos

# Define volúmenes externos (puedes agregar nombres aquí si los necesitas)
volumes:
  {}'

echo "$docker_compose_template" > docker-compose.yml

echo "Archivo docker-compose.yml creado"





# Crear la estructura de directorios
mkdir src data logs resource utils image
#cd src
mkdir src/{module,database,middleware}
#mkdir module database image middleware 
mkdir src/module/example
#cd module && mkdir example && cd example 
touch src/module/example/{route.ts,controller.ts,service.ts,model.ts,interfaces.ts}

# Instalar dependencias iniciales (opcional)
if [ "$type_installation" == "X" ]; then
  npm i tsx dotenv nodemon pkgroll typescript --save-dev 
  npm i bcryptjs express express-rate-limit jsonwebtoken nanoid pg winston --save
  npm i @types/bcryptjs @types/express @types/jsonwebtoken @types/node @types/pg --save-dev
  
fi

# Cambiar al directorio del proyecto
#cd "$project_name"

echo "Proyecto Node.js $project_name creado correctamente."
