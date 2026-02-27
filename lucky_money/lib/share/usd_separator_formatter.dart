import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class UsdThousandsFormatter extends TextInputFormatter {
  final NumberFormat _formatter = NumberFormat('#,##0', 'en_US');

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    // Remove all commas to get the raw number
    String cleaned = newValue.text.replaceAll(',', '');

    // Check if it's a valid number (allowing one decimal point)
    if (double.tryParse(cleaned) == null && cleaned != '.') {
      return oldValue;
    }

    // Handle case where user types just a dot
    if (cleaned == '.') {
      return TextEditingValue(
        text: '.',
        selection: const TextSelection.collapsed(offset: 1),
      );
    }

    // Split into integer and decimal parts
    List<String> parts = cleaned.split('.');
    String integerPart = parts[0];
    String? decimalPart = parts.length > 1 ? parts[1] : null;

    // Format the integer part with commas
    String formattedInteger = '';
    if (integerPart.isNotEmpty) {
      double? integerValue = double.tryParse(integerPart);
      if (integerValue != null) {
        formattedInteger = _formatter.format(integerValue);
      } else if (integerPart == '-') {
        formattedInteger = '-';
      }
    } else if (cleaned.startsWith('.')) {
      formattedInteger = '';
    }

    // Reconstruct the string
    String formatted = formattedInteger;
    if (cleaned.contains('.')) {
      formatted += '.$decimalPart';
    }

    // Calculate new cursor position
    int selectionIndex = formatted.length - (newValue.text.length - newValue.selection.end);
    if (selectionIndex < 0) selectionIndex = 0;
    if (selectionIndex > formatted.length) selectionIndex = formatted.length;

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
