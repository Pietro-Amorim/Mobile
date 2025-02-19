package Model;

public class Aluno extends Pessoa{
    //Atributos (encapsulamento)
    private String matricula;
    private double nota;
    public Aluno(String nome, String cpf, String matricula) {
        super(nome, cpf);
        this.matricula = matricula;

    //Metodos
    //Construtor
    

    // Getters & setters
    }
    public String getMatricula() {
        return matricula;
    }
    public void setMatricula(String matricula) {
        this.matricula = matricula;
    }
    public double getNota() {
        return nota;
    }
    public void setNota(double nota) {
        this.nota = nota;
    }
    
    //sobreescritas exibirinformações
@Override
public void exibirinformacoes(){
    super.exibirinformacoes();
    System.out.println("Matricula: "+matricula);
    System.out.println("nota: "+nota);
}
    
}
