# json_shared_preferences

> Shared Preferences (Armazenamento interno do aplicativo)
    - Armazenamento chave -> Valor
        "config" -> "Texto" texto em formato de json

> O que é um texto em formato json ->
    [
        config:{
            "NomedoUsuario": "nome do usuário",
            "IdadedoUsuario": 25,
            "TemaEscuro": true,
        }
    ]

> dart -> linguagem de programação do Flutter não le json
    - converter => (json.decode => converte Texto:Json em Map:Dart)
                => (json.encode => converte Map:Dart em Texto:Json)
                