import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lucky_money/data/models/obj_money.dart';
import 'package:lucky_money/data/models/transaction.dart';
import 'package:lucky_money/share/usd_separator_formatter.dart';

import '../bloc/money_bloc.dart';
import 'currency_page.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key, this.objMoney, this.transaction, this.pageName});

  final ObjMoney? objMoney;
  final Transaction? transaction;
  final String? pageName;

  static Future<void> show(
    BuildContext context, {
    ObjMoney? objMoney,
    Transaction? transaction,
    String? pageName,
  }) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => AddPage(
            objMoney: objMoney,
            transaction: transaction,
            pageName: pageName,
          ),
    );
  }

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  bool isGive = true;
  final TextEditingController _commentController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final DateFormat formatter = DateFormat('d MMM yyyy', 'en_US');
  DateTime selectedDate = DateTime.now();
  DateTime pickedDate = DateTime.now();
  String selectedCurrencyCode = 'VND';
  String selectedCurrencyFlag = '🇻🇳';

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.objMoney != null) {
      _nameController.text = widget.objMoney!.name;
      if (widget.objMoney!.transactions.isNotEmpty) {
        selectedCurrencyCode = widget.objMoney!.transactions.last.currency;
        selectedCurrencyFlag = selectedCurrencyCode == 'USD' ? '🇺🇸' : '🇻🇳';
      }
    }

    if (widget.transaction != null) {
      isGive = widget.transaction!.isGive;
      _amountController.text = widget.transaction!.amount.toString().replaceAll(RegExp(r'\.0$'), '');
      _commentController.text = widget.transaction!.comment;
      selectedDate = widget.transaction!.date;
      selectedCurrencyCode = widget.transaction!.currency;
      selectedCurrencyFlag = selectedCurrencyCode == 'USD' ? '🇺🇸' : '🇻🇳';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(key: _formKey, child: _buildAddPage(context));
  }

  Widget _buildAddPage(BuildContext context) {
    // Colors extracted/approximated from the image
    final Color surfaceColor = const Color(
      0xFF2C2C2E,
    ); // Slightly lighter for input groups
    final Color blueColor = const Color(0xFF0A84FF); // iOS-like blue

    final height = MediaQuery.sizeOf(context).height;

    return SizedBox(
      height: height * 0.9,
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
        child: Scaffold(
          backgroundColor: const Color(0xFF000000), // Main background
          appBar: AppBar(
            backgroundColor: const Color(0xFF1C1C1E),
            // elevation: 0,
            centerTitle: true,
            title: Text(
              (widget.pageName == null)
                  ? 'Add Transaction'
                  : widget.pageName ?? '',
              style: TextStyle(
                color: Colors.white,
                fontSize: 17, // Standard iOS title size
                fontWeight: FontWeight.w600,
              ),
            ),
            leading: TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: TextStyle(color: blueColor, fontSize: 16),
              ),
            ),
            leadingWidth: 100,
            actions: [
              TextButton(
                onPressed: () {
                  final name = _nameController.text;
                  final amountString = _amountController.text.replaceAll(',', '');
                  final amount = double.tryParse(amountString) ?? 0.0;
                  final comment = _commentController.text;
                  _formKey.currentState!.validate();

                  if (name.isNotEmpty && amount > 0) {
                    final item = Transaction(
                      amount: amount,
                      currency: selectedCurrencyCode,
                      date: selectedDate,
                      comment: comment,
                      isGive: isGive,
                    );

                    if (widget.pageName != null && widget.transaction != null) {
                      final updatedItem = widget.transaction!.copyWith(
                        amount: amount,
                        currency: selectedCurrencyCode,
                        date: selectedDate,
                        comment: comment,
                        isGive: isGive,
                      );
                      context.read<MoneyBloc>().add(
                        EditTransEvent(
                          widget.objMoney?.id ?? 0,
                          newName: name,
                          transaction: updatedItem,
                        ),
                      );
                    } else {
                      context.read<MoneyBloc>().add(
                        AddTransactionEvent(name: name, transactionItem: item),
                      );
                    }

                    Navigator.pop(context);
                  }
                },
                child: Text(
                  'Done',
                  style: TextStyle(
                    color: blueColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          body: ListView(
            children: [
              const SizedBox(height: 20),
              // GIVE / TAKE Toggle
              Center(
                child: Container(
                  width: 200,
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: surfaceColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => isGive = true),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            decoration: BoxDecoration(
                              color: isGive ? const Color(0xFF636366) : null,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Center(
                              child: Text(
                                '+ Give',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => isGive = false),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            decoration: BoxDecoration(
                              color: !isGive ? const Color(0xFF636366) : null,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Center(
                              child: Text(
                                'Take -',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // NAMES Section
              Container(
                color: surfaceColor,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _nameController,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Name',
                        hintStyle: TextStyle(color: Colors.grey),
                        //contentPadding: EdgeInsets.only(top: 8),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a name';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // AMOUNT Section
              Container(
                color: surfaceColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _amountController,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      // keyboardType: TextInputType.number,
                      inputFormatters: [
                        // FilteringTextInputFormatter
                        //     .digitsOnly, // chỉ cho phép số
                        // VndSeparatorInputFormatter(),
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^[0-9,]*\.?\d{0,2}'),
                        ), // Chỉ cho phép số, dấu phẩy và 1 dấu chấm thập phân (tối đa 2 chữ số)
                        UsdThousandsFormatter(),
                      ], // thêm dấu chấm],
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Amount',
                        hintStyle: TextStyle(color: Colors.grey),
                        //contentPadding: EdgeInsets.only(top: 8),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an amount';
                        }
                        return null;
                      },
                    ),
                    Divider(thickness: 0.2, height: 0.2, color: Colors.grey),
                    GestureDetector(
                      onTap:
                          widget.pageName != null
                              ? null
                              : () async {
                                final result =
                                    await Navigator.push<Map<String, String>>(
                                      context,
                                      CupertinoPageRoute(
                                        builder:
                                            (context) => CurrencyPage(
                                              selectedCurrencyCode:
                                                  selectedCurrencyCode,
                                            ),
                                      ),
                                    );

                                if (result != null) {
                                  setState(() {
                                    selectedCurrencyCode = result['code']!;
                                    selectedCurrencyFlag = result['flag']!;
                                  });
                                }
                              },
                      behavior: HitTestBehavior.opaque,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  selectedCurrencyFlag,
                                  style: const TextStyle(fontSize: 24),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  selectedCurrencyCode,
                                  style: TextStyle(
                                    color:
                                        widget.pageName == null
                                            ? Colors.white
                                            : Colors.blue.withOpacity(0.5),
                                    fontSize: 17,
                                  ),
                                ),
                              ],
                            ),
                            if (widget.pageName == null)
                              const Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white38,
                                size: 12,
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // DATE Section
              Container(
                color: surfaceColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: _selectDate(context),
              ),
              Divider(thickness: 0.2, height: 0.2, color: Colors.grey),
              // COMMENT Section
              Container(
                color: surfaceColor,
                height: 100,
                // Large area as in screenshot (inferred, though screenshot cuts off)
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: TextField(
                  controller: _commentController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Comment',
                  ),
                  maxLines: null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _selectDate(BuildContext context) {
    return InkWell(
      onTap: () async {
        final result = await showDialog<DateTime>(
          context: context,
          builder: (_) {
            return Dialog(
              backgroundColor: const Color(0xFF2C2C2E),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: SizedBox(
                height: 300,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context, selectedDate);
                        },
                        child: const Text('Done'),
                      ),
                    ),
                    Expanded(
                      child: CupertinoTheme(
                        data: const CupertinoThemeData(
                          brightness: Brightness.dark,
                          textTheme: CupertinoTextThemeData(
                            dateTimePickerTextStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        child: CupertinoDatePicker(
                          mode: CupertinoDatePickerMode.date,
                          initialDateTime: selectedDate,
                          minimumYear: 2000,
                          maximumYear: 2030,
                          onDateTimeChanged: (date) {
                            selectedDate = date;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );

        if (result != null) {
          setState(() {
            selectedDate = result;
          });
        }
      },
      child: Center(
        child: Text(
          formatter.format(selectedDate),
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
