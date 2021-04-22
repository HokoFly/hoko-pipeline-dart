import 'package:hoko_pipeline/hoko_pipeline.dart';

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