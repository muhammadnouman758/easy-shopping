import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:convert';

import 'package:tera/view_model.dart';

typedef DownloadProgressCallback = void Function(int progress, DownloadStatus status);

class DownloadInfo {
  final String downloadLink;
  final String fileName;
  final int fileSize;

  DownloadInfo({
    required this.downloadLink,
    required this.fileName,
    required this.fileSize,
  });
}

class DownloadManager {
  final _client = http.Client();
  final _chunkSize = 10 * 1024 * 1024; // 10MB chunks

  Future<DownloadInfo> startDownload(String teraBoxUrl) async {
    final downloadInfo = await _fetchDirectDownloadLink(teraBoxUrl);

    final downloadDir = await getTemporaryDirectory();
    final finalFile = File('${(await getExternalStorageDirectory())!.path}/${downloadInfo.fileName}');

    // Check if file already exists
    if (await finalFile.exists() && await finalFile.length() == downloadInfo.fileSize) {
      print('Download Complete: ${downloadInfo.fileName}');
      return downloadInfo;
    }

    final totalChunks = (downloadInfo.fileSize + _chunkSize - 1) ~/ _chunkSize;

    print('Starting Download: ${downloadInfo.fileName}');

    // Download chunks
    final futures = <Future<bool>>[];
    for (var i = 0; i < totalChunks; i++) {
      futures.add(_downloadChunk(
        downloadInfo.downloadLink,
        i,
        _chunkSize,
        downloadInfo.fileSize,
        downloadDir,
      ));
    }

    return downloadInfo;
  }

  Future<void> observeDownload(String id, DownloadProgressCallback callback) async {
    var completedChunks = 0;
    final totalChunks = 10; // Simulated for simplicity
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      completedChunks++;
      final progress = (completedChunks * 100 ~/ totalChunks).clamp(0, 100);
      final status = completedChunks >= totalChunks
          ? DownloadStatus.completed
          : DownloadStatus.downloading;

      callback(progress, status);

      if (status == DownloadStatus.completed) {
        timer.cancel();
        print('Download Complete: File');
      }
    });
  }

  Future<DownloadInfo> _fetchDirectDownloadLink(String teraBoxUrl) async {
    final apiUrl = 'https://pika-terabox-dl.vercel.app/?url=$teraBoxUrl';
    final response = await _client.get(Uri.parse(apiUrl));

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch download link: ${response.statusCode}');
    }

    final jsonResponse = jsonDecode(response.body);
    return DownloadInfo(
      downloadLink: jsonResponse['downloadLink'],
      fileName: jsonResponse['fileName'],
      fileSize: jsonResponse['fileSize'],
    );
  }

  Future<bool> _downloadChunk(
      String url,
      int chunkIndex,
      int chunkSize,
      int totalSize,
      Directory downloadDir,
      ) async {
    final chunkFile = File('${downloadDir.path}/chunk_$chunkIndex');
    final startByte = chunkIndex * chunkSize;
    final endByte = (startByte + chunkSize - 1).clamp(0, totalSize - 1);

    if (await chunkFile.exists() && await chunkFile.length() == endByte - startByte + 1) {
      return true;
    }

    try {
      final request = http.Request('GET', Uri.parse(url))
        ..headers['Range'] = 'bytes=$startByte-$endByte';

      final response = await _client.send(request);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final sink = chunkFile.openWrite();
        await response.stream.pipe(sink);
        await sink.close();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  void dispose() {
    _client.close();
  }
}