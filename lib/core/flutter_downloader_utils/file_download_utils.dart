import 'package:edulab_b2b/widget_imports.dart';
import 'package:permission_handler/permission_handler.dart';

class FileDownloadUtils {
  static double getProcessPercent(
    DownloadTaskStatus status,
    DownloadableMaterialViewModel material,
  ) {
    if (status == DownloadTaskStatus.complete) {
      return 1;
    }

    return material.progress / 100;
  }

  static Color getDownloaderColor(DownloadTaskStatus status) {
    if (DownloadTaskStatus.paused == status) {
      return Colors.orange;
    } else if (DownloadTaskStatus.complete == status) {
      return Colors.lightGreen;
    } else if (DownloadTaskStatus.failed == status) {
      return Colors.red;
    } else {
      return NewColorsLight.accentDefault;
    }
  }

  static Widget getDownloadIcon(DownloadTaskStatus status) {
    Widget downloadIcon;
    status == DownloadTaskStatus.running
        ? downloadIcon = const Icon(Icons.pause)
        : status == DownloadTaskStatus.paused
        ? downloadIcon = const Icon(Icons.play_arrow)
        : status == DownloadTaskStatus.complete
        ? downloadIcon = const Icon(Icons.done)
        : status == DownloadTaskStatus.failed
        ? downloadIcon = const Icon(Icons.refresh)
        : downloadIcon = const Icon(Icons.cloud_download);
    return downloadIcon;
  }

  static Future<bool> requestDownload(
    BuildContext context,
    DownloadableMaterialViewModel material,
    String localPath,
    Function emitDownloadId,
  ) async {
    bool permission = false;

    _checkPermission().then((hasGranted) {
      permission = hasGranted;
    });

    final url = material.url;

    material.fileDownloadId = await FlutterDownloader.enqueue(
      url: url,
      savedDir: localPath,
      showNotification: true,
      fileName: material.src.split('/').last,
      openFileFromNotification: true,
    );

    emitDownloadId(material.fileDownloadId);

    return permission;
  }

  static Future<bool> _checkPermission() async {
    if (Platform.isAndroid) {
      PermissionStatus permission = await Permission.storage.status;
      if (permission != PermissionStatus.granted) {
        PermissionStatus permission = await Permission.storage.request();
        if (permission.isGranted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }

  static void cancelDownload(DownloadableMaterialViewModel material) async {
    if (material.fileDownloadId != null) {
      await FlutterDownloader.cancel(taskId: material.fileDownloadId!);
    }
  }

  static void pauseDownload(DownloadableMaterialViewModel material) async {
    if (material.fileDownloadId != null) {
      await FlutterDownloader.pause(taskId: material.fileDownloadId!);
    }
  }

  static void resumeDownload(DownloadableMaterialViewModel material) async {
    if (material.fileDownloadId != null) {
      String? newTaskId = await FlutterDownloader.resume(
        taskId: material.fileDownloadId!,
      );

      material.fileDownloadId = newTaskId ?? '';
    }
  }

  static void retryDownload(DownloadableMaterialViewModel material) async {
    if (material.fileDownloadId != null) {
      String? newTaskId = await FlutterDownloader.retry(
        taskId: material.fileDownloadId!,
      );

      material.fileDownloadId = newTaskId ?? '';
    }
  }

  static openFile(
    BuildContext context,
    DownloadableMaterialViewModel material,
    String localPath,
    Function emitDownloadId,
  ) async {
    // ignore: unused_local_variable
    final path = '$localPath/${material.src.split('/').last}';

    material.status == DownloadTaskStatus.complete
        ?
          // ? OpenFile.open(path)
          // :
          requestDownload(
            context,
            material,
            localPath,
            emitDownloadId,
          )
        : null;
  }
}
