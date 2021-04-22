import 'package:hoko_pipeline/src/cancelable.dart';
import 'package:hoko_pipeline/src/pipeline_states.dart';

/**
 * 代表一次pipeline的执行过程
 *
 * Created by yuxiaofei on 2021/2/8
 */
abstract class PipelineInvocationHandle implements PipelineStates, Cancelable {
  /**
   * 执行pipeline
   */
  Future invoke();

  /**
   * 取消这次执行
   */
  void cancel();
}
