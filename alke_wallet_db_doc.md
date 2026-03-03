# 📄 Alke Wallet - Base de Datos Relacional

Curso: Desarrollo de Aplicaciones Fullstack Python Trainee. 

Módulo: Fundamentos de Bases de Datos Relacionales. 

Profesor: Ariel Rosenamnn. 

Alumno: Roberto Otárola. 

1. Creación de la base de datos
📸 [Capturas de pantalla de la ejecución de CREATE DATABASE "AlkeWallet"; y del panel izquierdo de DBeaver mostrando la BD]
![1_1](images/1_1.png)
![1_2](images/1_2.png)
![1_3](images/1_3.png)

2. Creación de tablas
📸 [Capturas de pantalla de las tres tablas creadas]
![2_1](images/2_1.png)
![2_2](images/2_2.png)
![2_3](images/2_3.png)

3. Inserción de datos
📸 [Capturas de pantalla de los resultados de SELECT * FROM usuario;, SELECT * FROM moneda; y SELECT * FROM transaccion; después de insertar los datos de prueba]
![3_1](images/3_1.png)
![3_2](images/3_2.png)
![3_3](images/3_3.png)

4. Consultas requeridas
    1. Moneda de un usuario:
    📸 [Captura de pantalla del resultado de la consulta]
![4_1](images/4_1.png)

    2. Todas las transacciones:
    📸 [Captura de pantalla del resultado de la consulta]
![4_2](images/4_2.png)

    3. Transacciones de un usuario:
    📸 [Captura de pantalla del resultado de la consulta]
![4_3](images/4_3.png)

    4. Actualizar correo:
    📸 [Capturas de pantalla del usuario ANTES y DESPUÉS del update]
![4_4_1](images/4_4_1.png)
![4_4_2](images/4_4_2.png)

    5. Eliminar transacción:
    📸 [Capturas de pantalla de las transacciones ANTES y DESPUÉS del delete]
![4_5_1](images/4_5_1.png)
![4_5_2](images/4_5_2.png)

5. Transaccionalidad (ACID)
    1. Prueba de COMMIT:
    📸 [Captura de pantalla mostrando los saldos actualizados y la nueva transacción tras el COMMIT]
![5_1](images/5_1.png)

    2. Prueba de ROLLBACK:
    📸 [Capturas de pantalla mostrando el error de la llave foránea y el mensaje exitoso del ROLLBACK]
![5_2_2](images/5_2_1.png)
![5_2_2](images/5_2_2.png)

6. Diagrama ER
📸 [Imagen del Diagrama Entidad-Relación exportado desde dbdiagram.io mostrando claramente que usuario tiene una FK hacia moneda y que transaccion tiene dos FK hacia usuario]
![Diagrama Entidad-Relación exportado desde dbdiagram.io](images/alke_wallet_db_erd.png)
