import 'package:wtpipeline/src/exception/no_label_found_exception.dart';
import 'package:wtpipeline/src/pipeline_context.dart';
import 'package:wtpipeline/src/valve.dart';

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