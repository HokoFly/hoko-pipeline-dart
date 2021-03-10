import 'package:wtpipeline/src/exception/no_label_found_exception.dart';
import 'package:wtpipeline/src/pipeline_context.dart';
import 'package:wtpipeline/src/valve.dart';

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