import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'splash_screen.dart';
import 'routes.dart';
import 'auth_provider.dart';
import 'welcome_screen.dart';
import 'login_screen.dart';
import 'signup_screen.dart';
import 'profile_screen.dart';
import 'add_book_screen.dart'; // Ensure this import is present

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BookShelf',
      initialRoute: Routes.splash,
      routes: {
        Routes.splash: (context) => const SplashScreen(),
        Routes.welcome: (context) => const WelcomeScreen(),
        Routes.login: (context) => const LoginScreen(),
        Routes.signup: (context) => const SignupScreen(),
        Routes.profile: (context) => const ProfileScreen(),
        Routes.addBook: (context) => const AddBookScreen(), // Keep this
        // Removed Routes.bookDetails since it was not part of yesterday's state
      },
    );
  }
}
