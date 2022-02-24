class TotalTaskModel {
  final int totalTasks;
  final int totalTasksFinish;

  TotalTaskModel(this.totalTasks, this.totalTasksFinish);

  int get taskNotFinished {
    var total = totalTasks - totalTasksFinish;
    if (total < 0) {
      return 0;
    }
    return total;
  }
}
