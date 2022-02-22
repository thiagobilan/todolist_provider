import 'package:todolist_provider/app/core/database/sqlite_connection_factory.dart';
import 'package:todolist_provider/app/repositories/user/tasks/tasks_repository.dart';

class TasksRepositoryImpl extends TasksRepository {
  final SqliteConnectionFactory _sqliteConnectionFactory;
  TasksRepositoryImpl({
    required SqliteConnectionFactory sqliteConnectionFactory,
  }) : _sqliteConnectionFactory = sqliteConnectionFactory;

  @override
  Future<void> save(DateTime date, String description) async {
    final conn = await _sqliteConnectionFactory.openConnection();
    await conn.insert('todo', {
      'id': null,
      'descricao': description,
      'data_hora': date.toIso8601String(),
      'finalizado': 0
    });
  }
}