import 'package:hoko_pipeline/hoko_pipeline.dart';

class BreakValve implements Valve {
  @override
  void invoke(PipelineContext pipelineContext) {
    print("BreakValve");
    pipelineContext.breakPipeline();
  }

  @override
  String label() => "BreakValve";
}