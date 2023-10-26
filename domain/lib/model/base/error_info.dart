class ErrorInfo {
  final String message;
  final int? code;
  final String content;
  final String description;

  ErrorInfo({
    required this.message,
    this.code,
    this.content: '',
    this.description: '',
  });
}
