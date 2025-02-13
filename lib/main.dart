import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants/colors.dart';
import 'screens/splash/splash_screen.dart';
import 'screens/home/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ExpensePredict',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.teal,
        scaffoldBackgroundColor: Colors.white,
        textTheme: TextTheme(
          // Headings
          displayLarge: GoogleFonts.poppins(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: AppColors.darkBlue,
          ),
          displayMedium: GoogleFonts.poppins(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppColors.darkBlue,
          ),
          displaySmall: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.darkBlue,
          ),
          // Body text
          bodyLarge: GoogleFonts.inter(
            fontSize: 16,
            color: AppColors.darkBlue,
            height: 1.5,
          ),
          bodyMedium: GoogleFonts.inter(
            fontSize: 14,
            color: AppColors.darkBlue,
            height: 1.4,
          ),
          bodySmall: GoogleFonts.workSans(
            fontSize: 12,
            color: Colors.grey[600],
            letterSpacing: 0.2,
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.teal,
          elevation: 0,
          titleTextStyle: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}