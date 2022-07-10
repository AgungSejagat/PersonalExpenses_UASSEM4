import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uas_made/modules/database/database.dart';
import 'package:uas_made/modules/home/providers/home_provider.dart';
import 'package:uas_made/modules/home/screens/home_screen.dart';
import 'package:uas_made/modules/transaction/providers/transcation_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => HomeProvider()),
      ChangeNotifierProvider(create: (context) => TransactionProvider()),
    ],
    child: const MyApp(),
  ));

  await DatabaseUtils.getDatabase();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomeScreen(),
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.green.shade500,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.green.shade500,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.green.shade500),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(Colors.green.shade500),
          ),
        ),
      ),
    );
  }
}
