import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/deployment_page.dart';
import 'pages/products_page.dart';
import 'pages/contact_page.dart';
import 'widgets/sidebar.dart';
import 'widgets/topbar.dart';

void main() {
  runApp(CpsLab());
}

class CpsLab extends StatefulWidget {
  const CpsLab({super.key});

  @override
  CpsLabState createState() => CpsLabState();
}

class CpsLabState extends State<CpsLab> {
  Widget _selectedPage = HomePage();
  bool _isDarkTheme = false;
  String _currentPageName = "Home";

  void _onPageSelected(String page) {
    setState(() {
      _currentPageName = page;
      switch (page) {
        case 'Home':
          _selectedPage = HomePage();
          break;
        case 'Deployments':
          _selectedPage = DeploymentPage();
          break;
        case 'Products':
          _selectedPage = ProductsPage();
          break;
        case 'Contact':
          _selectedPage = ContactPage();
          break;
      }
    });
  }

  void _toggleTheme() {
    setState(() {
      _isDarkTheme = !_isDarkTheme;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _isDarkTheme ? ThemeData.dark() : ThemeData.light(),
      title: "CPS Lab Website",
      home: LayoutBuilder(
        builder: (context, constraints) {
          bool isMobile = constraints.maxWidth < 900;

          return Scaffold(
            appBar: isMobile
                ? AppBar(
                    // ✅ Transparent AppBar
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    iconTheme: IconThemeData(
                      color: _isDarkTheme ? Colors.white : Colors.black87,
                    ),
                    actions: [
                      IconButton(
                        icon: Icon(
                          _isDarkTheme ? Icons.light_mode : Icons.dark_mode,
                        ),
                        onPressed: _toggleTheme,
                      ),
                    ],
                  )
                : null,

            drawer: isMobile
                ? SizedBox(
                    width: MediaQuery.of(context).size.width * 0.75 > 300
                        ? 300
                        : MediaQuery.of(context).size.width * 0.75,
                    child: Sidebar(
                      onPageSelected: _onPageSelected,
                      selectedPage: _currentPageName,
                      isDarkTheme: _isDarkTheme,
                    ),
                  )
                : null,

            body: Row(
              children: [
                if (!isMobile)
                  Sidebar(
                    onPageSelected: _onPageSelected,
                    selectedPage: _currentPageName,
                    isDarkTheme: _isDarkTheme,
                  ),

                Expanded(
                  child: Column(
                    children: [
                      if (!isMobile)
                        TopBar(
                          onToggleTheme: _toggleTheme,
                          isDarkTheme: _isDarkTheme,
                        ),
                      Expanded(child: _selectedPage),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
