import 'package:wtpipeline/src/labelable.dart';
import 'package:wtpipeline/src/pipeline_states.dart';

/**
 * 基础功能的Pipeline上下文
 *
 * Created by yuxiaofei on 2021/2/8
 */
abstract class BasicPipelineContext implements PipelineStates {
  /**
   * 执行下一个阀门
   */
  void invokeNext();

  /**
   * 增加一个可被取消的行为,在自己被终止的时候也能去终止下面的行为
   */
  void addCancelable(Cancelable cancelable);

  /**
   * 不需要被cancel的时候 移除
   */
  void removeCancelable(Cancelable cancelable);
}

/**
 * Pipeline 上下文
 * 是由pipeline提供给valve的一个上下文对象，它代表了当前pipeline的执行状态，并控制pipeline的执行步骤。
 *
 * Created by yuxiaofei on 2021/2/8
 */
abstract class PipelineContext implements BasicPipelineContext {
  /**
   * 跳到对应的lable的阀门,然后执行
   */
  void gotoLabelAndInvoke(String label);

  /**
   * 中断当前Pipeline执行
   */
  void breakPipeline();
}
