import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../../core/contants/app_color.dart';
import '../../core/contants/app_image.dart';
import '../../core/utils/navigation.dart';
import '../auth/login_screen.dart';
import 'onboarding_page.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        pages: [
          PageViewModel(
            decoration: const PageDecoration(
              bodyPadding: EdgeInsets.zero,
            ),
            titleWidget: OnboardingPage(
              image: AppImages.onboarding1,
              title: 'Discover Amazing Products',
              description: 'Explore thousands of products from various categories',
            ),
            body: '', // Add empty string as body
          ),
          PageViewModel(
            decoration: const PageDecoration(
              bodyPadding: EdgeInsets.zero,
            ),
            titleWidget: OnboardingPage(
              image: AppImages.onboarding2,
              title: 'Easy & Secure Payment',
              description: 'Pay with your favorite payment method securely',
            ),
            body: '', // Add empty string as body
          ),
          PageViewModel(
            decoration: const PageDecoration(
              bodyPadding: EdgeInsets.zero,
            ),
            titleWidget: OnboardingPage(
              image: AppImages.onboarding3,
              title: 'Fast Delivery',
              description: 'Get your products delivered to your doorstep quickly',
            ),
            body: '', // Add empty string as body
          ),
        ],
        onDone: () {
          Navigation.pushReplacement(context, const LoginScreen());
        },
        showSkipButton: true,
        skip: const Text('Skip', style: TextStyle(color: AppColors.primary)),
        next: const Icon(Icons.arrow_forward, color: AppColors.primary),
        done: const Text('Done',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: AppColors.primary)),
        dotsDecorator: DotsDecorator(
          size: const Size.square(10.0),
          activeSize: const Size(20.0, 10.0),
          activeColor: AppColors.primary,
          color: AppColors.grey,
          spacing: const EdgeInsets.symmetric(horizontal: 3.0),
          activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0)),
        ),
      ),
    );
  }
}