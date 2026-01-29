import 'package:flutter/material.dart';

class itemCard extends StatelessWidget {
  const itemCard({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      //elevation: 1,
      color: Colors.black,
      // shape: RoundedRectangleBorder(,borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        //borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Task',
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                  Row(
                    children: [
                      Text(
                        '+đ0',
                        style: TextStyle(color: Colors.white38, fontSize: 18),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white38,
                        size: 12,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(height: 0.2, thickness: 0.2, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
