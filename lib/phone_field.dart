import 'package:flutter/material.dart';

class PhoneField extends StatefulWidget {
  final TextEditingController? controller;
  final String label;
  final String hint;
  final ValueChanged<String>? onChanged;
  final String? errorText;

  const PhoneField({
    super.key,
    this.controller,
    this.label = 'Phone Number',
    this.hint = '+62 0000 0000 0000',
    this.onChanged,
    this.errorText,
  });

  @override
  State<PhoneField> createState() => _PhoneFieldState();
}

class _PhoneFieldState extends State<PhoneField> {
  String countryCode = 'INA';

  @override
  Widget build(BuildContext context) {
    bool hasError = widget.errorText != null;

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.label,
              style: const TextStyle(fontSize: 12, color: Color(0xFF374151))),
          const SizedBox(height: 6),
          Container(
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: hasError ? Colors.red : const Color(0xFFD9D3F5),
              ),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: countryCode,
                      isDense: true,
                      icon: const Icon(Icons.keyboard_arrow_down,
                          size: 16, color: Color(0xFF7A5AF8)),
                      items: ['INA', 'PS', 'US'].map((code) {
                        return DropdownMenuItem(
                          value: code,
                          child: Text(code, style: const TextStyle(fontSize: 12)),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          countryCode = value!;
                        });
                      },
                    ),
                  ),
                ),
                Container(
                  width: 1,
                  height: 20,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  color: const Color(0xFFE5E1F5),
                ),
                Expanded(
                  child: TextField(
                    controller: widget.controller,
                    keyboardType: TextInputType.phone,
                    style: const TextStyle(fontSize: 13),
                    onChanged: widget.onChanged,
                    decoration: InputDecoration(
                      hintText: widget.hint,
                      hintStyle: const TextStyle(fontSize: 12, color: Colors.grey),
                      border: InputBorder.none,
                      isDense: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (hasError)
            Padding(
              padding: const EdgeInsets.only(top: 4, left: 12),
              child: Text(widget.errorText!,
                  style: const TextStyle(fontSize: 10, color: Colors.red)),
            ),
        ],
      ),
    );
  }
}