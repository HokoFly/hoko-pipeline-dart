import 'dart:async';

import 'package:test/test.dart';
import 'package:wtpipeline/src/default_pipeline.dart';
import 'package:wtpipeline/src/exception/duplicate_label_exception.dart';
import 'package:wtpipeline/src/pipeline.dart';
import 'package:wtpipeline/src/pipeline_invocation_handle.dart';
import 'package:wtpipeline/src/valve.dart';

import 'basic_base_valve.dart';
import 'break_valve.dart';
import 'cancel_valve.dart';
import 'goto_basic_valve.dart';
import 'goto_no_label_valve.dart';
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

  test("testNewInvocationForBreak", () {
    testNewInvocationForBreak();
  });

  test("testNewInvocationForBasic", () {
    testNewInvocationForBasic();
  });

  test("testNewInvocationForBasicHaveBreak", () {
    testNewInvocationForBasicHaveBreak();
  });
  test("testNewInvocationForGotoBasic", () {
    testNewInvocationForGotoBasic();
  });

  test("testNewInvocationForGotoNoLabel", () {
    testNewInvocationForGotoNoLabel();
  });

  test("testNewInvocationForCancel", () {
    testNewInvocationForCancel();
  });

}

void testNewInvocation() async {
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

  await pipelineContext.invoke();
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

  print("Done");
  expect(pipelineContext.isFinish(), equals(true));
  expect(mockContext.isLimitedRetryTime(), equals(false));
}

void testNewInvocationWhenDoubleLabel() {
  var valves = <Valve>[];
  String startLabel = "Print2Valve";
  var print1Valve = Print1Valve();
  print1Valve.setLabel(startLabel);
  var print2Valve = Print2Valve();
  var retryValve = RetryValve();
  retryValve.setRetryStartLabel(startLabel);
  valves.add(print1Valve);
  valves.add(print2Valve);
  valves.add(retryValve);
  expect(() => DefaultPipeline(valves, null), throwsA(TypeMatcher<DuplicateLabelException>()));
}


void testNewInvocationForBreak() async {
  var valves = <Valve>[];
  var print1Valve = Print1Valve();
  String retryStartLabel = "print1";
  print1Valve.setLabel(retryStartLabel);
  var print2Valve = Print2Valve();
  var retryValve = RetryValve();
  var breakValve = BreakValve();
  retryValve.setRetryStartLabel(retryStartLabel);
  valves.add(print1Valve);
  valves.add(print2Valve);
  valves.add(retryValve);
  valves.add(breakValve);

  Pipeline pipeline = DefaultPipeline(valves, null);
  PipelineInvocationHandle pipelineContext = pipeline.newInvocation();
  MockContext mockContext = MockContext();
  pipelineContext.setOuterContext(mockContext);
  await pipelineContext.invoke();

  print("Done");
  expect(pipelineContext.isFinish(), equals(false));
  expect(pipelineContext.isBroken(), equals(true));
  expect(mockContext.isLimitedRetryTime(), equals(true));
}

void testNewInvocationForBasic() async {
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

  Pipeline pipeline = DefaultPipeline(valves, BasicBaseValve());
  PipelineInvocationHandle pipelineContext = pipeline.newInvocation();
  MockContext mockContext = MockContext();
  pipelineContext.setOuterContext(mockContext);
  await pipelineContext.invoke();

  print("Done");
  expect(pipelineContext.isFinish(), equals(true));
  expect(mockContext.isLimitedRetryTime(), equals(true));
}

