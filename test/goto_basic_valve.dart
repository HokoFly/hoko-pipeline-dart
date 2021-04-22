import 'package:hoko_pipeline/hoko_pipeline.dart';

class GotoBasicValve implements Valve {
  @override
  void invoke(PipelineContext pipelineContext) {
    try {
      pipelineContext.gotoLabelAndInvoke("BasicBaseValve");
    } on NoLabelFoundException {
      pipelineContext.invokeNext();
    }
  }

  @override
  String label() => "GotoBasicValve";
}