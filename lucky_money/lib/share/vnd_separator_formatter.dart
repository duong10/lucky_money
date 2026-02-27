import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class VndSeparatorInputFormatter extends TextInputFormatter {
  final NumberFormat _formatter = NumberFormat('#,###', 'vi_VN');

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    // Loại bỏ tất cả dấu chấm cũ để parse số nguyên
    String cleaned = newValue.text.replaceAll('.', '');

    // Chỉ cho phép số
    if (int.tryParse(cleaned) == null) {
      return oldValue;
    }

    // Format lại với dấu chấm
    final formatted = _formatter.format(int.parse(cleaned));

    // Giữ vị trí con trỏ (cursor) đúng chỗ
    int selectionIndex = newValue.selection.end;
    final lengthDifference = formatted.length - newValue.text.length;
    selectionIndex += lengthDifference;

    return newValue.copyWith(
      text: formatted,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
