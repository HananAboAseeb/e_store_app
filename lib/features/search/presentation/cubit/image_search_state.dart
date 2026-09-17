import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/image_search_result_entity.dart';

abstract class ImageSearchState extends Equatable {
  const ImageSearchState();

  @override
  List<Object?> get props => [];
}

class ImageSearchInitial extends ImageSearchState {
  const ImageSearchInitial();
}

class ImageSearchCapturing extends ImageSearchState {
  const ImageSearchCapturing();
}

class ImageSearchRecognized extends ImageSearchState {
  final String imagePath;
  final ImageSearchResultEntity result;

  const ImageSearchRecognized({
    required this.imagePath,
    required this.result,
  });

  @override
  List<Object?> get props => [imagePath, result];
}

class ImageSearchResultsSheetVisible extends ImageSearchState {
  final String imagePath;
  final ImageSearchResultEntity result;

  const ImageSearchResultsSheetVisible({
    required this.imagePath,
    required this.result,
  });

  @override
  List<Object?> get props => [imagePath, result];
}

class ImageSearchError extends ImageSearchState {
  final Failure failure;

  const ImageSearchError({required this.failure});

  @override
  List<Object?> get props => [failure];
}
