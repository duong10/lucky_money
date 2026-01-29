import 'package:flutter/material.dart';

class FakeBottomSheetPage extends StatelessWidget {
  const FakeBottomSheetPage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: Colors.black54, // nền mờ như modal
      body: Align(
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          height: height * 0.9,
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(12),
            ),
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.green,
                title: const Text('Fake Bottom Sheet'),
                leading: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              body: const Center(
                child: Text('Hello Page like BottomSheet'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

