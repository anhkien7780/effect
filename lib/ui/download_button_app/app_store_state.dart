import 'package:effect/ui/download_button_app/enum/download_status.dart';
import 'package:equatable/equatable.dart';

class AppStoreState extends Equatable {
  final double downloadProgress;
  final DownloadStatus status;

  const AppStoreState({required this.downloadProgress, required this.status});

  AppStoreState copyWith({double? downloadProgress, DownloadStatus? status}) {
    return AppStoreState(
      downloadProgress: downloadProgress ?? this.downloadProgress,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [downloadProgress, status];
}
