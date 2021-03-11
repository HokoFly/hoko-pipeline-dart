import 'package:wtpipeline/src/pipeline_context.dart';
import 'package:wtpipeline/src/valve.dart';

class Print1Valve implements Valve {
  String _label;

  @override
  void invoke(PipelineContext pipelineContext) {
    print("Print1 Valve");
    //todo 多线程调用
    pipelineContext.invokeNext();
  }

  @override
  String label() => _label;

  void setLabel(String label) {
    _label = label;
  }
}
