import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'test_feature_state.dart';

class TestFeatureCubit extends Cubit<TestFeatureState> {
  TestFeatureCubit() : super(TestFeatureInitial());
}
