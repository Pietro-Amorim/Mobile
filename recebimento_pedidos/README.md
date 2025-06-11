## Aplicativo de Recebimento de Pedidos (Simples)
- Este é um aplicativo Flutter para gerenciamento básico de pedidos, focado na demonstração de persistência de dados local usando SQLite.

 > Funcionalidades Principais
- Cadastro de Produtos: Adicione novos produtos com nome, descrição, preço e categoria.
- Menu de Produtos: Visualize os produtos disponíveis.
- Adicionar ao Carrinho: Selecione produtos e quantidades para adicionar ao pedido em andamento.
- Carrinho/Pedido: Visualize os itens do pedido atual, subtotal, total e finalize o pedido.
- Arquitetura do Projeto
O código está organizado em camadas para modularidade:

 > Estrutura
- lib/database/: Configuração e gerenciamento do banco de dados SQLite.
- lib/models/: Definição das classes de dados (Produto, Pedido, ItemPedido).
- lib/controllers/: Lógica de negócio e comunicação com o banco de dados.
- lib/screens/: Telas da interface do usuário.

 > Persistência de Dados
 - Utiliza SQLite (através da biblioteca sqflite) para armazenar dados localmente, garantindo que produtos e pedidos sejam persistidos ao reiniciar o aplicativo.

 > Como Rodar o Projeto
- Instalar Dependências: No diretório raiz do projeto.
- Executar: Com um emulador/dispositivo conectado, execute flutter run.

 > Tecnologias Utilizadas
- Flutter
- Dart
- SQLite (sqflite)

## Desenvolvedor: Pietro Amorim Fernandes