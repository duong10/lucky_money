import 'package:flutter/material.dart';

class CurrencyPage extends StatelessWidget {
  const CurrencyPage({super.key, this.selectedCurrencyCode = 'VND'});

  final String selectedCurrencyCode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1C1C1E),
        leadingWidth: 120,
        leading: TextButton.icon(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xFF0A84FF),
            size: 20,
          ),
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
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: ListView(
        children: [const SizedBox(height: 20), _buildCurrencyGroup(context)],
      ),
    );
  }

  Widget _buildCurrencyGroup(BuildContext context) {
    final currencies = [
      {'flag': '🇻🇳', 'code': 'VND', 'name': 'Vietnamese đồng'},
      {'flag': '🇺🇸', 'code': 'USD', 'name': 'United States dollar'},
    ];

    return Container(
      color: Colors.black,
      child: Column(
        children: [
          Container(
            color: const Color(0xFF2C2C2E),
            child: Column(
              children:
                  currencies.asMap().entries.map((entry) {
                    final index = entry.key;
                    final item = entry.value;
                    final bool isSelected =
                        item['code'] == selectedCurrencyCode;
                    return Column(
                      children: [
                        ListTile(
                          onTap: () {
                            Navigator.pop(context, item);
                          },
                          leading: Text(
                            item['flag']!,
                            style: const TextStyle(fontSize: 32),
                          ),
                          title: Text(
                            item['code']!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                            ),
                          ),
                          subtitle: Text(
                            item['name']!,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                          trailing:
                              isSelected
                                  ? const Icon(
                                    Icons.check,
                                    color: Color(0xFF0A84FF),
                                  )
                                  : null,
                        ),
                        if (index != currencies.length - 1)
                          const Divider(
                            height: 0.5,
                            thickness: 0.5,
                            indent: 60,
                            color: Colors.grey,
                          ),
                      ],
                    );
                  }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
