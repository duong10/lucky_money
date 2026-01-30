import 'package:flutter/material.dart';

class SelectDateText extends StatefulWidget {
  const SelectDateText({super.key});

  @override
  State<SelectDateText> createState() => _SelectDateTextState();
}

class _SelectDateTextState extends State<SelectDateText> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: _selectedDate, // ngày mặc định
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),

        );

        if (pickedDate != null) {
          setState(() {
            _selectedDate = pickedDate;
          });
        }
      },
      child: Text(
        'Ngày: ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
        style: const TextStyle(
          fontSize: 16,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
