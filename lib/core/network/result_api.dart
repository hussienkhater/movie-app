abstract class ResultApi<T> {}

class Loading<T> extends ResultApi<T> {}

class Success<T> extends ResultApi<T> {}

class Error<T> extends ResultApi<T> {
  final String message;
  Error(this.message);
}