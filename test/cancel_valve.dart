import 'package:wtpipeline/src/pipeline_context.dart';
import 'package:wtpipeline/src/valve.dart';

class CancelValve implements Valve {
  @override
  void invoke(PipelineContext pipelineContext) {
    print("CancelValve");
    Future.delayed(Duration(seconds: 2), () => {
      pipelineContext.invokeNext()
    });
  }

  @override
  String label() => "CancelValve";
}