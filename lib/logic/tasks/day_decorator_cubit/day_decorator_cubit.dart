import 'package:flutter_bloc/flutter_bloc.dart';

class DayDecoratorCubit extends Cubit<DateTime> {
  DayDecoratorCubit() : super(DateTime.now());
  void selectDay(DateTime date) => emit(date);  
}
