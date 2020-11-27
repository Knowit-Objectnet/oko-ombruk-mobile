import 'package:intl/intl.dart';
import 'package:ombruk/viewmodel/BaseViewModel.dart';

class DayScrollerViewModel extends BaseViewModel {
  int _currentWeekNumber;
  int get currentWeekNumber => _currentWeekNumber;
  DayScrollerViewModel() {
    _currentWeekNumber = calculateWeekNumber(0);
  }

  @override
  Future<void> init() {}

  int calculateWeekNumber(int index) {
    // Weekday calculation from https://en.wikipedia.org/wiki/ISO_week_date#Calculation
    DateTime newWeek = DateTime.now().add(Duration(days: 7 * index));
    int dayOfYear = int.parse(DateFormat('D').format(newWeek));
    return ((dayOfYear - newWeek.weekday + 10) / 7).floor();
  }

  DateTime calculateDate(int offset, int dayOfWeek) {
    DateTime now = DateTime.now();
    return now.add(Duration(days: (7 * offset) + dayOfWeek - now.weekday));
  }

  void onPageChanged(int index) {
    _currentWeekNumber = calculateWeekNumber(index);
    notifyListeners();
  }
}
