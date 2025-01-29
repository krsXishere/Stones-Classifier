import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:stones_classifier/common/constant.dart';
import 'package:stones_classifier/pages/sign_in_page.dart';
import 'package:stones_classifier/providers/authentication_provider.dart';
import 'package:stones_classifier/providers/bottom_navigation_bar_provider.dart';
import 'package:stones_classifier/providers/camera_provider.dart';
import 'package:stones_classifier/providers/classify_stones_provider.dart';
import 'package:stones_classifier/providers/user_provider.dart';
import 'package:stones_classifier/widgets/bottom_navigation_bar_widget.dart';

late List<CameraDescription> cameras;
String? token;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  token = await storage.read(key: "token");

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
        ChangeNotifierProvider(
          create: (context) => ClassifyStonesProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthenticationProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
      ],
      child: Builder(builder: (context) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: token != null
              ? const BottomNavigationBarWidget()
              : const SignInPage(),
        );
      }),
    );
  }
}
