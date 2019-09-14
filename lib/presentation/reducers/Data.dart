class Data<T> {
  final T content;
  final bool isLoading;
  final String errorMessage;

  Data({
    this.content,
    this.isLoading = true,
    this.errorMessage = "",
  });

  Data copyWith({T content, bool isLoading, String errorMessage}) {
    final data = Data(
      content: content ?? this.content,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
    return data;
  }
}
