import 'package:effect/router/app_router.dart';
import 'package:effect/ui/download_button_app/app_store_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        AppRouter.main: (context) => MainPage(),
        AppRouter.appStore: (context) => AppStore(),
      },
      initialRoute: AppRouter.main,
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRouter.appStore);
                  },
                  child: Text("App Store"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
