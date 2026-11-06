import '../models/material_evento.dart';
import '../services/database_service.dart';

// Somente esta classe consulta ou altera os registros da tabela materiais.
class MaterialRepository {
  final DatabaseService service;
  MaterialRepository(this.service);

  // A leitura já está pronta: o app abre mostrando os quatro materiais iniciais.
  Future<List<MaterialEvento>> listar() async {
    final db = await service.database;
    final linhas = await db.query('materiais', orderBy: 'nome COLLATE NOCASE');
    return linhas.map((linha) => MaterialEvento.fromMap(linha)).toList();
  }

  Future<bool> existeNome(String nome, {int? ignorarId}) async {
    final db = await service.database;
    final normalizado = nome.trim().toLowerCase();
    final where = ignorarId != null
        ? 'nome_normalizado = ? AND id != ?'
        : 'nome_normalizado = ?';
    final args = ignorarId != null ? [normalizado, ignorarId] : [normalizado];
    final resultado = await db.query('materiais', where: where, whereArgs: args, limit: 1);
    return resultado.isNotEmpty;
  }

  Future<void> inserir(MaterialEvento material) async {
    final db = await service.database;
    await db.insert('materiais', material.toMap());
  }

  Future<void> atualizar(MaterialEvento material) async {
    final db = await service.database;
    await db.update('materiais', material.toMap(),
        where: 'id = ?', whereArgs: [material.id]);
  }

  Future<void> excluir(int id) async {
    final db = await service.database;
    await db.delete('materiais', where: 'id = ?', whereArgs: [id]);
  }
}
