import 'package:kiranaapp/ui/views/startup_view.dart';
import 'package:flutter/material.dart';
import 'package:kiranaapp/services/navigation_service.dart';
import 'package:kiranaapp/services/dialog_service.dart';
import 'package:provider/provider.dart';
import 'managers/dialog_manager.dart';
import 'notifier/food_notifier.dart';
import 'ui/router.dart';
import 'locator.dart';

void main() {
  // Register all the models and services before the app starts
  setupLocator();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        builder: (context) => FoodNotifier(),
      ),

    ],
    child: MyApp(),
  ));
     // MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kirana',
      builder: (context, child) => Navigator(
        key: locator<DialogService>().dialogNavigationKey,
        onGenerateRoute: (settings) => MaterialPageRoute(
            builder: (context) => DialogManager(child: child)),
      ),
      navigatorKey: locator<NavigationService>().navigationKey,
      theme: ThemeData(
        primaryColor: Color(
             0xff19c7c1
            //Colors.purple,
         ),
        textTheme: Theme.of(context).textTheme.apply(
              fontFamily: 'Open Sans',
            ),
      ),
      home: StartUpView(),
      onGenerateRoute: generateRoute,
    );
  }
}
