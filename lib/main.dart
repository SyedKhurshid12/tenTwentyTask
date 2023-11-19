import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tentwenty_task/bottom_nav_bar.dart';
import 'package:tentwenty_task/provider/movie_player_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ChangeNotifierProvider(
      create: (context) => MoviePlayerProvider(),

      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Roboto',
          textTheme: const TextTheme(
            titleSmall: TextStyle(fontFamily: "Roboto")
          ),



          useMaterial3: true,
        ),
        home: BottomNavBar(),
      ),
    );
  }
}
