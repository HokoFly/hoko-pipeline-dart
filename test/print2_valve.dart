import 'package:wtpipeline/src/exception/no_label_found_exception.dart';
import 'package:wtpipeline/src/pipeline_context.dart';
import 'package:wtpipeline/src/valve.dart';

class Print2Valve implements Valve {
  @override
  void invoke(PipelineContext pipelineContext) {
    print("Print2 Valve");
    //todo 多线程调用
    pipelineContext.invokeNext();
  }

  @override
  String label() => "Print2Valve";

}