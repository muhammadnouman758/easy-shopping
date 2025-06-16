import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'features/auth/auth_view_model.dart';
import 'features/auth/login_screen.dart';
import 'features/cart/cart_screen.dart';
import 'features/cart/cart_view_model.dart';
import 'features/checkout/check_view_model.dart';

import 'features/checkout/checkout_order.dart';
import 'features/checkout/checkout_screen.dart';
import 'features/checkout/order_confirmation.dart';
import 'features/home/home_screen.dart';
import 'features/home/home_view_model.dart';

import 'features/order/order_detail_screen.dart';
import 'features/order/order_screen.dart';
import 'features/order/order_view_model.dart';
import 'features/product_detail/product_detail_screen.dart';
import 'features/products/product_model.dart';
import 'features/profile/edit_profile_screen.dart';
import 'features/profile/profile_screen.dart';
import 'features/profile/profile_view_model.dart';
import 'features/profile/setting_screen.dart';
import 'features/search/search_screen.dart';
import 'features/search/search_view_model.dart';
import 'features/splash/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => CartViewModel()),
        ChangeNotifierProvider(create: (_) => CheckoutViewModel()),
        ChangeNotifierProvider(create: (_) => OrdersViewModel()),
        ChangeNotifierProvider(create: (_) => ProfileViewModel()),
        ChangeNotifierProvider(create: (_) => SearchViewModel()),
      ],
      child: MaterialApp(
        title: 'ShopEasy',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
          appBarTheme: const AppBarTheme(
            elevation: 0,
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        home: const SplashScreen(),
          routes: {
            '/home': (context) => const HomeScreen(),
            '/login': (context) => const LoginScreen(),
            '/product-detail': (context) {
              final product = ModalRoute.of(context)!.settings.arguments as Product;
              return ProductDetailScreen(product: product);
            },
            '/cart': (context) => const CartScreen(),
            '/checkout': (context) => const CheckoutScreen(),
            '/order-confirmation': (context) {
              final order = ModalRoute.of(context)!.settings.arguments as Order;
              return OrderConfirmationScreen(order: order);
            },
            '/orders': (context) => const OrdersScreen(),
            '/order-details': (context) {
              final orderId = ModalRoute.of(context)!.settings.arguments as String;
              return OrderDetailsScreen();
            },
            '/profile': (context) => const ProfileScreen(),
            '/edit-profile': (context) => const EditProfileScreen(),
            '/settings': (context) => const SettingsScreen(),
            '/search': (context) => const SearchScreen(),
          },

      ),
    );
  }
}

