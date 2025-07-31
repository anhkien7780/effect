import 'package:effect/ui/download_button_app/app_store_cubit.dart';
import 'package:effect/ui/download_button_app/app_store_state.dart';
import 'package:effect/ui/download_button_app/enum/download_status.dart';
import 'package:effect/ui/download_button_app/widgets/download_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DownloadItem extends StatelessWidget {
  const DownloadItem({
    super.key,
    required this.appName,
    required this.appDescription,
  });

  final String appName;
  final String appDescription;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQFVPcHGroySXhQpz_2eB-C9pmYwLtDQ4e6lQ&s",
              width: 70,
              height: 70,
            ),
            Flexible(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    appName,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    appDescription,
                    maxLines: 1,
                    softWrap: false,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.w200,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: BlocBuilder<AppStoreCubit, AppStoreState>(
                builder: (BuildContext context, state) {
                  return GestureDetector(
                    onTap: () {
                      if (state.status == DownloadStatus.notDownLoaded) {
                        context.read<AppStoreCubit>().onGetButtonPressed();
                      }
                      if(state.status == DownloadStatus.downloading){
                        context.read<AppStoreCubit>().onPauseButtonPressed();
                      }
                      if(state.status == DownloadStatus.pause){
                        context.read<AppStoreCubit>().onGetButtonPressed();
                      }
                    },
                    child: DownloadButton(
                      status: state.status,
                      downloadProgress: state.downloadProgress,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
