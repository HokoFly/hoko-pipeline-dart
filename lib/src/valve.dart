import 'package:wtpipeline/src/cancelable.dart';
import 'package:wtpipeline/src/pipeline_context.dart';

/**
 * Pipeline的一个基础阀门，不同于[Valve]，该阀门是最终必须要执行的
 *
 * Created by yuxiaofei on 2021/2/8
 */
abstract class BasicValve implements Labelable {
  /**
   * 执行阀门内的具体操作
   */
  void invoke(BasicPipelineContext basicPipelineContext);
}

/**
 * Pipeline的一个阀门
 *
 * Created by yuxiaofei on 2021/2/8
 */
abstract class Valve implements Labelable {
  /**
   * 执行阀门内的具体操作
   */
  void invoke(PipelineContext pipelineContext);
}