import 'package:hoko_pipeline/hoko_pipeline.dart';

class RetryValve implements Valve {
  String _retryStartLabel;

  @override
  void invoke(PipelineContext pipelineContext) {
    var mockContext = pipelineContext.getOuterContext();
    if (mockContext.isLimitedRetryTime()) {
      print("Retry overtime");
      pipelineContext.invokeNext();
      return;
    }
    mockContext.addRetryTime();
    try {
      print("Retry");
      pipelineContext.gotoLabelAndInvoke(_retryStartLabel);
    } on NoLabelFoundException catch (e) {
      print(e.message);
    }
  }

  @override
  String label() => "RetryValve";

  void setRetryStartLabel(String retryStartLabel) {
    _retryStartLabel = retryStartLabel;
  }
}
