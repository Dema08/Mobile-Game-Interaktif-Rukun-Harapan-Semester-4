// lib/data/network/response_call.dart

enum Status { iddle, loading, completed, error }

class ResponseCall<T> {
  final Status status;
  final T? data;
  final String? message;

  const ResponseCall.iddle(this.message)
      : status = Status.iddle,
        data = null;

  const ResponseCall.loading(this.message)
      : status = Status.loading,
        data = null;

  const ResponseCall.completed(this.data)
      : status = Status.completed,
        message = null;

  const ResponseCall.error(this.message)
      : status = Status.error,
        data = null;

  @override
  String toString() {
    return "Status: $status\nMessage: $message\nData: $data";
  }
}
