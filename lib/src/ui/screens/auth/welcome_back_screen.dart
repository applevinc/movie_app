import 'package:flutter/material.dart';
import 'package:movie_app/src/core/assets/images.dart';

class WelcomeBackScreen extends StatelessWidget {
  const WelcomeBackScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Image.asset(
              AppImages.redBackground,
              height: size.height,
              width: size.width,
              fit: BoxFit.cover,
            ),
            Positioned(
              top: size.height * 0.3,
              bottom: 0,
              child: const _FormView(),
            ),
          ],
        ),
      ),
    );
  }
}

class _FormView extends StatelessWidget {
  const _FormView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height,
      width: size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.red.withOpacity(0.1),
            Colors.red,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [
            0.02,
            0.2,
          ],
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: size.height * 0.2),
          Text(
            'Welcome Back',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
          ),
          Text(
            'Log in to your account',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
          ),
        ],
      ),
    );
  }
}
