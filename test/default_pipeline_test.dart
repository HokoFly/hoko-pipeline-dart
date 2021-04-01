import 'package:test/test.dart';
import 'package:wtpipeline/src/default_pipeline.dart';
import 'package:wtpipeline/src/pipeline.dart';
import 'package:wtpipeline/src/pipeline_invocation_handle.dart';
import 'package:wtpipeline/src/valve.dart';

import 'mock_context.dart';
import 'print1_valve.dart';
import 'print2_valve.dart';
import 'retry_valve.dart';

void main() {
  test("testNewInvocation", () {
    testNewInvocation();
  });

  test("testNewInvocationForEmptyValue", () {
    testNewInvocationForEmptyValue();
  });

  test("testNewInvocationWhenDoubleLabel", () {
    testNewInvocationWhenDoubleLabel();
  });

}

void testNewInvocation() {
  var valves = <Valve>[];
  var print1Valve = Print1Valve();
  String retryStartLabel = "print1";
  print1Valve.setLabel(retryStartLabel);
  var print2Valve = Print2Valve();
  var retryValve = RetryValve();
  retryValve.setRetryStartLabel(retryStartLabel);
  valves.add(print1Valve);
  valves.add(print2Valve);
  valves.add(retryValve);

  Pipeline pipeline = DefaultPipeline(valves, null);
  PipelineInvocationHandle pipelineContext = pipeline.newInvocation();
  MockContext mockContext = MockContext();
  pipelineContext.setOuterContext(mockContext);
  pipelineContext.invoke();

  pipelineContext.await();
  print("Done");
  expect(pipelineContext.isFinish(), equals(true));
  expect(mockContext.isLimitedRetryTime(), equals(true));
}

void testNewInvocationForEmptyValue() {
  var valves = <Valve>[];
  Pipeline pipeline = DefaultPipeline(valves, null);
  PipelineInvocationHandle pipelineContext = pipeline.newInvocation();
  MockContext mockContext = MockContext();
  pipelineContext.setOuterContext(mockContext);
  pipelineContext.invoke();

  pipelineContext.await();
  print("Done");
  expect(pipelineContext.isFinish(), equals(true));
  expect(mockContext.isLimitedRetryTime(), equals(false));
}

void testNewInvocationWhenDoubleLabel() {

}
