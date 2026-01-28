import 'package:flutter/material.dart';

Widget itemCard() {
  return Card(
    //elevation: 1,
    color: Colors.black,
    // shape: RoundedRectangleBorder(,borderRadius: BorderRadius.circular(12)),
    child: InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        // navigate
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Task',
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
                Text(
                  '+đ0',
                  style: TextStyle(color: Colors.white38, fontSize: 18),
                ),
              ],
            ),
          ),
          Divider(height: 1, thickness: 1, color: Colors.grey),
        ],
      ),
    ),
  );
}
