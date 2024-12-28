import 'package:ai_assistant_app/logic/local/navigation_cubit/navigation_cubit.dart';
import 'package:ai_assistant_app/view/resources/images_manger.dart';
import 'package:ai_assistant_app/view/screens/home/conversations_page.dart';
import 'package:ai_assistant_app/view/screens/home/todo_page.dart';
import 'package:ai_assistant_app/view/screens/home/weather_page.dart';
import 'package:ai_assistant_app/view/theme/color_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
        int? index;

        if (state is NavigationInitial) {
          index = state.index;
        } else if (state is MovedToPageState) {
          index = state.index;
        }
        return Scaffold(
          body: child,
          bottomNavigationBar: _bottomNavBar(
            items: [
              _bottomNavBarItem(
                context,
                imagePath: ImagesManger.todoImage,
                label: 'To Do',
                selected: index == 0,
                routeName: ToDoScreen.pageRoute,
                index: 0,
              ),
              _bottomNavBarItem(
                context,
                imagePath: ImagesManger.splashImage,
                label: 'assistant',
                selected: index == 1,
                routeName: ConversationsScreen.pageRoute,
                index: 1,
              ),
              _bottomNavBarItem(
                context,
                imagePath: ImagesManger.weatherImage,
                label: 'Weather',
                selected: index == 2,
                routeName: WeatherScreen.pageRoute,
                index: 2,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _bottomNavBarItem(
    BuildContext context, {
    required String imagePath,
    required String label,
    required bool selected,
    required int index,
    required String routeName,
  }) =>
      InkWell(
        onTap: () {
          context.read<NavigationCubit>().moveTo(index);
          context.go(routeName);
        },
        child: Container(
          alignment: Alignment.center,
          height: selected ? 45 : 56,
          width: selected ? 80 : 70,
          padding: EdgeInsets.only(top: selected ? 2 : 0),
          margin: EdgeInsets.only(top: selected ? 5 : 10),
          decoration: selected
              ? BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  border: Border.all(
                    color: ColorsManger.white,
                    width: 1.5,
                  ),
                  color: ColorsManger.aiMessageColor,
                )
              : null,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                imagePath,
                height: 35,
                width: 35,
              ),
              if (!selected)
                Text(
                  label,
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: ColorsManger.black,
                        fontSize: 12,
                      ),
                ),
            ],
          ),
        ),
      );

  Widget _bottomNavBar({
    required List<Widget> items,
  }) {
    return Container(
      height: 65,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: ColorsManger.myMessageColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items,
      ),
    );
  }
}
