package models;
// Generated 05/09/2018 19:48:07 by Hibernate Tools 4.3.1


import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * Posts generated by hbm2java
 */

public class Posts  implements java.io.Serializable {


     private Integer id;
     private Usuarios usuarios;
     private int idAutor;
     private String linkPermanente;
     private Date dataCriacaoPost;
     private Date dataModificacaoPost;
     private String conteudoPost;
     private String tituloPost;
     private String sumarioPost;
     private String imagemMiniatura;
     private char publicado;
     private int visualizacoes;
     private Set<Comentarios> listaDeComentarios = new HashSet<Comentarios>(0);
     private Set<Tags> tagsDoPost = new HashSet<Tags>(0);

    public Posts() {
    }

    public Posts(int idAutor, String linkPermanente) {
        this.idAutor = idAutor;
        this.linkPermanente = linkPermanente;
    }
    public Posts(Usuarios usuarios, int idAutor, String linkPermanente, 
            Date dataCriacaoPost, Date dataModificacaoPost, String conteudoPost, 
            String tituloPost, String sumarioPost, String imagemMiniatura, 
            int visualizacoes, Set<Comentarios> listaDeComentarios, Set<Tags> tagsDoPost,
            char publicado) {
       this.usuarios = usuarios;
       this.idAutor = idAutor;
       this.linkPermanente = linkPermanente;
       this.dataCriacaoPost = dataCriacaoPost;
       this.dataModificacaoPost = dataModificacaoPost;
       this.conteudoPost = conteudoPost;
       this.tituloPost = tituloPost;
       this.sumarioPost = sumarioPost;
       this.imagemMiniatura = imagemMiniatura;
       this.visualizacoes = visualizacoes;
       this.listaDeComentarios = listaDeComentarios;
       this.tagsDoPost = tagsDoPost;
       this.publicado = publicado;
    }
   
    public Integer getId() {
        return this.id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }
    public Usuarios getUsuarios() {
        return this.usuarios;
    }
    
    public void setUsuarios(Usuarios usuarios) {
        this.usuarios = usuarios;
    }
    public int getIdAutor() {
        return this.idAutor;
    }
    
    public void setIdAutor(int idAutor) {
        this.idAutor = idAutor;
    }
    public String getLinkPermanente() {
        return this.linkPermanente;
    }
    
    public void setLinkPermanente(String linkPermanente) {
        this.linkPermanente = linkPermanente;
    }
    public Date getDataCriacaoPost() {
        return this.dataCriacaoPost;
    }
    
    public void setDataCriacaoPost(Date dataCriacaoPost) {
        this.dataCriacaoPost = dataCriacaoPost;
    }
    public Date getDataModificacaoPost() {
        return this.dataModificacaoPost;
    }
    
    public void setDataModificacaoPost(Date dataModificacaoPost) {
        this.dataModificacaoPost = dataModificacaoPost;
    }
    public String getConteudoPost() {
        return this.conteudoPost;
    }
    
    public void setConteudoPost(String conteudoPost) {
        this.conteudoPost = conteudoPost;
    }
    public String getTituloPost() {
        return this.tituloPost;
    }
    
    public void setTituloPost(String tituloPost) {
        this.tituloPost = tituloPost;
    }
    public String getSumarioPost() {
        return this.sumarioPost;
    }
    
    public void setSumarioPost(String sumarioPost) {
        this.sumarioPost = sumarioPost;
    }
    public String getImagemMiniatura() {
        return this.imagemMiniatura;
    }
    
    public void setImagemMiniatura(String imagemMiniatura) {
        this.imagemMiniatura = imagemMiniatura;
    }
    public int getVisualizacoes() {
        return this.visualizacoes;
    }
    
    public void setVisualizacoes(int visualizacoes) {
        this.visualizacoes = visualizacoes;
    }
    
    public Set<Comentarios> getListaDeComentarios() {
        return this.listaDeComentarios;
    }
    
    public void setListaDeComentarios(Set<Comentarios> listaDeComentarios) {
        this.listaDeComentarios = listaDeComentarios;
    }
    public Set<Tags> getTagsDoPost() {
        return this.tagsDoPost;
    }
    
    public void setTagsDoPost(Set<Tags> tagsDoPost) {
        this.tagsDoPost = tagsDoPost;
    }

    public char getPublicado() {
        return publicado;
    }

    public void setPublicado(char publicado) {
        this.publicado = publicado;
    }

}

