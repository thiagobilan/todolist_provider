import 'package:todolist_provider/app/repositories/user/tasks/tasks_repository.dart';
import 'package:todolist_provider/app/services/tasks/tasks_service.dart';

class TasksServiceImpl extends TasksService {
  final TasksRepository _tasksRepository;

  TasksServiceImpl({required TasksRepository tasksRepository})
      : _tasksRepository = tasksRepository;
  @override
  Future<void> save(DateTime date, String description) =>
      _tasksRepository.save(date, description);
}
