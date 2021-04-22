import 'package:hoko_pipeline/src/pipeline_invocation_handle.dart';

/**
 * Pipeline的抽象接口
 *
 * Created by yuxiaofei on 2021/2/8
 */
abstract class Pipeline {
  /**
   * 创建一次新的执行
   */
  PipelineInvocationHandle newInvocation();
}
