import 'package:flutter/material.dart';

class AddPage extends StatelessWidget {
  const AddPage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: Colors.black54, // nền mờ như modal
      body: Align(
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          height: height * 0.95,
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.grey.shade900,
                title: const Text('Fake Bottom Sheet'),
                leading: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Text('Cancel'),
                ),
              ),
              body: const Center(child: Text('Hello Page like BottomSheet')),
            ),
          ),
        ),
      ),
    );
  }
}
