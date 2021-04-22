import 'package:hoko_pipeline/hoko_pipeline.dart';

class GotoNoLabelValve implements Valve {
  @override
  void invoke(PipelineContext pipelineContext) {
    print("GotoNoLabelValve");
    var attributes = pipelineContext.getAttributeMap();
    print(attributes);
    try {
      pipelineContext.gotoLabelAndInvoke("NotExistedLabel");
    } on NoLabelFoundException {
      pipelineContext.invokeNext();
    }
  }

  @override
  String label() => "GotoNoLabelValve";
}