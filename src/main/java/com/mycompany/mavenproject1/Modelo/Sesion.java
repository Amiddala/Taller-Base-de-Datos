package com.mycompany.mavenproject1.Modelo;

import java.sql.Connection;

public class Sesion {
    private Connection conexion;
    private int pid;
    private String usuario;

    public Sesion(Connection conexion, int pid, String usuario) {
        this.conexion = conexion;
        this.pid      = pid;
        this.usuario  = usuario;
    }

    public Connection getConexion() { return conexion; }
    public int getPid()             { return pid; }
    public String getUsuario()      { return usuario; }

    public void cerrar() {
        try {
            if (conexion != null && !conexion.isClosed()) {
                conexion.close();
                System.out.println("Sesión cerrada.");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}