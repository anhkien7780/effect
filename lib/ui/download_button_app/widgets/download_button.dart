import 'package:effect/ui/download_button_app/enum/download_status.dart';
import 'package:effect/ui/download_button_app/widgets/progress_indicator_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'button_shape_widget.dart';

@immutable
class DownloadButton extends StatelessWidget {
  const DownloadButton({
    super.key,
    required this.status,
    this.transitionDuration = const Duration(milliseconds: 500),
    required this.downloadProgress,
  });

  final DownloadStatus status;
  final double downloadProgress;
  final Duration transitionDuration;

  bool get _isDownloading => status == DownloadStatus.downloading;

  bool get _isFetching => status == DownloadStatus.fetchingDownload;

  bool get _isDownloaded => status == DownloadStatus.downloaded;

  bool get _isPaused => status == DownloadStatus.pause;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ButtonShapeWidget(
          isDownloading: _isDownloading,
          isDownloaded: _isDownloaded,
          isFetching: _isFetching,
          isPaused: _isPaused,
          transitionDuration: transitionDuration,
        ),
        Positioned.fill(
          child: AnimatedOpacity(
            opacity: _isDownloading || _isFetching || _isPaused ? 1.0 : 0.0,
            duration: transitionDuration,
            curve: Curves.ease,
            child: Stack(
              alignment: Alignment.center,
              children: [
                ProgressIndicatorWidget(
                  progress: downloadProgress,
                  isDownloading: _isDownloading,
                  isFetching: _isFetching,
                ),
                if (!_isFetching)
                  const Icon(Icons.stop, color: CupertinoColors.activeBlue),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
