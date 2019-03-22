# Interruptible

It's an extension of `throw`/`catch` to preserve interruption when once interrupted with given signal.

## Example

Just a crude example showing once interrupted with given signal, all methods with it will not execute.

```ruby
include 'interruptible'

class Example
  include Interruptible

  interruptible :user_quit, def test_a(stop_at) # prefix the method definition
    (1..10).to_a.each do |i|
      puts a: i
      interrupt :user_quit if i == stop_at      # interrupt the execution
      puts b: i
    end
  end

  def test_c(stop_at)
    (1..10).to_a.each do |i|
      puts c: i
      interrupt :user_quit if i == stop_at      # interrupt the execution
      puts d: i
    end
  end
  interruptible :user_quit, :test_c             # mark the method as interruptible

  def test_e(stop_at)
    interruptible :user_quit do                 # wrap code with interruptible
      (1..10).to_a.each do |i|
        puts e: i
        throw :user_quit if i == stop_at        # catch works just fine too
        puts f: i
      end
    end
  end
end

ex = Example.new
puts(test_a: ex.test_a((ARGV[0] || 2).to_i))
puts(test_c: ex.test_c((ARGV[1] || 2).to_i))
puts(test_e: ex.test_e((ARGV[2] || 2).to_i))
```

## License

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
