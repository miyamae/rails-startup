# DEPRECATION WARNING: `#quietly` is deprecated and will be removed in the next release.
# https://github.com/rails/activerecord-session_store/issues/36
module Kernel
  def quietly_with_deprecation_silenced(&block)
    ActiveSupport::Deprecation.silence do
      quietly_without_deprecation_silenced(&block)
    end
  end
  alias_method_chain :quietly, :deprecation_silenced
end
