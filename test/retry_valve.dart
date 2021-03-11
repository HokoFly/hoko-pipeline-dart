import 'package:wtpipeline/src/exception/no_label_found_exception.dart';
import 'package:wtpipeline/src/pipeline_context.dart';
import 'package:wtpipeline/src/valve.dart';

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
