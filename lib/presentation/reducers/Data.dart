class Data<T> {
  final T content;
  final bool isLoading;
  final String errorMessage;

  Data({
    this.content,
    this.isLoading = false,
    this.errorMessage = "",
  });

  Data copyWith({T content, bool isLoading, String errorMessage}) {
    return Data(
      content: content ?? this.content,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
