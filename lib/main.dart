import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stones_classifier/pages/sign_in_page.dart';
import 'package:stones_classifier/providers/bottom_navigation_bar_provider.dart';
import 'package:stones_classifier/providers/camera_provider.dart';

late List<CameraDescription> cameras;

void main() async {
  cameras = await availableCameras();
  runApp(const StoneClassifier());
}

class StoneClassifier extends StatelessWidget {
  const StoneClassifier({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => BottomNavigationBarProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CameraProvider(),
        ),
      ],
      child: Builder(builder: (context) {
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SignInPage(),
        );
      }),
    );
  }
}
