package Model;

public abstract class Pessoa {
    //atributos (encapsulamento)
    private String nome;
    private String cpf;
    
    //Metodos
    //construtor
    public Pessoa(String nome, String cpf){
        this.nome = nome;
        this.cpf = cpf;
    }

    //getters & setters 
    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getCpf() {
        return cpf;
    }

    public void setCpf(String cpf) {
        this.cpf = cpf;
    }

    //Exibiir informações
    public void exibirinformacoes(){ 
        System.out.println("Nome: "+nome);
        System.out.println("CPF: "+cpf);
    }
       
}
