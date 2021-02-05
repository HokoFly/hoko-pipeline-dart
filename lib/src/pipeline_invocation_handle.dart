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

  /**
   * 等待pipeline执行完成，异步支持
   */
  void await();

  /**
   * 等待pipeline执行完成，不被打断
   */
  void awaitUninterruptibly();

  /**
   * 在设置超时时间内，等待pipeline执行完成
   */
  bool awaitTimeout(Duration timeout);
}
