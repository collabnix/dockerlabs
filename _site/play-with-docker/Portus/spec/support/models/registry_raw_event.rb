class RegistryRawEvent
  attr_accessor :action, :target, :request, :actor

  def to_test_hash
    {
      "action"  => action,
      "target"  => target,
      "request" => request,
      "actor"   => actor
    }.deep_dup
  end
end
