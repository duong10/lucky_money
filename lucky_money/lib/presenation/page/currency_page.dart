import 'package:flutter/material.dart';

class CurrencyPage extends StatelessWidget {
  const CurrencyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1C1C1E),
        leadingWidth: 120, // Give enough space for "< Add Debt"
        leading: TextButton.icon(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios,
              color: Color(0xFF0A84FF), size: 20),
          label: const Text(
            'Add Debt',
            style: TextStyle(color: Color(0xFF0A84FF), fontSize: 17),
          ),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.only(left: 8),
            alignment: Alignment.centerLeft,
            minimumSize: Size.zero, 
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
        centerTitle: true,
        title: const Text(
          'Currencies',
          style: TextStyle(
              color: Colors.white, fontSize: 17, fontWeight: FontWeight.w600),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              'Edit',
              style: TextStyle(color: Color(0xFF0A84FF), fontSize: 17),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          const SizedBox(height: 20),
          _buildCurrencyGroup(),
          const SizedBox(height: 20),
          _buildAddCurrencySection(),
        ],
      ),
    );
  }

  Widget _buildCurrencyGroup() {
    final currencies = [
      {'flag': '🇻🇳', 'code': 'VND', 'name': 'Vietnamese đồng'},
      {'flag': '🇺🇸', 'code': 'USD', 'name': 'United States dollar'},
      {'flag': '🇪🇺', 'code': 'EUR', 'name': 'Euro'},
      {'flag': '🇧🇭', 'code': 'BHD', 'name': 'Bahraini dinar'},
      {'flag': '🇦🇲', 'code': 'AMD', 'name': 'Armenian dram'},
    ];

    return Container(
      color: Colors.black, 
      child: Column(
        children: [
          Container(
            color: const Color(0xFF2C2C2E),
            child: Column(
              children: currencies.asMap().entries.map((entry) {
                final index = entry.key;
                final item = entry.value;
                return Column(
                  children: [
                    ListTile(
                      leading: Text(item['flag']!,
                          style: const TextStyle(fontSize: 32)), 
                      title: Text(item['code']!,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 17)),
                      subtitle: Text(item['name']!,
                          style: const TextStyle(
                              color: Colors.grey, fontSize: 14)),
                    ),
                    if (index != currencies.length - 1)
                      const Divider(
                          height: 0.5,
                          thickness: 0.5,
                          indent: 60,
                          color: Colors.grey),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddCurrencySection() {
    return Container(
      color: const Color(0xFF2C2C2E),
      child: ListTile(
        title: const Text('Add currency',
            style: TextStyle(color: Colors.white, fontSize: 17)),
        trailing:
            const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
        onTap: () {
          // Handle add currency
        },
      ),
    );
  }
}
