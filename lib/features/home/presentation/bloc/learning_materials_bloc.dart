import 'package:edulab_b2b/widget_imports.dart';

class LessonMaterialState {
  final List<DownloadableMaterialViewModel> downloadableMaterialViewModelsList;
  final String? localPath;
  final String? downloadId;
  final int? progress;
  final bool isLoading;

  LessonMaterialState({
    required this.downloadableMaterialViewModelsList,
    this.isLoading = false,
    this.localPath,
    this.downloadId,
    this.progress,
  });

  LessonMaterialState copyWith({
    List<DownloadableMaterialViewModel>? downloadableMaterialViewModelsList,
    bool? isLoading,
    String? localPath,
    String? downloadId,
    int? progress,
  }) {
    return LessonMaterialState(
      downloadableMaterialViewModelsList:
          downloadableMaterialViewModelsList ??
          this.downloadableMaterialViewModelsList,
      isLoading: isLoading ?? this.isLoading,
      localPath: localPath ?? this.localPath,
      downloadId: downloadId ?? this.downloadId,
      progress: progress ?? this.progress,
    );
  }
}

class LessonMaterialBloc extends Cubit<LessonMaterialState> {
  final List<DownloadableMaterialViewModel> downloadableMaterialViewModelsList;

  LessonMaterialBloc({required this.downloadableMaterialViewModelsList})
    : super(
        LessonMaterialState(
          downloadableMaterialViewModelsList:
              downloadableMaterialViewModelsList,
        ),
      );

  Future<void> findLocalPath({
    required String moduleName,
    required String lessonName,
  }) async {
    final academicYear = '2023/2024'.replaceAll('/', '-');

    String localPath = '';

    if (Platform.isAndroid) {
      final externalStorage = await getExternalStorageDirectory();

      if (externalStorage != null) {
        localPath =
            '${externalStorage.path}/${AppStrings.projetName}/LessonMaterials/$academicYear/$moduleName';
      }
    } else {
      localPath =
          '${(await getApplicationDocumentsDirectory()).path}/${AppStrings.projetName}/LessonMaterials/$academicYear/$moduleName';
    }

    await checkDocumentExist(localPath);

    final savedDir = Directory(localPath);

    bool hasExisted = await savedDir.exists();

    if (!hasExisted) {
      savedDir.create(recursive: true);
    }

    emit(state.copyWith(localPath: localPath));
  }

  void updateFileDownload(
    int progress,
    DownloadTaskStatus status,
    String downloadId,
  ) async {
    Future.delayed(const Duration(milliseconds: 300));

    // ignore: avoid_print
    print(downloadId);

    final files = state.downloadableMaterialViewModelsList.where(
      (i) => i.fileDownloadId == downloadId,
    );

    if (files.isNotEmpty) {
      final file = files.first;

      file.status = status;
      file.progress = progress;

      emit(
        state.copyWith(
          downloadableMaterialViewModelsList:
              state.downloadableMaterialViewModelsList,
          downloadId: downloadId,
          progress: progress,
        ),
      );
    }
  }

  void updateFileDownloadId(String? title, String downloadId) async {
    if (state.downloadableMaterialViewModelsList.any((i) => i.name == title)) {
      final file = state.downloadableMaterialViewModelsList.firstWhere(
        (i) => i.name == title,
      );

      file.fileDownloadId = downloadId;

      emit(
        state.copyWith(
          downloadableMaterialViewModelsList:
              state.downloadableMaterialViewModelsList,
          downloadId: downloadId,
        ),
      );
    }
  }

  Future<void> checkDocumentExist(String localPath) async {
    if (state.downloadableMaterialViewModelsList.isNotEmpty) {
      await Future.forEach(state.downloadableMaterialViewModelsList, (
        DownloadableMaterialViewModel item,
      ) async {
        File path = File('$localPath/${item.src.split('/').last}');
        bool fileExist = await path.exists();

        if (fileExist) {
          item.status = DownloadTaskStatus.complete;
        } else {
          item.status = DownloadTaskStatus.undefined;
        }
      });

      emit(
        state.copyWith(
          downloadableMaterialViewModelsList:
              state.downloadableMaterialViewModelsList,
        ),
      );
    }
  }
}
