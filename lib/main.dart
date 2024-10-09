import 'package:budgeting_kuy/src/assets/dummy/daftar_logo.dart';
import 'package:budgeting_kuy/src/features/first_page.dart';

import 'package:flutter/material.dart';
import 'src/features/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    StatefulWidget responsiveLayout() {
      if (screenWidth < 600) {
        return FirstPage();
      } else {
        return GridMainScreen(daftarLogo: daftarLogoList);
      }
    }

    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: responsiveLayout());
  }
}
