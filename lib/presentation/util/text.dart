import 'dart:math';

const SUMMARY_MAX_SIZE = 100;

String summarize(String text, int maxSize) {
  var summary = text.substring(0, min(SUMMARY_MAX_SIZE, text.length));
  if(text.length > SUMMARY_MAX_SIZE) {
    summary += "...";
  }
  return summary;
}