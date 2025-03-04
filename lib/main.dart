
import 'package:erp_demo/app/src/config/dependencies.dart';
import 'package:erp_demo/app/src/route/route.dart';
import 'package:erp_demo/app/src/utils/flavor_utils.dart';
import 'package:erp_demo/backend/controller/login_controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

late final FlavorSettings flavorSettings;

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  flavorSettings = await FlavorSettings.fromEnv();
  await LoginController().createUsersTable();
  runApp(MultiProvider(
      providers: providersLocal,
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        appBarTheme: AppBarTheme(backgroundColor: Colors.white)
      ),
      initialRoute: AppRoutes.initialRoute,
      routes: AppRoutes.routes,
    );
  }
}
