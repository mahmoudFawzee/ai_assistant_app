import 'package:flutter_test/flutter_test.dart';
import 'package:ai_assistant_app/data/services/tasks/tasks_service.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  // This only runs once before all tests
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });
  group('Tasks Testing', () {
    test('test uncompleted tasks', () async {
      // Arrange
      final instance = TasksService(); // Create an instance of your class

      // Act
      // final task = await instance.addTask(
      //   TaskSpec(
      //     date: DateTime.now(),
      //     done: false,
      //     time: TimeOfDay.now(),
      //     title: 'test',
      //     description: 'test description',
      //     category: CategoryEnum.education,
      //   ),
      // );
      final result = await instance.getSpecificDayUnCompletedTasks(
          DateTime.now()); // Call the function to be tested

      // Assert
      expect(result.length, 1);
    });
  });
}
