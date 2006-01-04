#
# Totally minimal (hopefully) drop-in replacement for test/unit
#

# TODO: document minimal core methods needed for this to work

at_exit do Test::Unit.autotest; end
module Test
  class Assertion < Exception; end

  class Unit
    def self.autotest
      ObjectSpace.each_object(Class) do |klass|
        next unless klass < Test::Unit::TestCase
        inst = klass.new
        pass = ffail = error = total = 0
        klass.public_instance_methods(true).each do |meth|
          next unless meth.index("test") == 0
          begin
            inst.setup
            inst.send meth.intern
            inst.teardown
            result = "."
            pass += 1
          rescue Test::Assertion => a
            result = a
            ffail += 1
          rescue Exception => e
            result = e
            error += 1
          end
          total += inst.assertions
          if Exception === result then
            puts "#{klass}.#{meth}: #{result}"
            puts result.backtrace
          end
        end
        puts "#{klass}: #{pass} passed, #{ffail} failures, #{error} errors, #{total} total assertions"
      end
    end

    class TestCase
      attr_reader :assertions
      def setup
        @assertions = 0
      end
      def teardown; end

      def assert(test, msg=nil)
        msg ||= "failed assertion (no msg given)"
        @assertions += 1
        raise Test::Assertion, msg unless test
      end

      def assert_equal(exp, act, msg=nil)
        msg ||= "Expected #{act.inspect} to be equal to #{exp.inspect}"
        assert exp == act, msg
      end

      def assert_instance_of(cls, obj, msg=nil)
        msg ||= "Expected #{obj} to be a #{cls}"
        assert cls === obj, msg
      end

      def assert_match(exp, act, msg=nil)
        msg ||= "Expected #{act.inspect} to match #{exp.inspect}"
        assert act =~ exp, msg
      end

      def assert_nil(obj, msg=nil)
        msg ||= "Expected #{obj.inspect} to be nil"
        assert obj.nil?, msg
      end

      def assert_not_same(exp, act, msg=nil)
        msg ||= "Expected #{act.inspect} to not be the same as #{exp.inspect}"
        assert ! exp.equal?(act), msg
      end

      def assert_raises(exp, msg=nil)
        msg ||= "Expected #{exp} to raise"
        begin
          yield
        rescue Exception => e
          assert exp === e, msg
          return e
        end
      end

      def assert_same(exp, act, msg=nil)
        msg ||= "Expected #{act.inspect} to be the same as #{exp.inspect}"
        assert exp.equal?(act), msg
      end
    end # class TestCase
  end # class Unit
end # module Test
