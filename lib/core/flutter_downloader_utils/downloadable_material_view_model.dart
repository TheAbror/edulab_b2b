import 'package:flutter_downloader/flutter_downloader.dart';

class DownloadableMaterialViewModel {
  final String name;
  final String src;
  final String url;
  int progress;
  DownloadTaskStatus status;
  String? fileDownloadId;

  DownloadableMaterialViewModel({
    required this.name,
    required this.src,
    required this.url,
    required this.status,
    required this.progress,
    this.fileDownloadId,
  });

  // DownloadableMaterialViewModel.fromMaterial(ContentResponseMaterials material)
  //     : name = material.name,
  //       src = material.src,
  //       url = material.url,
  //       status = DownloadTaskStatus.undefined,
  //       progress = 0;
}
