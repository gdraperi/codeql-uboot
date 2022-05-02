

import cpp
import semmle.code.cpp.dataflow.TaintTracking
import DataFlow::PathGraph

class NetworkByteSwap extends Expr {
    NetworkByteSwap() {
        // TODO: replace <class> and <var>
        exists(MacroInvocation mi | mi.getMacro().getName().regexpMatch("ntoh(s|l|ll)") and this= mi.getExpr()
        // TODO: <condition>
        )
    
        
        
      }
}

class Config extends TaintTracking::Configuration {
  Config() { this = "NetworkToMemFuncLength" }

  override predicate isSource(DataFlow::Node source) {
    source.asExpr() instanceof NetworkByteSwap
  }
  override predicate isSink(DataFlow::Node sink) {
    exists ( FunctionCall call | call.getTarget().getName() = "memcpy"  and sink.asExpr() = call.getArgument(2))
  }
}
from Config cfg, DataFlow::PathNode source, DataFlow::PathNode sink
where cfg.hasFlowPath(source, sink)
select sink, source, sink, "Network byte swap flows to memcpy"