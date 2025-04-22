import 'package:ai_assistant_app/data/models/tasks/week.dart';
import 'package:ai_assistant_app/logic/tasks/day_decorator_cubit/day_decorator_cubit.dart';
import 'package:ai_assistant_app/view/theme/color_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomDay extends StatelessWidget {
  const CustomDay({
    super.key,
    required this.day,
    required this.onTap,
  });
  final void Function(DayPerWeek day) onTap;

  final DayPerWeek day;
  _handleOnTap() => onTap(day);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DayDecoratorCubit, DateTime>(
      builder: (context, stateDate) {
        final selected = day.isMatched(stateDate);
        final isToday = day.isMatched(DateTime.now());
        //todo change decoration of the selected day
        return InkWell(
          onTap: () {
            if (selected) return;
            context.read<DayDecoratorCubit>().selectDay(day.date);

            _handleOnTap();
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: 40,
            decoration: BoxDecoration(
                color: selected
                    ? ColorsManger.aiMessageColor
                    : ColorsManger.myMessageColor,
                borderRadius: BorderRadius.all(!isToday
                    ? const Radius.circular(5)
                    : const Radius.circular(2)),
                border: Border.all(
                  color: isToday ? ColorsManger.black : ColorsManger.white,
                  width: isToday ? 2 : 1,
                )),
            child: RichText(
              maxLines: 2,
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(
                  color: selected ? ColorsManger.black : ColorsManger.white,
                  fontSize: 16,
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
