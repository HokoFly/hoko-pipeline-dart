import 'package:wtpipeline/src/labelable.dart';
import 'package:wtpipeline/src/pipeline_context.dart';
import 'package:wtpipeline/src/pipeline_invocation_handle.dart';

class DefaultPipelineContext implements PipelineContext, PipelineInvocationHandle {
  @override
  void addCancelable(Cancelable cancelable) {
    // TODO: implement addCancelable
  }

  @override
  void await() {
    // TODO: implement await
  }

  @override
  bool awaitTimeout(Duration timeout) {
    // TODO: implement awaitTimeout
    throw UnimplementedError();
  }

  @override
  void awaitUninterruptibly() {
    // TODO: implement awaitUninterruptibly
  }

  @override
  void breakPipeline() {
    // TODO: implement breakPipeline
  }

  @override
  void cancel() {
    // TODO: implement cancel
  }

  @override
  Map<String, Object> getAttributeMap() {
    // TODO: implement getAttributeMap
    throw UnimplementedError();
  }

  @override
  T getOuterContext<T>() {
    // TODO: implement getOuterContext
    throw UnimplementedError();
  }

  @override
  void gotoLabelAndInvoke(String label) {
    // TODO: implement gotoLabelAndInvoke
  }

  @override
  void invoke() {
    // TODO: implement invoke
  }

  @override
  void invokeNext() {
    // TODO: implement invokeNext
  }

  @override
  bool isBroken() {
    // TODO: implement isBroken
    throw UnimplementedError();
  }

  @override
  bool isCanceled() {
    // TODO: implement isCanceled
    throw UnimplementedError();
  }

  @override
  bool isFinish() {
    // TODO: implement isFinish
    throw UnimplementedError();
  }

  @override
  void removeCancelable(Cancelable cancelable) {
    // TODO: implement removeCancelable
  }

  @override
  void setOuterContext<T>(T context) {
    // TODO: implement setOuterContext
  }

}