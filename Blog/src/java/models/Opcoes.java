/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package models;

/**
 *
 * @author matheus
 */

public class Opcoes implements java.io.Serializable {
    int id;
    String nome;
    String valor;
    String descricao;
    String rotulo;

    public Opcoes() {
    }

    public Opcoes(int id, String nome, String valor, String rotulo, String descricao) {
        this.id = id;
        this.nome = nome;
        this.valor = valor;
        this.rotulo = rotulo;
        this.descricao = descricao;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getValor() {
        return valor;
    }

    public void setValor(String valor) {
        this.valor = valor;
    }

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    public String getRotulo() {
        return rotulo;
    }

    public void setRotulo(String rotulo) {
        this.rotulo = rotulo;
    }
    
    
    
}
