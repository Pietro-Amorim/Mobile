// lib/database/app_database.dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AppDatabase {
  static final AppDatabase _instance = AppDatabase._internal();
  static Database? _database;

  factory AppDatabase() {
    return _instance;
  }

  AppDatabase._internal();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'pedidos_app.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // Criar a tabela de Produtos
        await db.execute('''
          CREATE TABLE produtos(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nome TEXT,
            descricao TEXT,
            preco REAL,
            categoria TEXT
          )
        ''');

        // Criar a tabela de Pedidos
        await db.execute('''
          CREATE TABLE pedidos(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            data_pedido TEXT,
            status TEXT DEFAULT 'Em Andamento',
            valor_total REAL DEFAULT 0.0
          )
        ''');

        // Criar a tabela de Itens de Pedido (para o carrinho)
        await db.execute('''
          CREATE TABLE itens_pedido(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            pedido_id INTEGER,
            produto_id INTEGER,
            quantidade INTEGER,
            preco_unitario REAL,
            subtotal REAL,
            FOREIGN KEY (pedido_id) REFERENCES pedidos(id) ON DELETE CASCADE,
            FOREIGN KEY (produto_id) REFERENCES produtos(id) ON DELETE CASCADE
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) {
        // Se precisar de upgrades de versão no futuro
      },
    );
  }
}