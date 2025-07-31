import 'package:effect/ui/download_button_app/app_store_state.dart';
import 'package:effect/ui/download_button_app/enum/download_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppStoreCubit extends Cubit<AppStoreState> {
  AppStoreCubit()
    : super(
        AppStoreState(
          downloadProgress: 0.0,
          status: DownloadStatus.notDownLoaded,
        ),
      );

  void onGetButtonPressed() async {
    if (state.status == DownloadStatus.downloaded) {
      return;
    }

    if (state.downloadProgress == 0) {
      emit(state.copyWith(status: DownloadStatus.fetchingDownload));
      await Future.delayed(Duration(seconds: 2));
      emit(state.copyWith(status: DownloadStatus.downloading));
    }

    emit(state.copyWith(status: DownloadStatus.downloading));

    while (state.downloadProgress < 1) {
      var currentProgress = state.downloadProgress;
      if (state.status == DownloadStatus.pause) {
        return;
      }
      emit(state.copyWith(downloadProgress: currentProgress + 0.2));
      await Future.delayed(Duration(seconds: 1));
    }
    emit(state.copyWith(status: DownloadStatus.downloaded));
  }

  void onPauseButtonPressed() {
    emit(state.copyWith(status: DownloadStatus.pause));
  }

  void onResumeButtonPress() {
    emit(state.copyWith(status: DownloadStatus.downloading));
  }
}
