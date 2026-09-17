import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/search_by_image_usecase.dart';
import 'image_search_state.dart';

class ImageSearchCubit extends Cubit<ImageSearchState> {
  final SearchByImageUseCase searchByImageUseCase;

  static const String defaultMockImage = 'assets/images/cat_cloth_1.png';

  ImageSearchCubit({required this.searchByImageUseCase})
      : super(const ImageSearchInitial());

  Future<void> captureImage() async {
    emit(const ImageSearchCapturing());
    // Simulate recognition latency
    await Future.delayed(const Duration(milliseconds: 300));

    final result = await searchByImageUseCase(defaultMockImage);
    result.fold(
      (failure) => emit(ImageSearchError(failure: failure)),
      (searchResult) => emit(
        ImageSearchRecognized(
          imagePath: defaultMockImage,
          result: searchResult,
        ),
      ),
    );
  }

  Future<void> pickFromGallery() async {
    emit(const ImageSearchCapturing());
    await Future.delayed(const Duration(milliseconds: 300));

    final result = await searchByImageUseCase(defaultMockImage);
    result.fold(
      (failure) => emit(ImageSearchError(failure: failure)),
      (searchResult) => emit(
        ImageSearchRecognized(
          imagePath: defaultMockImage,
          result: searchResult,
        ),
      ),
    );
  }

  void retry() {
    emit(const ImageSearchInitial());
  }

  void showResultsSheet() {
    if (state is ImageSearchRecognized) {
      final current = state as ImageSearchRecognized;
      emit(
        ImageSearchResultsSheetVisible(
          imagePath: current.imagePath,
          result: current.result,
        ),
      );
    }
  }

  void dismissResultsSheet() {
    if (state is ImageSearchResultsSheetVisible) {
      final current = state as ImageSearchResultsSheetVisible;
      emit(
        ImageSearchRecognized(
          imagePath: current.imagePath,
          result: current.result,
        ),
      );
    }
  }
}
