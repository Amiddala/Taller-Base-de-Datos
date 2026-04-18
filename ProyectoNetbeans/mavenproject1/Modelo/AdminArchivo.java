/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.mavenproject1.Modelo;

import com.mycompany.mavenproject1.Vista.Archivo;

/**
 *
 * @author candy
 */
public class AdminArchivo {
    private java.sql.Connection conexion;

    public AdminArchivo(java.sql.Connection conexion) {
        this.conexion = conexion;
    }

    public boolean registrarArchivo(Archivo archivo) {
        String sql = "CALL public.insertar_archivo(?,?,?,?,?,?,?,?)";
        boolean respuesta = false;
        try (java.sql.PreparedStatement ps = conexion.prepareStatement(sql)) {
            ps.setString(1, archivo.getNombre());
            ps.setLong(2, archivo.getTamano());
            ps.setBytes(3, archivo.getContenido());
            ps.setInt(4, archivo.getIdRepositorio());
            ps.setInt(5, archivo.getIdTipo());
            ps.setInt(6, archivo.getIdFormato());
            ps.setInt(7, archivo.getIdUsuario());
            ps.setInt(8, archivo.getIdEstado());
            ps.execute();
            respuesta = true;
        } catch (java.sql.SQLException e) {
            javax.swing.JOptionPane.showMessageDialog(null,
                "SQL Error: " + e.getMessage());
            e.printStackTrace();
        }
        return respuesta;
    }
    
    
    
    
    
    
    
    
}
