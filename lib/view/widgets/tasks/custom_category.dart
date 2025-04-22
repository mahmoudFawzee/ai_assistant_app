import 'package:ai_assistant_app/domain/models/tasks/category.dart';
import 'package:ai_assistant_app/view/theme/color_manger.dart';
import 'package:flutter/material.dart';

class CustomCategory extends StatelessWidget {
  const CustomCategory({
    super.key,
    required this.category,
    required this.onTap,
  });

  final Category category;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 100,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: CategoryProps.getCategoryColor(
          category.categoryProps.category,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        shape: BoxShape.rectangle,
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                height: 30,
                width: 30,
                category.categoryProps.imagePath,
                color: ColorsManger.white,
              ),
            ),
            const SizedBox(height: 10),
            RichText(
              maxLines: 2,
              textAlign: TextAlign.start,
              text: TextSpan(
                style: const TextStyle(
                  color: ColorsManger.white,
                  fontSize: 18,
                ),
                children: [
                  TextSpan(
                    text:
                        '${category.categoryProps.getCategoryTitle(context)}\n',
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  const WidgetSpan(child: SizedBox(height: 20)),
                  TextSpan(text: '${category.numberOfTasks}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
