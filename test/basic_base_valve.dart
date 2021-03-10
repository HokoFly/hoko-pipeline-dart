import 'package:wtpipeline/src/pipeline_context.dart';
import 'package:wtpipeline/src/valve.dart';

class BasicBaseValve implements BasicValve {
  @override
  void invoke(BasicPipelineContext pipelineContext) {
    print("BasicBaseValve");
    pipelineContext.invokeNext();
  }

  @override
  String label() => "BasicBaseValve";
}