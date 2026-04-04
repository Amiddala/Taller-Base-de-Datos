package com.mycompany.mavenproject1.Modelo;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class LoginController {

    private static final String URL  = Config.get("db.url");
    private static final String USER = Config.get("db.user");
    private static final String PASS = Config.get("db.pass");

    
    public Sesion login(String usuario, String password) {
        
            System.out.println("URL:  " + URL);
            System.out.println("USER: " + USER);
            System.out.println("PASS: " + PASS);
        
        try {
            Connection con = DriverManager.getConnection(URL, USER, PASS);

            // 1. Obtener PID
            int pid;
            try (Statement stmt = con.createStatement();
                 ResultSet rs = stmt.executeQuery("SELECT pg_backend_pid()")) {
                rs.next();
                pid = rs.getInt(1);
            }

            // 2. Verificar usuario — procedimiento almacenado
            int idUser;
            try (PreparedStatement ps = con.prepareStatement("SELECT verificar_usuario(?, ?)")) {
                ps.setString(1, usuario);
                ps.setString(2, password);
                try (ResultSet rs = ps.executeQuery()) {
                    rs.next();
                    idUser = rs.getInt(1);
                }
            }

            if (idUser == -1) {
                con.close();
                return null;
            }

            // 3. Guardar sesión — procedimiento almacenado
            try (PreparedStatement ps = con.prepareStatement("SELECT guardar_sesion(?, ?)")) {
                ps.setInt(1, idUser);
                ps.setInt(2, pid);
                ps.executeQuery();
            }

            // 4. Obtener roles — procedimiento almacenado
            List<String> roles = new ArrayList<>();
                try (PreparedStatement ps = con.prepareStatement("SELECT * FROM obtener_roles(?)")) {
                 ps.setInt(1, idUser);
                 try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    roles.add(rs.getString("nombre_rol"));
        }
    }
}

            return new Sesion(con, pid, usuario, roles);

        } catch (SQLException e) {
            System.err.println("Error en login: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }
}