import 'package:wtpipeline/src/pipeline_context.dart';
import 'package:wtpipeline/src/valve.dart';

class CancelValve implements Valve {
  @override
  void invoke(PipelineContext pipelineContext) {
    print("CancelValve");
    //todo 延时2s调用
    pipelineContext.invokeNext();
  }

  @override
  String label() => "CancelValve";
}