import 'dart:math';

const SUMMARY_MAX_SIZE = 100;

String summarize(String text, int maxSize) {
  var summary = text.substring(0, min(maxSize, text.length));
  if(text.length > maxSize) {
    summary += "...";
  }
  return summary;
}