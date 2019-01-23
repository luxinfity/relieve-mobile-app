class BaseResponse {
  final String message;
  final int status;
  final dynamic content;

  BaseResponse(
    this.message,
    this.status,
    this.content,
  );
}
