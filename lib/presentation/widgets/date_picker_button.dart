import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTextField extends StatelessWidget {
  const DateTextField({
    required this.date,
    this.onDateSelected,
    super.key,
  });

  final DateTime date;
  final void Function(DateTime)? onDateSelected;

  @override
  Widget build(BuildContext context) {
    final dateFormatter = DateFormat.yMd();
    final borderRadius = BorderRadius.circular(8);

    return InkWell(
      onTap: () => _pickDate(context),
      borderRadius: borderRadius,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 6,
          vertical: 8,
        ),
        child: Row(
          children: [
            Text(
              dateFormatter.format(date),
              style: TextTheme.of(context).bodyLarge,
            ),
            const Spacer(),
            const Icon(Icons.calendar_today),
          ],
        ),
      ),
    );
  }

  Future<void> _pickDate(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      currentDate: this.date,
      firstDate: DateTime(0),
      lastDate: DateTime.now(),
    );

    if (date != null) {
      onDateSelected?.call(date);
    }
  }
}
