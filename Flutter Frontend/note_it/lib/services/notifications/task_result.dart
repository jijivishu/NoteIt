class TaskResult<T> {
  final bool success;
  final String message;
  T? data;

  TaskResult({
    required this.success,
    required this.message,
    this.data,
  });

  factory TaskResult.success({T? data, required String message}) => TaskResult(success: true, message: message, data: data);
  factory TaskResult.failure({T? data, required String message}) => TaskResult(success: false, message: message, data: data);
}
