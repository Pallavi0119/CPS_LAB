import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final Function(String?) onLogin;
  const LoginPage({super.key, required this.onLogin});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  bool isLogin = true;
  bool _isPasswordObscured = true;
  bool _isConfirmPasswordObscured = true;
  bool _isLoading = false;
  bool _isDarkMode = false;

  late AnimationController _formController;
  late AnimationController _pageLoadController;

  late Animation<double> _pageFadeAnimation;
  late Animation<Offset> _pageSlideAnimation;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  String? emailError;
  String? passwordError;
  String? confirmPasswordError;

  @override
  void initState() {
    super.initState();

    _formController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 400));

    _pageLoadController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 800));

    _pageFadeAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _pageLoadController, curve: Curves.easeOut));

    _pageSlideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero)
            .animate(CurvedAnimation(parent: _pageLoadController, curve: Curves.easeOutCubic));

    _pageLoadController.forward();
  }

  @override
  void dispose() {
    _formController.dispose();
    _pageLoadController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void toggleMode() {
    setState(() {
      isLogin = !isLogin;
      emailError = null;
      passwordError = null;
      confirmPasswordError = null;
      if (isLogin) {
        _formController.reverse();
      } else {
        _formController.forward();
      }
    });
  }

  
  bool validateEmail() {
    final email = emailController.text.trim();
    if (email.isEmpty) {
      emailError = "Email cannot be empty";
      return false;
    }
    final regex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
    if (!regex.hasMatch(email)) {
      emailError = "Invalid email format";
      return false;
    }
    emailError = null;
    return true;
  }

  bool validatePassword({bool checkConfirm = false}) {
    final password = passwordController.text.trim();
    if (password.isEmpty) {
      passwordError = "Password cannot be empty";
      return false;
    }
    final regex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$&*~]).{8,}$');
    if (!regex.hasMatch(password)) {
      passwordError =
          "Password must be 8+ chars, include uppercase, lowercase, number & special char";
      return false;
    }
    passwordError = null;

    if (checkConfirm && password != confirmPasswordController.text.trim()) {
      confirmPasswordError = "Passwords do not match";
      return false;
    }
    confirmPasswordError = null;
    return true;
  }

  Future<void> login() async {
    if (!validateEmail() || !validatePassword()) {
      setState(() {});
      return;
    }

    setState(() => _isLoading = true);
    try {
      final result = await Amplify.Auth.signIn(
        username: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (result.isSignedIn) {
        widget.onLogin(emailController.text.trim());
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Login successful!")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Login not complete!")),
        );
      }
    } on AuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login failed: ${e.message}")),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> signUp() async {
    if (!validateEmail() || !validatePassword(checkConfirm: true)) {
      setState(() {});
      return;
    }

    setState(() => _isLoading = true);

    try {
      final result = await Amplify.Auth.signUp(
        username: emailController.text.trim(),
        password: passwordController.text.trim(),
        options: CognitoSignUpOptions(
          userAttributes: {CognitoUserAttributeKey.email: emailController.text.trim()},
        ),
      );

      if (result.isSignUpComplete) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Signup successful! Logging in...")),
        );
        await login();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Signup incomplete (verification required).")),
        );
      }
    } on AuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Signup failed: ${e.message}")),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _showForgotPasswordDialog() async {
    final emailController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Reset Password"),
        content: TextField(
          controller: emailController,
          decoration: const InputDecoration(
            labelText: "Enter your registered email",
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () async {
              final email = emailController.text.trim();
              if (email.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Please enter your email")),
                );
                return;
              }

              Navigator.pop(context);
              try {
                await Amplify.Auth.resetPassword(username: email);
                _showConfirmResetDialog(email);
              } on AuthException catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Error: ${e.message}")),
                );
              }
            },
            child: const Text("Send Code"),
          ),
        ],
      ),
    );
  }

  Future<void> _showConfirmResetDialog(String email) async {
    final codeController = TextEditingController();
    final newPasswordController = TextEditingController();
    final parentContext = context;

    await showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text("Enter Code & New Password"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: codeController,
              decoration: const InputDecoration(
                labelText: "Verification Code",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: newPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "New Password",
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () async {
              final code = codeController.text.trim();
              final newPassword = newPasswordController.text.trim();

              if (code.isEmpty || newPassword.isEmpty) {
                ScaffoldMessenger.of(parentContext).showSnackBar(
                  const SnackBar(content: Text("Please enter both code and new password")),
                );
                return;
              }

              Navigator.pop(dialogContext);

              try {
                await Amplify.Auth.confirmResetPassword(
                  username: email,
                  newPassword: newPassword,
                  confirmationCode: code,
                );

                ScaffoldMessenger.of(parentContext).showSnackBar(
                  const SnackBar(
                    content: Text("Password updated successfully! Please log in."),
                    backgroundColor: Colors.green,
                    behavior: SnackBarBehavior.floating,
                  ),
                );

                if (!isLogin) {
                  setState(() {
                    isLogin = true;
                    _formController.reverse();
                  });
                }
              } on AuthException catch (e) {
                ScaffoldMessenger.of(parentContext).showSnackBar(
                  SnackBar(content: Text("Error: ${e.message}")),
                );
              }
            },
            child: const Text("Confirm"),
          ),
        ],
      ),
    );
  }

  void continueAsGuest() => widget.onLogin("Guest");

  @override
  Widget build(BuildContext context) {
  
    final lightTheme = ThemeData.from(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue, brightness: Brightness.light),
    );
    final darkTheme = ThemeData.from(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple, brightness: Brightness.dark),
    );

    final theme = _isDarkMode ? darkTheme : lightTheme;
    final colorScheme = theme.colorScheme;

    return AnimatedTheme(
      data: theme,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body: Stack(
          children: [
            Center(
              child: FadeTransition(
                opacity: _pageFadeAnimation,
                child: SlideTransition(
                  position: _pageSlideAnimation,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    width: 350,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: theme.cardColor,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: _isDarkMode
                              ? Colors.black.withOpacity(0.5)
                              : Colors.grey.withOpacity(0.2),
                          blurRadius: 20,
                          spreadRadius: 5,
                        )
                      ],
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            transitionBuilder: (child, animation) => FadeTransition(
                              opacity: animation,
                              child: SlideTransition(
                                position: Tween<Offset>(
                                  begin: const Offset(0, -0.5),
                                  end: Offset.zero,
                                ).animate(animation),
                                child: child,
                              ),
                            ),
                            child: Text(
                              isLogin ? "Welcome Back!" : "Create Your Account",
                              key: ValueKey(isLogin),
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: colorScheme.primary,
                              ),
                            ),
                          ),
                          const SizedBox(height: 25),
                          _buildTextField(
                              controller: emailController,
                              labelText: "Email",
                              icon: Icons.email_outlined,
                              errorText: emailError),
                          const SizedBox(height: 15),
                          _buildTextField(
                              controller: passwordController,
                              labelText: "Password",
                              icon: Icons.lock_outline,
                              obscureText: _isPasswordObscured,
                              isPassword: true,
                              onVisibilityToggle: () {
                                setState(() {
                                  _isPasswordObscured = !_isPasswordObscured;
                                });
                              },
                              errorText: passwordError),
                          SizeTransition(
                            sizeFactor:
                                CurvedAnimation(parent: _formController, curve: Curves.easeInOut),
                            axisAlignment: -1.0,
                            child: FadeTransition(
                              opacity: _formController,
                              child: Column(
                                children: [
                                  const SizedBox(height: 15),
                                  _buildTextField(
                                    controller: confirmPasswordController,
                                    labelText: "Confirm Password",
                                    icon: Icons.lock_person_outlined,
                                    obscureText: _isConfirmPasswordObscured,
                                    isPassword: true,
                                    onVisibilityToggle: () {
                                      setState(() {
                                        _isConfirmPasswordObscured =
                                            !_isConfirmPasswordObscured;
                                      });
                                    },
                                    errorText: confirmPasswordError,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 25),
                          ElevatedButton(
                            onPressed: _isLoading ? null : (isLogin ? login : signUp),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colorScheme.primary,
                              foregroundColor: colorScheme.onPrimary,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              minimumSize: const Size(double.infinity, 50),
                              elevation: 5,
                              shadowColor: colorScheme.primary.withOpacity(0.4),
                            ),
                            child: _isLoading
                                ? const SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2.5,
                                    ),
                                  )
                                : Text(
                                    isLogin ? "Login" : "Sign Up",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                          if (isLogin)
                            TextButton(
                              onPressed: _showForgotPasswordDialog,
                              child: Text(
                                "Forgot Password?",
                                style: TextStyle(
                                    color: theme.colorScheme.secondary,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          TextButton(
                            onPressed: toggleMode,
                            child: Text(
                              isLogin
                                  ? "Don't have an account? Sign Up"
                                  : "Already have an account? Log In",
                              style: TextStyle(color: colorScheme.primary),
                            ),
                          ),
                          TextButton(
                            onPressed: continueAsGuest,
                            child: Text(
                              "Continue as Guest",
                              style:
                                  TextStyle(color: theme.textTheme.bodySmall?.color),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            
            Positioned(
              top: 30,
              right: 20,
              child: IconButton(
                icon: Icon(
                  _isDarkMode ? Icons.wb_sunny_rounded : Icons.nights_stay_rounded,
                  color: _isDarkMode ? Colors.amberAccent : Colors.deepPurpleAccent,
                  size: 28,
                ),
                onPressed: () => setState(() => _isDarkMode = !_isDarkMode),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    bool obscureText = false,
    bool isPassword = false,
    VoidCallback? onVisibilityToggle,
    String? errorText,
  }) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            labelText: labelText,
            prefixIcon: Icon(icon, color: theme.colorScheme.primary),
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      obscureText ? Icons.visibility_off : Icons.visibility,
                      color: theme.colorScheme.primary,
                    ),
                    onPressed: onVisibilityToggle,
                  )
                : null,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: theme.colorScheme.primary, width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: theme.dividerColor),
            ),
          ),
        ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 4.0, left: 8.0),
            child: Text(
              errorText,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }
}
