import 'package:hoko_pipeline/hoko_pipeline.dart';

class BasicBaseValve implements BasicValve {
  @override
  void invoke(BasicPipelineContext pipelineContext) {
    print("BasicBaseValve");
    pipelineContext.invokeNext();
  }

  @override
  String label() => "BasicBaseValve";
}