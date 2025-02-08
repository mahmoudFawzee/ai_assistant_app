import 'package:ai_assistant_app/logic/tasks/calender_cubit/calender_cubit.dart';
import 'package:ai_assistant_app/view/theme/color_manger.dart';
import 'package:ai_assistant_app/view/widgets/custom_day.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomCalender extends StatelessWidget {
  const CustomCalender({super.key});
  static DateTime? selectedDate;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: BlocBuilder<CalenderCubit, CalenderState>(        
        builder: (context, state) {
          if (state is GotWeekState) {
            
            final week = state.week;
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: ColorsManger.myMessageColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              child: Column(
                children: [
                  GestureDetector(
                    onHorizontalDragEnd: (details) {
                      if (details.primaryVelocity! < 0) {
                        context.read<CalenderCubit>().nextMonth();
                        return;
                      }
                      context.read<CalenderCubit>().preMonth();
                    },
                    child: SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              context.read<CalenderCubit>().preMonth();
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios_outlined,
                              size: 24,
                              color: ColorsManger.white,
                            ),
                          ),
                          Text(
                            '${week.year}/${(week.month).toString().padLeft(2, '0')}',
                            style: const TextStyle(
                              color: ColorsManger.white,
                              fontSize: 24,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              context.read<CalenderCubit>().nextMonth();
                            },
                            icon: const Icon(
                              Icons.arrow_forward_ios_outlined,
                              size: 24,
                              color: ColorsManger.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 50,
                    child: GestureDetector(
                      onHorizontalDragEnd: (details) {
                        if (details.primaryVelocity! < 0) {
                          context.read<CalenderCubit>().nextWeek();
                          return;
                        }
                        context.read<CalenderCubit>().preWeek();
                      },
                      child: ListView.builder(
                        itemCount: week.days.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final day = week.days[index];
                          return CustomDay(day: day);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
