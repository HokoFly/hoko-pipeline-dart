/**
 * 没有找到Label导致的异常
 *
 * Created by yuxiaofei on 2021/2/8
 */
class NoLabelFoundException implements Exception {
  final String message;
  final dynamic source;

  const NoLabelFoundException([this.message = "", this.source]);

  @override
  String toString() => "NoLabelFoundException : $message" + source == null
      ? ""
      : ", caused by $source.";
}
