=begin
Copyright 2019 Michal Papis <mpapis@gmail.com>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
=end

# Extension of throw/catch to preserve interruption when once interrupted with
# given signal.
module Interruptible
  def self.included(base)
    base.extend ClassMethods
  end

  # class methods of Interruptible
  module ClassMethods
    # marks a method as interruptible, once one of methods marked with it is
    # interrupted, all other methods will not execute any more
    def interruptible(signal = :interrupt, method_name)
      alias_method :"uninterruptible_#{method_name}", method_name
      define_method method_name do |*params|
        interruptible(signal) do
          __send__(:"uninterruptible_#{method_name}", *params)
        end
      end
      method_name
    end
  end

  # Fancy way to say `throw`, defined for consistent naming.
  # It will throw a signal for the `interruptible` to catch.
  def interrupt(signal = :interrupt)
    throw signal
  end

  # Wraps a `catch` in a way that allows it to be persisted for all other
  # instances where the code should be interrupted.
  def interruptible(signal = :interrupt, &_block)
    flag = instance_variable_get("@interrupted_#{signal}")
    return if flag
    result = nil
    flag =
      catch(signal) do
        result = yield

        # when stopped catch returns nil, otherwise it returns the last value,
        # we are using the true to signal it executed without interruption
        true
      end
    instance_variable_set("@interrupted_#{signal}", true) unless flag
    result
  end
end
