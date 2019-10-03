class ReportSentryErrorAction {
  final dynamic error;
  final StackTrace stackTrace;
  final String message;

  ReportSentryErrorAction(this.error, this.stackTrace, this.message);
}

class ReportSentryInfoAction{
  final String actionName;

  ReportSentryInfoAction(this.actionName);
}