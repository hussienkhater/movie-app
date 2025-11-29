part of 'test_feature_cubit.dart';

@immutable
sealed class TestFeatureState {}

final class TestFeatureInitial extends TestFeatureState {}

class LoadingState extends TestFeatureState {}

class SuccessState extends TestFeatureState {}

class ErrorState extends TestFeatureState {
  final String message;
  ErrorState(this.message);
}