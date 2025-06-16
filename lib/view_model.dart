import 'package:flutter/foundation.dart';

import 'download_manager.dart';

enum DownloadStatus { pending, downloading, completed, failed, cancelled }

class DownloadItem {
  final String id;
  final String fileName;
  final int progress;
  final DownloadStatus status;

  DownloadItem({
    required this.id,
    required this.fileName,
    this.progress = 0,
    required this.status,
  });
}

class DownloadViewModel with ChangeNotifier {
  List<DownloadItem> _downloads = [];
  List<DownloadItem> get downloads => _downloads;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final DownloadManager _downloadManager = DownloadManager();

  void startDownload(String url) {
    if (!isValidTeraBoxUrl(url)) return;

    _isLoading = true;
    notifyListeners();

    _downloadManager.startDownload(url).then((downloadInfo) {
      final downloadItem = DownloadItem(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        fileName: downloadInfo.fileName,
        status: DownloadStatus.downloading,
      );

      _downloads = [..._downloads, downloadItem];
      notifyListeners();

      _downloadManager.observeDownload(downloadItem.id, (progress, status) {
        _updateDownloadStatus(downloadItem.id, progress, status);
      }).then((_) {
        _isLoading = false;
        notifyListeners();
      }).catchError((error) {
        _isLoading = false;
        _updateDownloadStatus(downloadItem.id, 0, DownloadStatus.failed);
        notifyListeners();
      });
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
    });
  }

  void _updateDownloadStatus(String id, int progress, DownloadStatus status) {
    _downloads = _downloads.map((item) {
      if (item.id == id) {
        return DownloadItem(
          id: item.id,
          fileName: item.fileName,
          progress: progress,
          status: status,
        );
      }
      return item;
    }).toList();
    notifyListeners();
  }

  bool isValidTeraBoxUrl(String url) {
    return url.toLowerCase().contains('terabox.com') ||
        url.toLowerCase().contains('1024tera.com');
  }
}