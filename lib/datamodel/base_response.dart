class BaseResponse<T> {
  final String message;
  final int status;
  final T content;

  BaseResponse(
    this.message,
    this.status,
    this.content,
  );
}
