class TimingFunction
  class << self
    def timing_functions
      @_timing_functions ||= {
        linear: CAMediaTimingFunction.functionWithName(KCAMediaTimingFunctionLinear),
        ease_in: CAMediaTimingFunction.functionWithName(KCAMediaTimingFunctionEaseIn),
        ease_out: CAMediaTimingFunction.functionWithName(KCAMediaTimingFunctionEaseOut),
        ease_in_ease_out: CAMediaTimingFunction.functionWithName(KCAMediaTimingFunctionEaseInEaseOut),
        default: CAMediaTimingFunction.functionWithName(KCAMediaTimingFunctionDefault) }
    end

    # Use this app to create custom timing functions: https://github.com/simonwhitaker/tween-o-matic
    def get(key_or_constant = nil)
      if key_or_constant
        if key_or_constant.is_a?(Symbol)
          timing_functions[key_or_constant] || timing_functions[:default]
        else
          CAMediaTimingFunction.functionWithName(key_or_constant)
        end
      else
        timing_functions[:default]
      end
    end
  end
end
