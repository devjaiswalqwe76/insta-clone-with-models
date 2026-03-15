import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../app/routes/app_routes.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;

  // TODO: Firebase Auth Instance
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      // Logic for Firebase Login would go here
      // try {
      //   await _auth.signInWithEmailAndPassword(email: ..., password: ...);
      //   Navigator.pushReplacementNamed(context, AppRoutes.feed);
      // } catch (e) { ... }

      // Demo login
      if (_emailController.text == "demo@gmail.com" && _passwordController.text == "123456") {
        Navigator.pushReplacementNamed(context, AppRoutes.feed);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Try demo@gmail.com / 123456")),
        );
      }
    }
  }

  Future<void> _handleGoogleLogin() async {
    // TODO: Implement Google Sign-In with Firebase
    // 1. Configure GoogleSignIn
    // 2. Authenticate with Firebase
    print("Google Login Triggered");
  }

  Future<void> _handleFacebookLogin() async {
    // TODO: Implement Facebook Login with Firebase
    print("Facebook Login Triggered");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. Vibrant Background Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF8A23BE), // Purple
                  Color(0xFFE94057), // Pink/Red
                  Color(0xFFF27121), // Orange
                ],
              ),
            ),
          ),

          // 2. Floating Elements (Optional: Bubbles/Hearts for visual flair)
          Positioned(
            top: 100,
            right: 50,
            child: Icon(Icons.send, color: Colors.white.withOpacity(0.3), size: 100),
          ),
          Positioned(
            top: 50,
            left: 30,
            child: Icon(Icons.favorite, color: Colors.white.withOpacity(0.2), size: 60),
          ),

          // 3. Main Login Content
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Instagram Logo
                    const Text(
                      "Instagram",
                      style: TextStyle(
                        fontSize: 50,
                        color: Colors.white,
                        fontFamily: 'Billabong', // Custom font or italic fallback
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Translucent Card
                    ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          padding: const EdgeInsets.all(25),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(color: Colors.white.withOpacity(0.2)),
                          ),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                // Username/Email Field
                                _buildTextField(
                                  controller: _emailController,
                                  hint: "Phone number, username, or email",
                                  icon: Icons.person_outline,
                                ),
                                const SizedBox(height: 15),

                                // Password Field
                                _buildTextField(
                                  controller: _passwordController,
                                  hint: "Password",
                                  icon: Icons.lock_outline,
                                  isPassword: true,
                                  suffix: GestureDetector(
                                    onTap: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
                                    child: Text(
                                      _isPasswordVisible ? "Hide" : "Show",
                                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),

                                // Forgot Password
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () {},
                                    child: const Text(
                                      "Forgot password?",
                                      style: TextStyle(color: Colors.white70, fontSize: 12),
                                    ),
                                  ),
                                ),

                                // Login Button (Gradient)
                                Container(
                                  width: double.infinity,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    gradient: const LinearGradient(
                                      colors: [Color(0xFFFF4E50), Color(0xFFF9D423)],
                                    ),
                                  ),
                                  child: ElevatedButton(
                                    onPressed: _handleLogin,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                    ),
                                    child: const Text("Log In", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                                  ),
                                ),

                                const SizedBox(height: 20),
                                const Row(
                                  children: [
                                    Expanded(child: Divider(color: Colors.white30)),
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 10),
                                      child: Text("OR", style: TextStyle(color: Colors.white70)),
                                    ),
                                    Expanded(child: Divider(color: Colors.white30)),
                                  ],
                                ),
                                const SizedBox(height: 20),

                                // Facebook Login
                                _buildSocialButton(
                                  label: "Log in with Facebook",
                                  icon: Icons.facebook,
                                  color: const Color(0xFF1877F2),
                                  onPressed: _handleFacebookLogin,
                                ),
                                const SizedBox(height: 10),

                                // Google Login
                                _buildSocialButton(
                                  label: "Log in with Google",
                                  icon: Icons.g_mobiledata, // Use custom svg icon if available
                                  color: Colors.white,
                                  textColor: Colors.black,
                                  onPressed: _handleGoogleLogin,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),
                    // Sign Up Footer
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account? ", style: TextStyle(color: Colors.white70)),
                        GestureDetector(
                          onTap: () {},
                          child: const Text("Sign Up", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool isPassword = false,
    Widget? suffix,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword && !_isPasswordVisible,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white60, fontSize: 14),
        prefixIcon: Icon(icon, color: Colors.white70),
        suffixIcon: suffix != null ? Padding(padding: const EdgeInsets.only(right: 15, top: 15), child: suffix) : null,
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        contentPadding: const EdgeInsets.symmetric(vertical: 18),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.white30),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    required String label,
    required IconData icon,
    required Color color,
    Color textColor = Colors.white,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 45,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, color: textColor),
        label: Text(label, style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 0,
        ),
      ),
    );
  }
}
