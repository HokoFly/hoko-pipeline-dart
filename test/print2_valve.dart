import 'dart:isolate';

import 'package:hoko_pipeline/hoko_pipeline.dart';

class Print2Valve implements Valve {
  @override
  void invoke(PipelineContext pipelineContext) {
    print("Print2 Valve in: ${Isolate.current.debugName}");
    pipelineContext.invokeNext();
  }

  @override
  String label() => "Print2Valve";
}
