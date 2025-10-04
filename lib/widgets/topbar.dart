import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  final VoidCallback onToggleTheme;
  final bool isDarkTheme;

  TopBar({
    required this.onToggleTheme,
    required this.isDarkTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      height: 60,
      color: Colors.transparent, // fully transparent
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end, // right aligned
        children: [
          IconButton(
            icon: Icon(
              isDarkTheme ? Icons.dark_mode : Icons.light_mode,
              color: isDarkTheme ? Colors.white : Colors.black,
            ),
            onPressed: onToggleTheme,
          ),
        ],
      ),
    );
  }
}
