import 'dart:async';
import 'dart:collection';

import 'package:wtpipeline/src/exception/no_label_found_exception.dart';
import 'package:wtpipeline/src/labelable.dart';
import 'package:wtpipeline/src/pipeline_context.dart';
import 'package:wtpipeline/src/pipeline_invocation_handle.dart';
import 'package:wtpipeline/src/valve.dart';

class DefaultPipelineContext implements PipelineContext, PipelineInvocationHandle {
  static const EMPTY_OBJECT = Object();
  dynamic _outerContext;
  final Map<Cancelable, Object> _cancelableMap = HashMap();
  final Map<String, Object> _attributes = HashMap();
  final List<Valve> _valves;
  final BasicValve _basicValve;
  final Map<String, int> _valveIndex;
  Iterator<Valve> _valveListIterator;
  Completer _completer;

  bool _broken = false;
  bool _finished = false;
  bool _canceled = false;

  bool basicValveInvoked = false;

  DefaultPipelineContext(this._valves, this._basicValve, this._valveIndex) {
    _valveListIterator = _valves.iterator;
  }

  @override
  void invokeNext() {
    if (_isFinish()) {
      return;
    }
    if (!isBroken() && _valveListIterator.moveNext()) {
      var valve = _valveListIterator.current;
      valve.invoke(this);
    } else {
      if (basicValveInvoked || _basicValve == null) {
        _finish(false);
      } else {
        _executeBasicValve();
      }
    }
  }

  void _executeBasicValve() {
    basicValveInvoked = true;
    _basicValve.invoke(this);
  }

  @override
  void addCancelable(Cancelable cancelable) {
    _cancelableMap[cancelable] = EMPTY_OBJECT;
  }

  @override
  void removeCancelable(Cancelable cancelable) {
    _cancelableMap.remove(cancelable);
  }

  @override
  void breakPipeline() {
    _broken = true;
    invokeNext();
  }

  @override
  void cancel() {
    _finish(true);
    _cancelableMap.keys.forEach((cancelable) {
      try {
        cancelable.cancel();
      } catch(ignored) {

      }
    });
    _cancelableMap.clear();
  }

  @override
  Map<String, Object> getAttributeMap() => _attributes;

  @override
  T getOuterContext<T>() => _outerContext;

  @override
  void setOuterContext<T>(T context) {
    _outerContext = context;
  }

  @override
  void gotoLabelAndInvoke(String label) {
    var idx = _valveIndex[label];
    if (idx == null) {
      throw NoLabelFoundException("Can't find this label $label");
    }
    if (idx > _valves.length) {
      throw NoLabelFoundException("Label $label is out of range $idx");
    }
    _valveListIterator = _valves.iterator;
    for (var i = 0; i < idx; i++) {
      _valveListIterator.moveNext();
    }
    invokeNext();
  }

  @override
  Future invoke() {
    _completer = Completer();
    invokeNext();
    return _completer.future;
  }


  @override
  bool isBroken() {
    return _broken;
  }

  @override
  bool isCanceled() {
    return _canceled;
  }

  @override
  bool isFinish() {
    return !_broken && !_canceled && _finished;
  }


  bool _isFinish() {
    return _finished;
  }

  void _finish(bool cancel) {
    if (cancel) {
      _canceled = true;
    }
    _finished = true;
    _completer.complete();
  }


}