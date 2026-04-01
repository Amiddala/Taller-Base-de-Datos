package com.mycompany.mavenproject1.Modelo;

import java.sql.*;

public class LoginController {

    private static final String URL  = "jdbc:postgresql://localhost:5432/mi_base";
    private static final String USER = "postgres";
    private static final String PASS = "tu_contraseña";

    public Sesion login(String usuario, String password) {
        String sql = "SELECT id_userN FROM \"UserN\" WHERE nombreN = ? AND passwordN = ?";

        try {
            // Abre la conexión y NO la cierra → la guarda en Sesion
            Connection con = DriverManager.getConnection(URL, USER, PASS);

            // Obtiene el PID
            int pid;
            try (Statement stmt = con.createStatement();
                 ResultSet rs   = stmt.executeQuery("SELECT pg_backend_pid()")) {
                rs.next();
                pid = rs.getInt(1);
            }

            // Verifica usuario y contraseña
            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setString(1, usuario);
                ps.setString(2, password);

                try (ResultSet rs = ps.executeQuery()) {
                    if (!rs.next()) {
                        con.close(); // credenciales incorrectas → cierra
                        return null;
                    }
                }
            }

            // ✅ Todo OK → devuelve sesión con conexión viva
            return new Sesion(con, pid, usuario);

        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }
}