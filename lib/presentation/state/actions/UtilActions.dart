class OnCatchDefaultErrorAction {
  final dynamic error;
  final StackTrace stackTrace;
  final String message;
  final Map <String, dynamic> parameters;

  OnCatchDefaultErrorAction(this.error, this.stackTrace, this.message, [this.parameters]);
}

class OnThrowDataExceptionAction {
  final Exception exception;
  final String className;

  OnThrowDataExceptionAction(this.exception, this.className);
}