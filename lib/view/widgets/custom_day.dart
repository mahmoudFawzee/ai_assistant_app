import 'package:ai_assistant_app/data/models/tasks/week.dart';
import 'package:ai_assistant_app/logic/tasks/day_decorator_cubit/day_decorator_cubit.dart';
import 'package:ai_assistant_app/logic/tasks/tasks_bloc/tasks_bloc.dart';
import 'package:ai_assistant_app/view/theme/color_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomDay extends StatelessWidget {
  const CustomDay({
    super.key,
    required this.day,
  });

  final DayPerWeek day;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DayDecoratorCubit, DateTime>(
      builder: (context, stateDate) {
        final selected = day.isMatched(stateDate);
        //todo change decoration of the selected day
        return InkWell(
          onTap: () {
            if (selected) return;
            context.read<DayDecoratorCubit>().selectDay(day.date);
            context.read<TasksBloc>().add(
                  GetSpecificDayTasksEvent(day.date),
                );
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            width: 40,
            decoration: const BoxDecoration(
              color: ColorsManger.aiMessageColor,
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: RichText(
              maxLines: 2,
              textAlign: TextAlign.center,
              text: TextSpan(
                style: const TextStyle(
                  color: ColorsManger.black,
                  fontSize: 18,
                ),
                children: [
                  TextSpan(text: '${day.getStringDay()}\n'),
                  TextSpan(text: day.getDayPerMonth()),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
