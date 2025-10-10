import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Sidebar extends StatelessWidget {
  final Function(String) onPageSelected;
  final String selectedPage;
  final bool isDarkTheme;

  Sidebar({
    required this.onPageSelected,
    required this.selectedPage,
    required this.isDarkTheme,
  });

  final Map<String, String> _backgroundImages = {
    "Home": "assets/images/home_bg.jpg",
    "Deployments": "assets/images/deployment_bg.png",
    "Products": "assets/images/product_bg.png",
    "Contact": "assets/images/contact_bg.png",
  };

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final sidebarWidth = screenWidth * 0.20;

    return Container(
      width: sidebarWidth,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            _backgroundImages[selectedPage] ?? "assets/images/blegateway.png",
          ),
          fit: BoxFit.cover,
        ),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(3, 0)),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          color: isDarkTheme
              ? Colors.black.withOpacity(0.6)
              : Colors.white.withOpacity(0.5),
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
        ),
        child: _buildSidebarContent(context, sidebarWidth),
      ),
    );
  }

  Widget _buildSidebarContent(BuildContext context, double width) {
    return Column(
      children: [
        // Logo + Title
        Container(
          height: 200,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeInOut,
                padding: const EdgeInsets.all(8),
                child: Icon(
                  Icons.sensors,
                  size: 56,
                  color: isDarkTheme ? Colors.white : Colors.black87,
                ),
              ),
              const SizedBox(height: 10),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 500),
                style: TextStyle(
                  color: isDarkTheme ? Colors.white : Colors.black87,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
                child: const Text("CPS Lab"),
              ),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 500),
                style: TextStyle(
                  color: isDarkTheme ? Colors.white70 : Colors.black54,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                child: const Text("Cyber Physical Systems"),
              ),
              const SizedBox(height: 6),
              Text(
                "Lab powered by NM-ICPS",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: isDarkTheme
                      ? Colors.yellow.shade200
                      : Colors.deepPurple,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),

        Expanded(
          child: ListView(
            shrinkWrap: true,
            children: [
              _buildAnimatedMenuItem(context, "Home", Icons.home),
              _buildAnimatedMenuItem(context, "Deployments", Icons.people),
              _buildAnimatedMenuItem(context, "Products", Icons.shopping_bag),
              _buildAnimatedMenuItem(context, "Contact", Icons.contact_mail),
            ],
          ),
        ),

        // Bottom Buttons
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildBottomButton(
                "Download Config",
                Icons.download,
                "https://iot-serial-communication-app.s3.us-east-1.amazonaws.com/IOT+Serial+Monitor+Setup+1.0.0.exe",
              ),

              _buildBottomButton(
                "Download BLE App",
                Icons.phone_android,
                "https://play.google.com/store/apps/details?id=com.blesense.app",
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Animated Menu Item
  Widget _buildAnimatedMenuItem(
    BuildContext context,
    String title,
    IconData icon,
  ) {
    final bool isSelected = selectedPage == title;
    Color itemColor = isSelected
        ? (isDarkTheme ? Colors.yellow : const Color.fromARGB(255, 1, 81, 146))
        : (isDarkTheme ? Colors.white : Colors.black87);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
      child: InkWell(
        onTap: () {
          onPageSelected(title);

      
          if (Scaffold.of(context).isDrawerOpen) {
            Navigator.of(context).pop();
          }
        },
        borderRadius: BorderRadius.circular(12),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: isSelected
                ? (isDarkTheme
                      ? Colors.yellow.withOpacity(0.2)
                      : const Color.fromARGB(255, 3, 142, 255).withOpacity(0.2))
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(icon, color: itemColor),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  color: itemColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomButton(String tooltip, IconData icon, String url) {
    return IconButton(
      onPressed: () async {
        Uri uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri);
        } else {
          print("Could not launch $url");
        }
      },
      icon: Icon(icon, color: isDarkTheme ? Colors.white : Colors.black87),
      tooltip: tooltip,
      iconSize: 28,
    );
  }
}
