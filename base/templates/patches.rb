class Object
  def swizzle(method, &block)
    self.class.send(:alias_method, "old_#{method.to_s}".to_sym, method)
    self.instance_eval &block
  end
end