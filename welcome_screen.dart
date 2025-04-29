import 'package:flutter/material.dart';
import 'routes.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/library_books.jpg',
            fit: BoxFit.cover,
            color: Colors.black.withOpacity(0.4),
            colorBlendMode: BlendMode.darken,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Welcome to BookShelf',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.login);
                  },
                  child: const Text('Login'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.signup);
                  },
                  child: const Text('Sign Up'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
