package com.mycompany.mavenproject1.Modelo;
import java.sql.*;
import java.util.HashSet;
import java.util.Set;

public class LoginController {
    private static final String URL  = Config.get("db.url");
    private static final String USER = Config.get("db.user");
    private static final String PASS = Config.get("db.pass");

    public Sesion login(String usuario, String password) {
        String sqlLogin = "SELECT \"id_userN\" FROM \"UserN\" WHERE \"nombreN\" = ? AND \"passwordN\" = ?";
        String sqlInsertSesion = "INSERT INTO \"Sesion\" (\"id_userN\", \"pid\", \"inicio\") VALUES (?, ?, CURRENT_TIMESTAMP)";
        try {
            Connection con = DriverManager.getConnection(URL, USER, PASS);
            int pid;
            try (Statement stmt = con.createStatement();
                 ResultSet rs = stmt.executeQuery("SELECT pg_backend_pid()")) {
                rs.next();
                pid = rs.getInt(1);
            }

            int idUser;
            try (PreparedStatement ps = con.prepareStatement(sqlLogin)) {
                ps.setString(1, usuario);
                ps.setString(2, password);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        idUser = rs.getInt("id_userN");
                    } else {
                        con.close();
                        return null;
                    }
                }
            }

            try (PreparedStatement psInsert = con.prepareStatement(sqlInsertSesion)) {
                psInsert.setInt(1, idUser);
                psInsert.setInt(2, pid);
                psInsert.executeUpdate();
            }

            // ← NUEVO: buscar el id_usuario real en USUARIO
            int idUsuarioReal = idUser; // fallback
            String sqlUsuarioReal = "SELECT u.id_usuario FROM \"USUARIO\" u " +
                "JOIN \"UserN\" n ON LOWER(u.nombre) LIKE '%' || LOWER(n.\"nombreN\") || '%' " +
                "WHERE n.\"id_userN\" = ?";
            try (PreparedStatement ps2 = con.prepareStatement(sqlUsuarioReal)) {
                ps2.setInt(1, idUser);
                try (ResultSet rs2 = ps2.executeQuery()) {
                    if (rs2.next()) {
                        idUsuarioReal = rs2.getInt("id_usuario");
                    }
                }
            }

        return new Sesion(con, pid, usuario, idUsuarioReal, idUser); // ← ambos

        } catch (SQLException e) {
            System.err.println("Error en login: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

public Set<Integer> obtenerPantallas(int idUsuario, Connection conexion) {
        Set<Integer> iusPermitidas = new HashSet<>();
        String sql = "SELECT * FROM obtener_ius(?)";
        try (PreparedStatement ps = conexion.prepareStatement(sql)) {
            ps.setInt(1, idUsuario);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    iusPermitidas.add(rs.getInt("id_ui"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return iusPermitidas;
    }
}
