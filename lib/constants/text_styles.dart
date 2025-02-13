// lib/constants/text_styles.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

class AppTextStyles {
  // Poppins untuk heading - Modern, clean, dan professional
  static TextStyle heading1 = GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.darkBlue,
  );

  static TextStyle heading2 = GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.darkBlue,
  );

  // Inter untuk body text - Sangat readable dan modern
  static TextStyle body1 = GoogleFonts.inter(
    fontSize: 16,
    color: AppColors.darkBlue,
    height: 1.5,
  );

  static TextStyle body2 = GoogleFonts.inter(
    fontSize: 14,
    color: AppColors.darkBlue,
    height: 1.4,
  );

  // DM Sans untuk angka dan data - Clean dan modern untuk angka
  static TextStyle amount = GoogleFonts.dmSans(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.darkBlue,
    letterSpacing: -0.5,
  );

  static TextStyle amountSmall = GoogleFonts.dmSans(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.darkBlue,
    letterSpacing: -0.5,
  );

  // Worksans untuk caption dan teks kecil - Readable di ukuran kecil
  static TextStyle caption = GoogleFonts.workSans(
    fontSize: 12,
    color: Colors.grey[600],
    letterSpacing: 0.2,
  );

  // Button text style
  static TextStyle button = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    letterSpacing: 0.5,
  );
}