// import 'dart:io';
// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:http/http.dart' as http;
// import 'package:path_provider/path_provider.dart';
// import 'dart:convert';
// import 'package:provider/provider.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:youtube_explode_dart/youtube_explode_dart.dart';
//
// void main() {
//   runApp(
//     ChangeNotifierProvider(
//       create: (_) => DownloadViewModel(),
//       child: const MyApp(),
//     ),
//   );
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Downloader',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         useMaterial3: true,
//       ),
//       home: const DownloaderApp(),
//     );
//   }
// }
//
// enum DownloadStatus { pending, downloading, completed, failed, cancelled }
//
// class DownloadItem {
//   final String id;
//   final String fileName;
//   final int progress;
//   final DownloadStatus status;
//
//   DownloadItem({
//     required this.id,
//     required this.fileName,
//     this.progress = 0,
//     required this.status,
//   });
// }
//
// typedef DownloadProgressCallback = void Function(int progress, DownloadStatus status);
//
// class DownloadInfo {
//   final String downloadLink;
//   final String fileName;
//   final int fileSize;
//
//   DownloadInfo({
//     required this.downloadLink,
//     required this.fileName,
//     required this.fileSize,
//   });
// }
//
// class DownloadManager {
//   final _client = http.Client();
//   final _chunkSize = 10 * 1024 * 1024; // 10MB chunks
//   final _youtubeExplode = YoutubeExplode();
//
//   Future<DownloadInfo> startDownload(String url, String downloadId, DownloadProgressCallback callback) async {
//     if (Platform.isAndroid) {
//       final status = await Permission.storage.request();
//       if (!status.isGranted) {
//         callback(0, DownloadStatus.failed);
//         throw Exception('Storage permission denied');
//       }
//     }
//
//     final downloadInfo = await _fetchDownloadLink(url);
//
//     final downloadDir = await getTemporaryDirectory();
//     final finalFile = File('${(await getExternalStorageDirectory())!.path}/${downloadInfo.fileName}');
//
//     if (await finalFile.exists() && await finalFile.length() == downloadInfo.fileSize) {
//       callback(100, DownloadStatus.completed);
//       return downloadInfo;
//     }
//
//     final totalChunks = (downloadInfo.fileSize + _chunkSize - 1) ~/ _chunkSize;
//     int downloadedBytes = 0;
//
//     print('Starting Download: ${downloadInfo.fileName}');
//
//     final futures = <Future<bool>>[];
//     for (var i = 0; i < totalChunks; i++) {
//       futures.add(_downloadChunk(
//         downloadInfo.downloadLink,
//         i,
//         _chunkSize,
//         downloadInfo.fileSize,
//         downloadDir,
//             (chunkBytes) {
//           downloadedBytes += chunkBytes;
//           final progress = ((downloadedBytes / downloadInfo.fileSize) * 100).clamp(0, 100).toInt();
//           callback(progress, DownloadStatus.downloading);
//         },
//       ));
//     }
//
//     final results = await Future.wait(futures);
//     if (results.every((success) => success)) {
//       await _mergeChunks(downloadDir, finalFile, totalChunks);
//       callback(100, DownloadStatus.completed);
//     } else {
//       callback(0, DownloadStatus.failed);
//     }
//
//     return downloadInfo;
//   }
//
//   Future<DownloadInfo> _fetchDownloadLink(String url) async {
//     if (_isYouTubeUrl(url)) {
//       return _fetchYouTubeDownloadLink(url);
//     } else {
//       return _fetchGenericDownloadLink(url);
//     }
//   }
//
//   bool _isYouTubeUrl(String url) {
//     final lowerUrl = url.toLowerCase();
//     return lowerUrl.contains('youtube.com') || lowerUrl.contains('youtu.be');
//   }
//
//   Future<DownloadInfo> _fetchYouTubeDownloadLink(String url) async {
//     try {
//       final videoId = YoutubeExplode().videos.get(url);
//       if (videoId == null) {
//         throw Exception('Invalid YouTube URL');
//       }
//       final video = await _youtubeExplode.videos.get(videoId);
//       final manifest = await _youtubeExplode.videos.streamsClient.getManifest(videoId);
//       final streamInfo = manifest.muxed.withHighestBitrate();
//       final fileName = '${video.title.replaceAll(RegExp(r'[^\w\s]'), '')}.mp4';
//       final fileSize = streamInfo.size.totalBytes;
//
//       print('YouTube Download Link: ${streamInfo.url}, File: $fileName, Size: $fileSize');
//
//       return DownloadInfo(
//         downloadLink: streamInfo.url.toString(),
//         fileName: fileName,
//         fileSize: fileSize,
//       );
//     } catch (e) {
//       print('YouTube download link fetch failed: $e');
//       throw Exception('Failed to fetch YouTube download link: $e');
//     }
//   }
//
//   Future<DownloadInfo> _fetchGenericDownloadLink(String url) async {
//     final apiUrl = 'https://pika-terabox-dl.vercel.app/?url=$url';
//     for (int attempt = 1; attempt <= 3; attempt++) {
//       try {
//         final request = http.Request('GET', Uri.parse(apiUrl))
//           ..headers['User-Agent'] = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/91.0.4472.124';
//         final response = await _client.send(request).timeout(const Duration(seconds: 10));
//         final body = await response.stream.bytesToString();
//         print('API Response Status: ${response.statusCode}, Body: $body');
//         if (response.statusCode == 200) {
//           final jsonResponse = jsonDecode(body);
//           return DownloadInfo(
//             downloadLink: jsonResponse['downloadLink'],
//             fileName: jsonResponse['fileName'],
//             fileSize: jsonResponse['fileSize'],
//           );
//         }
//       } catch (e) {
//         print('API Attempt $attempt failed: $e');
//         if (attempt == 3) {
//           throw Exception('Failed to fetch download link after $attempt attempts: $e');
//         }
//         await Future.delayed(const Duration(seconds: 2));
//       }
//     }
//     throw Exception('Failed to fetch download link');
//   }
//
//   Future<bool> _downloadChunk(
//       String url,
//       int chunkIndex,
//       int chunkSize,
//       int totalSize,
//       Directory downloadDir,
//       Function(int) onChunkProgress) async {
//     final chunkFile = File('${downloadDir.path}/chunk_$chunkIndex');
//     final startByte = chunkIndex * chunkSize;
//     final endByte = (startByte + chunkSize - 1).clamp(0, totalSize - 1);
//
//     if (await chunkFile.exists() && await chunkFile.length() == endByte - startByte + 1) {
//       onChunkProgress(endByte - startByte + 1);
//       return true;
//     }
//
//     try {
//       final request = http.Request('GET', Uri.parse(url))
//         ..headers['Range'] = 'bytes=$startByte-$endByte';
//       final response = await _client.send(request).timeout(const Duration(seconds: 30));
//       if (response.statusCode >= 200 && response.statusCode < 300) {
//         final sink = chunkFile.openWrite();
//         int chunkBytes = 0;
//         await for (var data in response.stream) {
//           sink.add(data);
//           chunkBytes += data.length;
//           onChunkProgress(chunkBytes);
//         }
//         await sink.close();
//         return true;
//       }
//       print('Chunk $chunkIndex failed: HTTP ${response.statusCode}');
//       return false;
//     } catch (e) {
//       print('Chunk $chunkIndex failed: $e');
//       return false;
//     }
//   }
//
//   Future<void> _mergeChunks(Directory downloadDir, File finalFile, int totalChunks) async {
//     final sink = finalFile.openWrite();
//     for (var i = 0; i < totalChunks; i++) {
//       final chunkFile = File('${downloadDir.path}/chunk_$i');
//       if (await chunkFile.exists()) {
//         final bytes = await chunkFile.readAsBytes();
//         sink.add(bytes);
//         await chunkFile.delete();
//       }
//     }
//     await sink.close();
//   }
//
//   void dispose() {
//     _client.close();
//     _youtubeExplode.close();
//   }
// }
//
// class DownloadViewModel with ChangeNotifier {
//   List<DownloadItem> _downloads = [];
//   List<DownloadItem> get downloads => _downloads;
//   bool _isLoading = false;
//   bool get isLoading => _isLoading;
//
//   final DownloadManager _downloadManager = DownloadManager();
//
//   void startDownload(String url) {
//     if (url.isEmpty) return;
//
//     _isLoading = true;
//     notifyListeners();
//
//     final downloadId = DateTime.now().millisecondsSinceEpoch.toString();
//     final downloadItem = DownloadItem(
//       id: downloadId,
//       fileName: 'Fetching...',
//       status: DownloadStatus.pending,
//     );
//
//     _downloads = [..._downloads, downloadItem];
//     notifyListeners();
//
//     _downloadManager.startDownload(url, downloadId, (progress, status) {
//       _updateDownloadStatus(downloadId, progress, status);
//     }).then((downloadInfo) {
//       _updateDownloadStatus(downloadId, 100, DownloadStatus.completed, fileName: downloadInfo.fileName);
//       _isLoading = false;
//       notifyListeners();
//     }).catchError((error) {
//       _isLoading = false;
//       _updateDownloadStatus(downloadId, 0, DownloadStatus.failed, error: error.toString());
//       notifyListeners();
//     });
//   }
//
//   void _updateDownloadStatus(String id, int progress, DownloadStatus status, {String? fileName, String? error}) {
//     _downloads = _downloads.map((item) {
//       if (item.id == id) {
//         return DownloadItem(
//           id: item.id,
//           fileName: fileName ?? item.fileName,
//           progress: progress,
//           status: status,
//         );
//       }
//       return item;
//     }).toList();
//     notifyListeners();
//   }
//
//   @override
//   void dispose() {
//     _downloadManager.dispose();
//     super.dispose();
//   }
// }
//
// class DownloaderApp extends StatefulWidget {
//   final String initialUrl;
//
//   const DownloaderApp({Key? key, this.initialUrl = ''}) : super(key: key);
//
//   @override
//   _DownloaderAppState createState() => _DownloaderAppState();
// }
//
// class _DownloaderAppState extends State<DownloaderApp> {
//   final _urlController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     if (widget.initialUrl.isNotEmpty) {
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         Provider.of<DownloadViewModel>(context, listen: false).startDownload(widget.initialUrl);
//         _urlController.clear();
//       });
//     }
//   }
//
//   @override
//   void dispose() {
//     _urlController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<DownloadViewModel>(
//       builder: (context, viewModel, child) {
//         return Scaffold(
//           appBar: AppBar(
//             title: const Text('Downloader'),
//           ),
//           body: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               children: [
//                 Card(
//                   child: Padding(
//                     padding: const EdgeInsets.all(12.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           '💡 Tip',
//                           style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                         Text(
//                           'Paste YouTube or other download links to start downloading.',
//                           style: Theme.of(context).textTheme.bodyMedium,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 TextField(
//                   controller: _urlController,
//                   decoration: InputDecoration(
//                     labelText: 'Download URL',
//                     hintText: 'Paste your download link here...',
//                     border: const OutlineInputBorder(),
//                     suffixIcon: _urlController.text.isNotEmpty
//                         ? IconButton(
//                       icon: const Icon(Icons.clear),
//                       onPressed: () {
//                         _urlController.clear();
//                         setState(() {});
//                       },
//                     )
//                         : null,
//                   ),
//                   maxLines: 3,
//                   onChanged: (value) {
//                     if (value.isNotEmpty && !viewModel.isLoading) {
//                       // Trigger download immediately for pasted or typed URLs
//                       viewModel.startDownload(value.trim());
//                       _urlController.clear();
//                       setState(() {});
//                     }
//                   },
//                   onSubmitted: (value) {
//                     if (!viewModel.isLoading && value.isNotEmpty) {
//                       viewModel.startDownload(value.trim());
//                       _urlController.clear();
//                     }
//                   },
//                 ),
//                 const SizedBox(height: 16),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: ElevatedButton(
//                         onPressed: viewModel.isLoading || _urlController.text.isEmpty
//                             ? null
//                             : () {
//                           viewModel.startDownload(_urlController.text.trim());
//                           _urlController.clear();
//                         },
//                         child: viewModel.isLoading
//                             ? const Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             SizedBox(
//                               width: 16,
//                               height: 16,
//                               child: CircularProgressIndicator(),
//                             ),
//                             SizedBox(width: 8),
//                             Text('Starting...'),
//                           ],
//                         )
//                             : const Text('Start Download'),
//                       ),
//                     ),
//                     const SizedBox(width: 8),
//                     OutlinedButton(
//                       onPressed: () async {
//                         final clipboardData = await Clipboard.getData('text/plain');
//                         final pastedText = clipboardData?.text ?? '';
//                         if (pastedText.isNotEmpty && !viewModel.isLoading) {
//                           _urlController.text = pastedText;
//                           viewModel.startDownload(pastedText.trim());
//                           _urlController.clear();
//                           setState(() {});
//                         }
//                       },
//                       child: const Icon(Icons.content_paste, size: 18),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 24),
//                 if (viewModel.downloads.isNotEmpty) ...[
//                   Text(
//                     'Downloads',
//                     style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Expanded(
//                     child: ListView.builder(
//                       itemCount: viewModel.downloads.length,
//                       itemBuilder: (context, index) {
//                         return DownloadItemCard(
//                           download: viewModel.downloads[index],
//                         );
//                       },
//                     ),
//                   ),
//                 ] else
//                   Expanded(
//                     child: Center(
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Text(
//                             '📁',
//                             style: Theme.of(context).textTheme.headlineLarge,
//                           ),
//                           Text(
//                             'No downloads yet',
//                             style: Theme.of(context).textTheme.bodyLarge,
//                           ),
//                           Text(
//                             'Add a download URL to start downloading',
//                             style: Theme.of(context).textTheme.bodyMedium,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
//
// class DownloadItemCard extends StatelessWidget {
//   final DownloadItem download;
//
//   const DownloadItemCard({Key? key, required this.download}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 4,
//       margin: const EdgeInsets.only(bottom: 8),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               download.fileName,
//               style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             const SizedBox(height: 8),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   download.status.name.toUpperCase(),
//                   style: Theme.of(context).textTheme.bodySmall?.copyWith(
//                     color: _getStatusColor(context, download.status),
//                   ),
//                 ),
//                 if (download.status == DownloadStatus.downloading)
//                   Text(
//                     '${download.progress}%',
//                     style: Theme.of(context).textTheme.bodySmall,
//                   ),
//               ],
//             ),
//             if (download.status == DownloadStatus.downloading) ...[
//               const SizedBox(height: 8),
//               LinearProgressIndicator(
//                 value: download.progress / 100,
//               ),
//             ],
//             if (download.status == DownloadStatus.failed)
//               Text(
//                 'Error: Failed to download',
//                 style: Theme.of(context).textTheme.bodySmall?.copyWith(
//                   color: Theme.of(context).colorScheme.error,
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Color _getStatusColor(BuildContext context, DownloadStatus status) {
//     switch (status) {
//       case DownloadStatus.completed:
//         return Theme.of(context).colorScheme.primary;
//       case DownloadStatus.failed:
//         return Theme.of(context).colorScheme.error;
//       case DownloadStatus.downloading:
//         return Theme.of(context).colorScheme.secondary;
//       default:
//         return Theme.of(context).colorScheme.onSurface;
//     }
//   }
// }
