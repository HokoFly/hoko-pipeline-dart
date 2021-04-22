import 'dart:collection';

import 'package:hoko_pipeline/src/default_pipeline_context.dart';
import 'package:hoko_pipeline/src/exception/duplicate_label_exception.dart';
import 'package:hoko_pipeline/src/pipeline.dart';
import 'package:hoko_pipeline/src/pipeline_invocation_handle.dart';
import 'package:hoko_pipeline/src/valve.dart';

class DefaultPipeline implements Pipeline {

  List<Valve> _valves;
  List<Valve> get valves => _valves;
  BasicValve _basicValve;
  BasicValve get basicValve => _basicValve;
  Map<String, int> _valveIndex;


  DefaultPipeline(List<Valve> valves, this._basicValve) {
    Map<String, int> valveIndex = HashMap();
    if (valves != null && valves.isNotEmpty) {
      _valves = List.unmodifiable(valves);
      for (var i = 0; i < valves.length; i++) {
        var valve = valves[i];
        var label = valve.label();
        if (label != null && label.isNotEmpty) {
          if (valveIndex.containsKey(label)) {
            throw DuplicateLabelException("$valve has duplicate label : $label");
          }
          valveIndex[label] = i;
        }
      }
      if (_isNotBlankLabel(_basicValve)) {
        var label = _basicValve.label();
        if (valveIndex.containsKey(label)) {
          throw DuplicateLabelException("$_basicValve has duplicate label : $label");
        }
        valveIndex[label] = _valves.length;
      }
    } else {
      _valves = List.empty();
    }
    _valveIndex = Map.unmodifiable(valveIndex);
  }

  static bool _isNotBlankLabel(BasicValve basicValve) {
    if (basicValve == null) {
      return false;
    }
    var label = basicValve.label();
    return label != null && label.isNotEmpty;
  }



  @override
  PipelineInvocationHandle newInvocation() => DefaultPipelineContext(_valves, _basicValve, _valveIndex);



}