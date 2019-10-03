class ReportSentryErrorAction {
  final dynamic error;
  final StackTrace stackTrace;
  final String message;
  final Map <String, dynamic> parameters;

  ReportSentryErrorAction(this.error, this.stackTrace, this.message, [this.parameters]);
}

class ReportSentryInfoAction{
  final String actionName;

  ReportSentryInfoAction(this.actionName);
}