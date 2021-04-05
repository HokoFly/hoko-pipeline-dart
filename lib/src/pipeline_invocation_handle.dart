import 'package:wtpipeline/src/labelable.dart';
import 'package:wtpipeline/src/pipeline_states.dart';

/**
 * 代表一次pipeline的执行过程
 *
 * Created by yuxiaofei on 2021/2/8
 */
abstract class PipelineInvocationHandle implements PipelineStates, Cancelable {
  /**
   * 执行pipeline
   */
  void invoke();

  /**
   * 取消这次执行
   */
  void cancel();
}
