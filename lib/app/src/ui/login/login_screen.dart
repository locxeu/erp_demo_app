import 'package:crypt/crypt.dart';
import 'package:erp_demo/app/src/ui/home/home_screen.dart';
import 'package:erp_demo/app/src/ui/register/register_screen.dart';
import 'package:erp_demo/backend/controller/login/login_controller.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _login() async {
    final useName = _userNameController.text;
    final password = _passwordController.text;
    final isLoginSuccess =
        await LoginController().checkUserLogin(useName, password);
    if (isLoginSuccess) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: ListView(
        padding: const EdgeInsets.only(
          left: 16,
          top: 48,
          right: 16,
        ),
        children: [
          TextFormField(
            controller: _userNameController,
            decoration: const InputDecoration(
              hintText: 'User Name',
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(
              hintText: 'Password',
            ),
          ),
          TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegisterScreen()));
              },
              child: const Text(
                'Create Account',
                style: TextStyle(color: Colors.blue, fontSize: 16),
              )),
          GestureDetector(
            onTap: _login,
            child: Container(
              margin: const EdgeInsets.only(top: 100),
              padding: const EdgeInsets.symmetric(vertical: 8),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(25)),
              child: const Text(
                'Login',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          )
        ],
      ),
    );
  }
}
