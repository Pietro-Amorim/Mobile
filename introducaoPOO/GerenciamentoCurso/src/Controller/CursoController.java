package Controller;

import java.util.ArrayList;
import java.util.List;

import Model.Aluno;
import Model.Professor;

public class CursoController {
    //Atributos 
    private String nomeCurso;
    private Professor professor;
    private List<Aluno> alunosList;
    public CursoController(String nomeCurso, Professor professor) {
        this.nomeCurso = nomeCurso;
        this.professor = professor;
        this.alunosList = new ArrayList<>();
    }

    //Metodos
    //Construtor
    
    //Adicionar alunos(crud)
    public void adicionarAluno(Aluno Aluno){
        alunosList.add(Aluno);
    }

    //exibirinformacoes
    public void exibirinformacoesCurso(){
        System.out.println("Nom Curso: "+nomeCurso);
        System.out.println("Professor: "+professor.getNome());
        System.out.println("========================");
        int contador = 0;
        for (Aluno aluno : alunosList) {
            contador++;
            System.out.println(contador + ". " +aluno.getNome());
        }
        System.out.println("=========================");
    }
    //Lançar nota

    //ver status da turma

    
}