void testNewInvocationForBasicHaveBreak() async {
  var valves = <Valve>[];
  var print1Valve = Print1Valve();
  String retryStartLabel = "print1";
  print1Valve.setLabel(retryStartLabel);
  var print2Valve = Print2Valve();
  var breakValve = BreakValve();
  var retryValve = RetryValve();
  retryValve.setRetryStartLabel(retryStartLabel);
  valves.add(print1Valve);
  valves.add(print2Valve);
  valves.add(breakValve);
  valves.add(retryValve);

  Pipeline pipeline = DefaultPipeline(valves, BasicBaseValve());
  PipelineInvocationHandle pipelineContext = pipeline.newInvocation();
  MockContext mockContext = MockContext();
  pipelineContext.setOuterContext(mockContext);
  await pipelineContext.invoke();

  print("Done");
  expect(pipelineContext.isFinish(), equals(false));
  expect(pipelineContext.isBroken(), equals(true));
  expect(mockContext.isLimitedRetryTime(), equals(false));
}

void testNewInvocationForGotoBasic() async {
  var valves = <Valve>[];
  var print1Valve = Print1Valve();
  String retryStartLabel = "print1";
  print1Valve.setLabel(retryStartLabel);
  var print2Valve = Print2Valve();
  var gotoBasicValve = GotoBasicValve();
  var retryValve = RetryValve();
  retryValve.setRetryStartLabel(retryStartLabel);
  valves.add(print1Valve);
  valves.add(print2Valve);
  valves.add(gotoBasicValve);
  valves.add(retryValve);

  Pipeline pipeline = DefaultPipeline(valves, BasicBaseValve());
  PipelineInvocationHandle pipelineContext = pipeline.newInvocation();
  MockContext mockContext = MockContext();
  pipelineContext.setOuterContext(mockContext);
  await pipelineContext.invoke();

  print("Done");
  expect(pipelineContext.isFinish(), equals(true));
  expect(pipelineContext.isBroken(), equals(false));
  expect(mockContext.isLimitedRetryTime(), equals(false));
}


void testNewInvocationForGotoNoLabel() async {
  var valves = <Valve>[];
  var print1Valve = Print1Valve();
  String retryStartLabel = "print1";
  print1Valve.setLabel(retryStartLabel);
  var print2Valve = Print2Valve();
  var gotoNoLabelValve = GotoNoLabelValve();
  var retryValve = RetryValve();
  retryValve.setRetryStartLabel(retryStartLabel);
  valves.add(print1Valve);
  valves.add(print2Valve);
  valves.add(gotoNoLabelValve);
  valves.add(retryValve);

  Pipeline pipeline = DefaultPipeline(valves, BasicBaseValve());
  PipelineInvocationHandle pipelineContext = pipeline.newInvocation();
  MockContext mockContext = MockContext();
  pipelineContext.setOuterContext(mockContext);
  await pipelineContext.invoke();

  print("Done");
  expect(pipelineContext.isFinish(), equals(true));
  expect(pipelineContext.isBroken(), equals(false));
  expect(mockContext.isLimitedRetryTime(), equals(true));
}

void testNewInvocationForCancel() async {
  var valves = <Valve>[];
  var print1Valve = Print1Valve();
  String retryStartLabel = "print1";
  print1Valve.setLabel(retryStartLabel);
  var print2Valve = Print2Valve();
  var cancelValve = CancelValve();
  var gotoNoLabelValve = GotoNoLabelValve();
  var retryValve = RetryValve();
  retryValve.setRetryStartLabel(retryStartLabel);
  valves.add(print1Valve);
  valves.add(cancelValve);
  valves.add(print2Valve);
  valves.add(gotoNoLabelValve);
  valves.add(retryValve);

  Pipeline pipeline = DefaultPipeline(valves, BasicBaseValve());
  PipelineInvocationHandle pipelineContext = pipeline.newInvocation();
  MockContext mockContext = MockContext();
  pipelineContext.setOuterContext(mockContext);
  Future.delayed(Duration(seconds: 1), () => {
    pipelineContext.cancel()
  });
  await pipelineContext.invoke();;
  print("Done");
  expect(pipelineContext.isCanceled(), equals(true));
  expect(pipelineContext.isFinish(), equals(false));
  expect(pipelineContext.isBroken(), equals(false));
  expect(mockContext.isLimitedRetryTime(), equals(false));
}
