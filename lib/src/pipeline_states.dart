/**
 * Pipeline的状态接口
 *
 * Created by yuxiaofei on 2021/2/8
 */
abstract class PipelineStates {
  /**
   * pipeline是否执行完毕
   */
  bool isFinish();

  /**
   * 检查pipeline将是否被中断
   */
  bool isBroken();

  /**
   * pipeline是否被取消了
   */
  bool isCanceled();

  /**
   * 取得当前pipeline执行的状态的整个上下文的Map。
   */
  Map<String, Object> getAttributeMap();

  /**
   * 获取外部的上下文，自定义数据
   */
  T getOuterContext<T>();

  /**
   * 设置外部的上下文，自定义数据
   */
  void setOuterContext<T>(T context);
}
