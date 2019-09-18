import 'dart:math';

const SUMMARY_MAX_SIZE = 100;

String summarize(String text, int maxSize) {
  var summary = text.substring(0, min(maxSize, text.length));
  if(text.length > maxSize + 3) {
    summary = text.substring(0, summary.length - 3);
    summary += "...";
  }
  return summary;
}