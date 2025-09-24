# CineFavorite - Formativa
Construir um Aplicativo do Zero - O CineFavorite permitirá criar uma conta e buscar filmes em uma API e montar uma galeria pessoal de filmes favoritos, com posters e notas

## Objetivos
- Criar uma galeria Personalizada por Usuario de filmes Favoritos
- Conectar com uma API (base de Dados) de filmes
- Permitir a Criação de contas para cada Usuário
- Listar Filmes por Palavra-Chave

## levantamento de Requistos do Projeto
- ### Funcionais 
    - Separar contas de usuário
    - Salvar filmes nos Favoritos

- ### não Funcionais

## Recursos do Projeto
- Flutter/Dart
- Firebase (Authentication/ FireStore Database)
- API TMDB
- Figma
- Vs Code
## Diagramas
- Demonstrar o Funcionamento das entidades do Sistema

1. ### Classes

- Usuario (User) : classe já modela pelo FirebaseAuth
        - email
        - password
        - UID
        - Login()
        - Create()
        - logout()

    - FilmeFavorito: Classe modelada pelo DEV
        - number:Id
        - String: Titulo
        - String Poster
        - double: Rating
        - adicionar()
        - remover()
        - listar()
        - updateNota()
        
```mermaid
classDiagram
    class User{
        +String uid
        +String email
        +String password
        +createUser()
        +login()
        +logout()
    }

    class FavoriteMovie{
        +String id
        +String title
        +String posterPath
        +double Rating
        +addFavorite()
        +removeFavorite()
        +updateFavorite()
        +readList()
    }

    User "1"--"1+" FavoriteMovie : "save"

```

2. ### Uso
    Ações que os Atores podem FAzer
    - User:
        - Registrar
        - Login
        - logout
        - Procurar Filmes API
        - SAlvar Filmes Favoritos
        - Dar Nota aos Filmes
        - Remover dos Favoritos

```mermaid
graph TD
    subgraph "Ações"
        uc1([Registro])
        uc2([Login])
        uc3([LogOut])
        uc4([Search Movie])
        uc5([Favorite Movie])
        uc6([Rating Movie])
        uc7([Remove Favorite Movie])
    end

    User([Usuário])

    user --> uc1
    user --> uc2
    user --> uc3
    user --> uc4
    user --> uc5
    user --> uc6
    user --> uc7

    uc1 --> uc2
    uc2 --> uc3
    uc2 --> uc4
    uc2 --> uc5
    uc2 --> uc6
    uc2 --> uc7

```

3. ### Fluxo
    Determina o caminho percorrido pelo autor para executar uma ação

    - Ação de Login

```mermaid

graph TD  

    A[Início] --> B[Login Usuário]
    B --> C[Inserir Email e Senha] 
    C --> D{Credenciais válidas?}
    D -- Sim --> E[Tela de Favoritos]
    D -- Não --> B


```

## Prototipagem

## Codificação