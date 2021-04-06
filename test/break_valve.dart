import 'package:wtpipeline/wtpipeline.dart';

class BreakValve implements Valve {
  @override
  void invoke(PipelineContext pipelineContext) {
    print("BreakValve");
    pipelineContext.breakPipeline();
  }

  @override
  String label() => "BreakValve";
}