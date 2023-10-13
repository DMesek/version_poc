import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:version_poc/features/home/home_page.dart';
import 'package:version_poc/features/settings/version_notifier.dart';

class SplashPage extends HookConsumerWidget {
  static const routeName = '/';
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(versionNotifierProvider);
    final controller = getConfiguredController(context);
    final scaleAnimation = Tween<double>(begin: 1, end: 2).animate(controller);
    return Scaffold(
      body: Center(
        child: ScaleTransition(
          scale: scaleAnimation,
          child: const Text(
            'Version switch\n POC',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Animation<double> getConfiguredController(BuildContext context) {
    final controller =
        useAnimationController(duration: const Duration(seconds: 1))..forward();
    controller.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        controller.reverse();
        await Future.delayed(const Duration(seconds: 1));
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushNamedAndRemoveUntil(
          MyHomePage.routeName,
          (_) => false,
        );
      }
    });
    return controller;
  }
}
