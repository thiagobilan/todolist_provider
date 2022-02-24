import 'package:todolist_provider/app/models/task_model.dart';
import 'package:todolist_provider/app/models/week_task_model.dart';
import 'package:todolist_provider/app/repositories/user/tasks/tasks_repository.dart';
import 'package:todolist_provider/app/services/tasks/tasks_service.dart';

class TasksServiceImpl extends TasksService {
  final TasksRepository _tasksRepository;

  TasksServiceImpl({required TasksRepository tasksRepository})
      : _tasksRepository = tasksRepository;
  @override
  Future<void> save(DateTime date, String description) =>
      _tasksRepository.save(date, description);

  @override
  Future<List<TaskModel>> getToday() {
    return _tasksRepository.findByPeriod(DateTime.now(), DateTime.now());
  }

  @override
  Future<List<TaskModel>> getTomorrow() {
    return _tasksRepository.findByPeriod(
        DateTime.now().add(const Duration(days: 1)),
        DateTime.now().add(const Duration(days: 1)));
  }

  @override
  Future<WeekTaskModel> getWeek() async {
    final today = DateTime.now();
    var startFilter = DateTime(today.year, today.month, today.day, 0, 0, 0);
    DateTime endFilter;
    if (startFilter.weekday != DateTime.monday) {
      startFilter =
          startFilter.subtract(Duration(days: startFilter.weekday - 1));
    }
    endFilter = startFilter.add(Duration(days: 7));
    final tasks = await _tasksRepository.findByPeriod(startFilter, endFilter);
    return WeekTaskModel(
        startDate: startFilter, endDate: endFilter, tasks: tasks);
  }

  @override
  Future<void> checkOrUncheckTask(TaskModel task) async {
    return await _tasksRepository.checkOrUncheckTask(task);
  }

  @override
  Future<void> deleteAll() async {
    return await _tasksRepository.deleteAll();
  }

  @override
  Future<void> deleteTask(TaskModel task) async {
    return await _tasksRepository.deleteTask(task);
  }
}
