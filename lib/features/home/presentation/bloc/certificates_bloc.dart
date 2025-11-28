import 'package:leti_mobile/widget_imports.dart';

part 'certificates_state.dart';

class CertificatesBloc extends Cubit<CertificatesState> {
  CertificatesBloc() : super(CertificatesState.initial());

  void changeTabIndex(int index) {
    emit(state.copyWith(tabIndex: index));
  }

  // void getAllTopics() async {
  //   emit(state.copyWith(blocProgress: BlocProgress.IS_LOADING));

  //   try {
  //     final response = await ApiProvider.certificatesServices.getAllTopics();

  //     if (response.isSuccessful) {
  //       final data = response.body;
  //       String allText = 'All';

  //       final settings = settingsBox.get(ShPrefKeys.projectSettings);
  //       final userLang = settings.lang ?? 'English';

  //       if (userLang == 'Русский') {
  //         allText = 'Все';
  //       } else if (userLang == 'O’zbek') {
  //         allText = 'Hammasi';
  //       } else {
  //         allText = 'All';
  //       }

  //       if (data != null) {
  //         final topics = data.content;
  //         topics.insert(0, AllTopicsContentResponse(id: 0, name: allText));

  //         emit(
  //           state.copyWith(
  //             topics: topics,
  //             blocProgress: BlocProgress.LOADED,
  //           ),
  //         );
  //       }
  //     } else {
  //       final error =
  //           ErrorResponse.fromJson(json.decode(response.error.toString()));

  //       emit(state.copyWith(
  //         blocProgress: BlocProgress.FAILED,
  //         failureMessage: error.message,
  //       ));
  //     }
  //   } catch (e) {
  //     if (!isClosed) {
  //       emit(state.copyWith(
  //         blocProgress: BlocProgress.FAILED,
  //         failureMessage: AppStrings.internalErrorMessage,
  //       ));
  //       debugPrint('$e');
  //     }
  //   }
  // }

  void getCertificatesByTopicID({int? topicId}) async {
    emit(state.copyWith(blocProgress: BlocProgress.IS_LOADING));

    try {
      final response = await ApiProvider.certificatesServices
          .getCertificatesByTopicID(topicId ?? 0);

      if (response.isSuccessful) {
        final data = response.body;

        if (data != null) {
          emit(
            state.copyWith(
              certificates: data,
              blocProgress: BlocProgress.LOADED,
            ),
          );
        }
      } else {
        final error = ErrorResponse.fromJson(
          json.decode(response.error.toString()),
        );

        emit(
          state.copyWith(
            blocProgress: BlocProgress.FAILED,
            failureMessage: error.message,
          ),
        );
      }
    } catch (e) {
      if (!isClosed) {
        emit(
          state.copyWith(
            blocProgress: BlocProgress.FAILED,
            failureMessage: AppStrings.internalErrorMessage,
          ),
        );
        debugPrint('$e');
      }
    }
  }
}
