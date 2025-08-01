import 'package:effect/router/app_router.dart';
import 'package:effect/ui/download_button_app/app_store_page.dart';
import 'package:effect/ui/parallax_recipe_app/parallax_recipe_app.dart';
import 'package:effect/ui/shimmer_loading_app/shimmer_loading_app.dart';
import 'package:effect/ui/staggered_menu_app/staggered_menu_app.dart';
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
        AppRouter.parallaxRecipeApp: (context) => ParallaxRecipeApp(),
        AppRouter.shimmerLoadingApp: (context) => ShimmerLoadingApp(),
        AppRouter.staggeredMenuApp: (context) => Menu(),
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
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRouter.parallaxRecipeApp);
                  },
                  child: Text("Parallax Recipe"),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRouter.shimmerLoadingApp);
                  },
                  child: Text("Shimmer Loading"),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRouter.staggeredMenuApp);
                  },
                  child: Text("Staggered Menu"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
