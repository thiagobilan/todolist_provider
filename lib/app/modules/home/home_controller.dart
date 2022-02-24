import 'package:todolist_provider/app/core/notifier/default_change_notifier.dart';
import 'package:todolist_provider/app/models/task_enum.dart';
import 'package:todolist_provider/app/models/task_model.dart';
import 'package:todolist_provider/app/models/total_task_model.dart';
import 'package:todolist_provider/app/models/week_task_model.dart';
import 'package:todolist_provider/app/services/tasks/tasks_service.dart';

class HomeController extends DefaultChangeNotifier {
  final TasksService _tasksService;
  var filterSelected = TaskFilterEnum.week;
  TotalTaskModel? todayTotalTask;
  TotalTaskModel? tomorrowTotalTasks;
  TotalTaskModel? weekTotalTasks;
  List<TaskModel> allTasks = [];
  List<TaskModel> filteredTasks = [];
  DateTime? initialDateOfWeek;
  DateTime? selectedDay;
  bool showFinishingTasks = false;

  HomeController({required TasksService tasksService})
      : _tasksService = tasksService;

  Future<void> loadTotalTasks() async {
    final allTasks = await Future.wait([
      _tasksService.getToday(),
      _tasksService.getTomorrow(),
      _tasksService.getWeek()
    ]);
    final todayTasks = allTasks[0] as List<TaskModel>;
    final tomorrowTasks = allTasks[1] as List<TaskModel>;
    final weekTaskas = allTasks[2] as WeekTaskModel;
    todayTotalTask = TotalTaskModel(
      todayTasks.length,
      todayTasks.where((element) => element.finished).length,
    );
    tomorrowTotalTasks = TotalTaskModel(
      tomorrowTasks.length,
      tomorrowTasks.where((element) => element.finished).length,
    );
    weekTotalTasks = TotalTaskModel(
      weekTaskas.tasks.length,
      todayTasks.where((element) => element.finished).length,
    );
    notifyListeners();
  }

  Future<void> findTasks({required TaskFilterEnum filter}) async {
    filterSelected = filter;
    showLoading();
    notifyListeners();
    List<TaskModel> tasks;
    switch (filter) {
      case TaskFilterEnum.today:
        tasks = await _tasksService.getToday();
        break;
      case TaskFilterEnum.tomorrow:
        tasks = await _tasksService.getTomorrow();
        break;
      case TaskFilterEnum.week:
        final weekModel = await _tasksService.getWeek();
        initialDateOfWeek = weekModel.startDate;
        tasks = weekModel.tasks;
        break;
    }

    filteredTasks = tasks;
    allTasks = tasks;
    if (filter == TaskFilterEnum.week) {
      if (selectedDay != null) {
        filterByDay(selectedDay!);
      } else if (initialDateOfWeek != null) {
        filterByDay(initialDateOfWeek!);
      }
    } else {
      selectedDay = null;
    }

    if (!showFinishingTasks) {
      filteredTasks =
          filteredTasks.where((element) => !element.finished).toList();
    }
    hideLoading();
    notifyListeners();
  }

  void filterByDay(DateTime date) {
    selectedDay = date;
    filteredTasks =
        allTasks.where((element) => element.dateTime == date).toList();
    notifyListeners();
  }

  void refreshPage() async {
    await findTasks(filter: filterSelected);
    await loadTotalTasks();
    notifyListeners();
  }

  Future<void> chechOrUncheckTask(TaskModel task) async {
    showLoadingAndResetState();
    notifyListeners();
    final taskUpdate = task.copyWith(finished: !task.finished);
    await _tasksService.checkOrUncheckTask(taskUpdate);
    hideLoading();
    refreshPage();
  }

  void showOrHideFinishTask() {
    showFinishingTasks = !showFinishingTasks;
    refreshPage();
  }

  void deleteAll() async {
    await _tasksService.deleteAll();
  }

  Future<void> deleteTask(TaskModel task) async {
    await _tasksService.deleteTask(task);
  }
}
