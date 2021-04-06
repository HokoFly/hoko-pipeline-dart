import 'package:wtpipeline/src/pipeline_context.dart';
import 'package:wtpipeline/src/valve.dart';

class Print1Valve implements Valve {
  String _label;

  @override
  void invoke(PipelineContext pipelineContext) {
    _asyncInvoke(pipelineContext);
  }

  void _asyncInvoke(PipelineContext pipelineContext) async {
    await print("Print1 Valve");
    pipelineContext.invokeNext();
  }

  @override
  String label() => _label;

  void setLabel(String label) {
    _label = label;
  }
}
