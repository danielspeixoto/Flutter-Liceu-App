StackTrace filter(StackTrace stackTrace) {
  List<String> stackTraceString = stackTrace.toString().split("\n").toList();

  for (var i = 0; i < stackTraceString.length; i++) {
    if (stackTraceString[i].contains('store.dart') ||
        stackTraceString[i].contains('utils.dart') ||
        stackTraceString[i].contains('framework.dart') ||
        stackTraceString[i].contains('binding.dart') ||
        stackTraceString[i].contains('flutter_redux.dart') ||
        stackTraceString[i].contains('overlay.dart') ||
        stackTraceString[i].contains('inherited_notifier.dart')) {
      stackTraceString[i] = '';
    }
  }

  List<String> stackTraceFinal = [];

  for (var i = 0; i < stackTraceString.length; i++) {
    if (stackTraceString[i] != '') {
      stackTraceFinal.add(stackTraceString[i]);
    }
  }

  return new StackTrace.fromString(stackTraceFinal.join("\n"));
}
