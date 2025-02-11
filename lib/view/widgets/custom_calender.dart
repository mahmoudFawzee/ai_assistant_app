import 'package:ai_assistant_app/logic/tasks/calender_cubit/calender_cubit.dart';
import 'package:ai_assistant_app/view/theme/color_manger.dart';
import 'package:ai_assistant_app/view/widgets/custom_day.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomCalender extends StatefulWidget {
  const CustomCalender({super.key});

  @override
  State<CustomCalender> createState() => _CustomCalenderState();
}

class _CustomCalenderState extends State<CustomCalender>
    with TickerProviderStateMixin {
  bool goForward = true;
  late AnimationController _forwardController;

  late Animation<Offset> _forwardAnimation;

  late AnimationController _backwardController;

  late Animation<Offset> _backwardAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _forwardController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _backwardController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    // Define the forward animation
    _forwardAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0), // Start from the right edge
      end: const Offset(0.0, 0.0), // Move to the center
    ).animate(CurvedAnimation(
      parent: _forwardController,
      curve: Curves.easeInOut,
    ));
    // Define the forward animation
    _backwardAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0), // Start from the left edge
      end: const Offset(0.0, 0.0), // Move to the center
    ).animate(CurvedAnimation(
      parent: _backwardController,
      curve: Curves.easeInOut,
    ));

    // Start the animation
    _forwardController.forward();
  }

  @override
  void dispose() {
    _forwardController.dispose();
    _backwardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
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
                        goForward = true;
                        _forwardController.reset();
                        _forwardController.forward();
                        context.read<CalenderCubit>().nextMonth();

                        return;
                      }
                      goForward = false;
                      _backwardController.reset();
                      _backwardController.forward();
                      context.read<CalenderCubit>().preMonth();
                    },
                    child: SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: SlideTransition(
                              position: goForward
                                  ? _forwardAnimation
                                  : _backwardAnimation,
                              child: Text(
                                '${week.year}/${(week.month).toString().padLeft(2, '0')}',
                                style: const TextStyle(
                                  color: ColorsManger.white,
                                  fontSize: 24,
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                MonthArrow(
                                    icon: Icons.arrow_back_ios_outlined,
                                    alignIconToStart: false,
                                    onPressed: () {
                                      goForward = false;
                                      _backwardController.reset();
                                      _backwardController.forward();
                                      context.read<CalenderCubit>().preMonth();
                                    }),
                                const Expanded(
                                  flex: 3,
                                  child: SizedBox(
                                    width: 50,
                                  ),
                                ),
                                MonthArrow(
                                  alignIconToStart: true,
                                  icon: Icons.arrow_forward_ios_outlined,
                                  onPressed: () {
                                    goForward = true;
                                    _forwardController.reset();
                                    _forwardController.forward();
                                    context.read<CalenderCubit>().nextMonth();
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: GestureDetector(
                      onHorizontalDragEnd: (details) {
                        if (details.primaryVelocity! < 0) {
                          goForward = true;
                          _forwardController.reset();
                          _forwardController.forward();
                          context.read<CalenderCubit>().nextWeek();
                          return;
                        }
                        goForward = false;
                        _backwardController.reset();
                        _backwardController.forward();
                        context.read<CalenderCubit>().preWeek();
                      },
                      child: SlideTransition(
                        position:
                            goForward ? _forwardAnimation : _backwardAnimation,
                        child: Center(
                          child: ListView.builder(
                            itemCount: week.days.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final day = week.days[index];
                              return CustomDay(day: day);
                            },
                          ),
                        ),
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

class MonthArrow extends StatelessWidget {
  const MonthArrow({
    super.key,
    required this.icon,
    required this.alignIconToStart,
    required this.onPressed,
  });
  final IconData icon;
  final bool alignIconToStart;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Material(
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
        color: ColorsManger.myMessageColor,
        child: Row(
          mainAxisAlignment: alignIconToStart
              ? MainAxisAlignment.start
              : MainAxisAlignment.end,
          children: [
            Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: ColorsManger.myMessageColor,
                border: Border.all(
                  color: ColorsManger.aiMessageColor,
                ),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: onPressed,
                icon: Icon(
                  icon,
                  size: 24,
                  color: ColorsManger.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
