import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final String label;
  final String hint;
  final IconData icon;
  final bool isPassword;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? errorText;
  final ValueChanged<String>? onChanged;

  const MyTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.icon,
    this.isPassword = false,
    this.controller,
    this.keyboardType,
    this.errorText,
    this.onChanged,
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool hide = true;

  OutlineInputBorder border(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: color),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget? suffix;
    if (widget.isPassword) {
      suffix = IconButton(
        icon: Icon(
          hide ? Icons.visibility_off : Icons.visibility,
          size: 18,
          color: const Color(0xFF7A5AF8),
        ),
        onPressed: () {
          setState(() {
            hide = !hide;
          });
        },
      );
    } else if (widget.errorText != null) {
      suffix =  Icon
        (Icons.error_outline, size: 16, color: Colors.red);
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.label,
              style:  TextStyle(fontSize: 12, color: Color(0xFF374151))),
           SizedBox(height: 6),
          TextField(
            controller: widget.controller,
            onChanged: widget.onChanged,
            keyboardType: widget.keyboardType,
            obscureText: widget.isPassword && hide,
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle:  TextStyle(fontSize: 12, color: Colors.grey),
              errorText: widget.errorText,
              errorStyle:  TextStyle(fontSize: 10, color: Colors.red),
              prefixIcon:
              Icon(widget.icon, size: 18, color: const Color(0xFF7A5AF8)),
              suffixIcon: suffix,
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
              border: border(const Color(0xFFD9D3F5)),
              enabledBorder: border(const Color(0xFFD9D3F5)),
              focusedBorder: border(const Color(0xFF7A5AF8)),
              errorBorder: border(Colors.red),
              focusedErrorBorder: border(Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}


class MySelectField extends StatelessWidget {
  final String label;
  final IconData icon;
  final String hint;
  final String? value;
  final VoidCallback? onTap;
  final bool showArrow;

  const MySelectField({
    super.key,
    required this.label,
    required this.icon,
    this.hint = '',
    this.value,
    this.onTap,
    this.showArrow = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style:  TextStyle(fontSize: 12, color: Color(0xFF374151))),
           SizedBox(height: 6),
          GestureDetector(
            onTap: onTap,
            child: Container(
              height: 46,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFD9D3F5)),
              ),
              child: Row(
                children: [
                  Icon(icon, size: 18, color: const Color(0xFF7A5AF8)),
                   SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      value ?? hint,
                      style: TextStyle(
                        fontSize: 12,
                        color: value == null ? Colors.grey : Colors.black,
                      ),
                    ),
                  ),
                  if (showArrow)
                     Icon(Icons.keyboard_arrow_down, color: Color(0xFF7A5AF8)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}