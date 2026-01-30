import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  static Future<void> show(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const AddPage(),
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
  final DateFormat formatter = DateFormat('dd/MM/yyyy');
  DateTime selectedDate = DateTime.now();
  DateTime pickedDate = DateTime.now();



  @override
  Widget build(BuildContext context) {
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
            title: const Text(
              'Add Debt',
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
                  // Handle Done
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
                    TextField(
                      controller: _nameController,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Name',
                        hintStyle: TextStyle(color: Colors.grey),
                        //contentPadding: EdgeInsets.only(top: 8),
                      ),
                      onSubmitted: (value) {
                        if (value.isNotEmpty) {
                          setState(() {
                            _nameController.clear();
                          });
                        }
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
                    TextField(
                      controller: _amountController,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Amount',
                        hintStyle: TextStyle(color: Colors.grey),
                        //contentPadding: EdgeInsets.only(top: 8),
                      ),
                      onSubmitted: (value) {
                        if (value.isNotEmpty) {
                          setState(() {
                            _nameController.clear();
                          });
                        }
                      },
                    ),
                    Divider(thickness: 0.2, height: 0.2, color: Colors.grey),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        Row(
                          children: const [
                            Text('🇻🇳', style: TextStyle(fontSize: 24)),
                            SizedBox(width: 8),
                            Text(
                              'VND',
                              style: TextStyle(color: Colors.white, fontSize: 17),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white38,
                          size: 12,
                        ),
                      ],
                    ),
                    const SizedBox(width: 16),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // DATE Section
              Container(
                color: surfaceColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
                child:  _selectDate(context),
              ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 16),child: Divider(thickness: 0.2, height: 0.2, color: Colors.grey)),
              // COMMENT Section
              Container(
                color: surfaceColor,
                height:
                    100, // Large area as in screenshot (inferred, though screenshot cuts off)
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

  Widget _selectDate(BuildContext context){
    return InkWell(
      onTap: () async {
        final DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: selectedDate, // ngày mặc định
          firstDate: DateTime(2000),
          lastDate: DateTime(2050),

        );
        if (pickedDate != null) {
          setState(() {
            selectedDate = pickedDate;
          });
        }
      },
      child: Text(
        formatter.format(selectedDate),
        style: const TextStyle(
          fontSize: 16,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }

}
