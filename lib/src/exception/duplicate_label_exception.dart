/**
 * 因为有相同的Label导致的异常
 *
 * Created by yuxiaofei on 2021/2/8
 */
class DuplicateLabelException implements Exception {
  final String message;
  final dynamic source;

  const DuplicateLabelException([this.message = "", this.source]);

  @override
  String toString() => "DuplicateLabelException : $message" + source == null
      ? ""
      : ", caused by $source.";
}