import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:version_poc/features/home/feature_manager.dart';

class MyHomePage extends HookConsumerWidget {
  static const routeName = '/home_page';
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = useState(0);
    final availableFeatures = ref.watch(featureProvider);
    final currentFeature = availableFeatures.keys.elementAt(currentIndex.value);
    return Scaffold(
      appBar: AppBar(
        title: Text(currentFeature.name),
      ),
      body: availableFeatures[currentFeature],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex.value,
        onTap: (newIndex) => currentIndex.value = newIndex,
        items: availableFeatures.keys
            .map(
              (feature) => BottomNavigationBarItem(
                icon: Icon(feature.icon),
                label: feature.name,
              ),
            )
            .toList(),
      ),
    );
  }
}
