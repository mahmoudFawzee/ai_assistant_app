import 'package:ai_assistant_app/data/services/tasks/date_time_formatter.dart';
import 'package:ai_assistant_app/logic/tasks/date_time_picker_cubit/date_time_picker_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomDateTimePickerButton extends StatelessWidget {
  const CustomDateTimePickerButton({
    super.key,
    required this.dateTime,
    required this.onDatePicked,
  });
  final DateTime? dateTime;
  final VoidCallback onDatePicked;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
      ),
      child: InkWell(
        onTap: () async {
          final pickedDate = await showDatePicker(
            context: context,
            firstDate: DateTime.now(),
            lastDate: DateTime(DateTime.now().year + 10),
          );
          TimeOfDay? pickedTime;
          if (context.mounted) {
            pickedTime = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            );
          }

          if (pickedDate == null) return;
          if (pickedTime == null) return;
          final date = DateTimeFormatter.createDateTime(
            date: pickedDate,
            time: pickedTime,
          );

          if (context.mounted) {
            context.read<DateTimePickerCubit>().pickDateTime(date);
          }
          onDatePicked();
        },
        child: Row(
          children: [
            Text(dateTime == null
                ? AppLocalizations.of(context)!.pickDate
                : DateTimeFormatter.dateTimeToString(dateTime!)),
            const Icon(Icons.date_range),
          ],
        ),
      ),
    );
  }
}
