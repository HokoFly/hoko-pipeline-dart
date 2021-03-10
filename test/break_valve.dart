import 'package:wtpipeline/src/pipeline_context.dart';
import 'package:wtpipeline/src/valve.dart';

class BreakValve implements Valve {
  @override
  void invoke(PipelineContext pipelineContext) {
    print("BreakValve");
    pipelineContext.breakPipeline();
  }

  @override
  String label() => "BreakValve";
}