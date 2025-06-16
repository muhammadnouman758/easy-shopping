import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tera/view_model.dart';


class TeraBoxDownloaderApp extends StatefulWidget {
  final String initialUrl;

  const TeraBoxDownloaderApp({Key? key, this.initialUrl = ''}) : super(key: key);

  @override
  _TeraBoxDownloaderAppState createState() => _TeraBoxDownloaderAppState();
}

class _TeraBoxDownloaderAppState extends State<TeraBoxDownloaderApp> {
  final _urlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.initialUrl.isNotEmpty) {
      _urlController.text = widget.initialUrl;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showDownloadDialog(context, widget.initialUrl);
      });
    }
  }

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  void _showDownloadDialog(BuildContext context, String url) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Download TeraBox File?'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Do you want to download this file?'),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(8),
              color: Theme.of(context).colorScheme.surface,
              child: Text(
                url,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _urlController.clear();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Provider.of<DownloadViewModel>(context, listen: false)
                  .startDownload(url);
            },
            child: const Text('Download'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DownloadViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('TeraBox Downloader'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '💡 Tip',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Paste TeraBox links directly below to start downloading.',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _urlController,
                  decoration: InputDecoration(
                    labelText: 'TeraBox URL',
                    hintText: 'Paste your TeraBox link here...',
                    border: const OutlineInputBorder(),
                    suffixIcon: _urlController.text.isNotEmpty
                        ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () => _urlController.clear(),
                    )
                        : null,
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: viewModel.isLoading || _urlController.text.isEmpty
                            ? null
                            : () {
                          viewModel.startDownload(_urlController.text);
                          _urlController.clear();
                        },
                        child: viewModel.isLoading
                            ? const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(),
                            ),
                            SizedBox(width: 8),
                            Text('Starting...'),
                          ],
                        )
                            : const Text('Start Download'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    OutlinedButton(
                      onPressed: () async {
                        final clipboardData = await Clipboard.getData('text/plain');
                        final pastedText = clipboardData?.text ?? '';
                        if (viewModel.isValidTeraBoxUrl(pastedText)) {
                          _urlController.text = pastedText;
                        }
                      },
                      child: const Icon(Icons.content_paste, size: 18),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                if (viewModel.downloads.isNotEmpty) ...[
                  Text(
                    'Downloads',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: ListView.builder(
                      itemCount: viewModel.downloads.length,
                      itemBuilder: (context, index) {
                        return DownloadItemCard(
                          download: viewModel.downloads[index],
                        );
                      },
                    ),
                  ),
                ] else
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '📁',
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                          Text(
                            'No downloads yet',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Text(
                            'Add a TeraBox URL to start downloading',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class DownloadItemCard extends StatelessWidget {
  final DownloadItem download;

  const DownloadItemCard({Key? key, required this.download}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              download.fileName,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  download.status.name.toUpperCase(),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: _getStatusColor(context, download.status),
                  ),
                ),
                if (download.status == DownloadStatus.downloading)
                  Text(
                    '${download.progress}%',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
              ],
            ),
            if (download.status == DownloadStatus.downloading) ...[
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: download.progress / 100,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(BuildContext context, DownloadStatus status) {
    switch (status) {
      case DownloadStatus.completed:
        return Theme.of(context).colorScheme.primary;
      case DownloadStatus.failed:
        return Theme.of(context).colorScheme.error;
      case DownloadStatus.downloading:
        return Theme.of(context).colorScheme.secondary;
      default:
        return Theme.of(context).colorScheme.onSurface;
    }
  }
}