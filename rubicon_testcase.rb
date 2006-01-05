require "test/unit/testcase"

class RubiconTestCase < Test::Unit::TestCase

  MsWin32 = :gak # TODO: fix
  JRuby = :gak

  VERSION = defined?(RUBY_VERSION) ? RUBY_VERSION : VERSION
  def ruby_version
    RubiconTestCase::VERSION
  end

  def test_nathanial_talbott_is_my_archenemy
    # do nothing but appease nathanial's inability to envision
    # abstract test classes... stabity stab stab
  end
end
