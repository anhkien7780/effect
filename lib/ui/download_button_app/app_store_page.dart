import 'package:effect/ui/download_button_app/app_store_cubit.dart';
import 'package:effect/ui/download_button_app/widgets/download_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppStore extends StatelessWidget {
  const AppStore({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Apps"),
        backgroundColor: Colors.blue,
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          return BlocProvider(
            create: (BuildContext context) {
              return AppStoreCubit();
            },
            child: DownloadItem(
              appName: "App $index",
              appDescription: "This is a longggggggggggggggg description!!!",
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemCount: 10,
      ),
    );
  }
}
