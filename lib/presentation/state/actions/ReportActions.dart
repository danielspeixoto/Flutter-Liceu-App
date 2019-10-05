
//Submits

class SubmitReportAction {
  final String message;
  final List<String> tags;
  final Map<String, dynamic> params;

  SubmitReportAction(this.message, this.tags, this.params);
}

class SubmitReportSuccessAction {}