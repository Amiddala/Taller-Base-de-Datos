
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.mavenproject1.Vista;

/**
 *
 * @author candy
 */
public class Archivo {
    private String nombre;
    private long tamano;       
    private byte[] contenido;    
    private int idRepositorio;
    private int idTipo;
    private int idFormato;
    private int idUsuario;
    private int idEstado;

    public Archivo(String nombre, long tamano, byte[] contenido,
                   int idRepositorio, int idTipo, int idFormato,
                   int idUsuario, int idEstado) {
        this.nombre        = nombre;
        this.tamano        = tamano;
        this.contenido     = contenido;
        this.idRepositorio = idRepositorio;
        this.idTipo        = idTipo;
        this.idFormato     = idFormato;
        this.idUsuario     = idUsuario;
        this.idEstado      = idEstado;
    }

    public String getNombre()        { return nombre; }
    public long getTamano()          { return tamano; }
    public byte[] getContenido()     { return contenido; }
    public int getIdRepositorio()    { return idRepositorio; }
    public int getIdTipo()           { return idTipo; }
    public int getIdFormato()        { return idFormato; }
    public int getIdUsuario()        { return idUsuario; }
    public int getIdEstado()         { return idEstado; }
}
