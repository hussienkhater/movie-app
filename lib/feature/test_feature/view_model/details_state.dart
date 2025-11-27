import 'package:equatable/equatable.dart';
import 'package:movie_app/feature/test_feature/data/model/details_model.dart';

enum DetailsStatus { initial, loading, success, failure }

class DetailsState extends Equatable {
  final DetailsStatus status;
  final MovieDetailsModel? details;
  final List<SimilarMovie> similar;
  final String? errorMessage;

  const DetailsState({
    this.status = DetailsStatus.initial,
    this.details,
    this.similar = const [],
    this.errorMessage,
  });

  DetailsState copyWith({
    DetailsStatus? status,
    MovieDetailsModel? details,
    List<SimilarMovie>? similar,
    String? errorMessage,
  }) {
    return DetailsState(
      status: status ?? this.status,
      details: details ?? this.details,
      similar: similar ?? this.similar,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, details, similar, errorMessage];
}
