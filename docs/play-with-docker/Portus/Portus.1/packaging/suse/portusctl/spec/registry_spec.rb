require_relative "spec_helper"

class Klass
  include Portusctl::Registry

  def registry_local_test?
    registry_local?
  end

  def registry_safe_install_test!
    registry_safe_install!
  end

  def user_confirm?
    val = ENV["TEST_CONFIRM"]
    val == "y" || val == "yes"
  end

  def installed_error?
    ZYPPER_NOT_INSTALLED == ENV["TEST_EXIT_STATUS"].to_i
  end
end

class Runner
  def self.safe_exec_test(_cmd, _args = [])
    ENV["TEST_EXIT_STATUS"].nil?
  end
end

describe Portusctl::Registry do
  let(:klass) { Klass.new }

  before :each do
    ENV["TEST_CONFIRM"] = nil
    ENV["TEST_EXIT_STATUS"] = nil
    ENV["PORTUSCTL_FORCE"] = nil

    allow(Runner).to receive(:safe_exec) { Runner.safe_exec_test("zypper") }
  end

  context "PORTUSCTL_FORCE has been set" do
    it "returns true if the package already exists" do
      ENV["PORTUSCTL_FORCE"] = "t"
      expect(klass.registry_local_test?).to be_truthy
    end

    it "installs the RPM" do
      ENV["PORTUSCTL_FORCE"] = "t"
      expect(klass.registry_safe_install_test!).to be_truthy

      ENV["TEST_EXIT_STATUS"] = "1"
      expect(klass.registry_safe_install_test!).to be_falsey
    end
  end

  context "Manual execution" do
    it "returns true if the package exists and the user wants to overwrite the config" do

      ENV["TEST_CONFIRM"] = "y"
      expect(klass.registry_local_test?).to be_truthy

      ENV["TEST_CONFIRM"] = "n"
      expect(klass.registry_local_test?).to be_falsey
    end

    it "returns false if `zypper se` failed for an unknown reason" do
      ENV["TEST_EXIT_STATUS"] = "1"

      expect(klass.registry_local_test?).to be_falsey
    end

    it "calls `registry_safe_install!` if the package has not been installed" do
      ENV["TEST_EXIT_STATUS"] = "104"
      allow_any_instance_of(Klass).to receive(:registry_safe_install!).and_return(true)

      expect(klass.registry_local_test?).to be_truthy
    end

    it "installs the rpm if confirmation was given" do
      # The user gives confirmation
      ENV["TEST_CONFIRM"] = "y"

      # The command succeeds
      ENV["TEST_EXIT_STATUS"] = nil
      expect(klass.registry_safe_install_test!).to be_truthy

      # The command fails
      ENV["TEST_EXIT_STATUS"] = "1"
      expect(klass.registry_safe_install_test!).to be_falsey

      # No confirmation: should fail
      ENV["TEST_CONFIRM"] = "n"
      ENV["TEST_EXIT_STATUS"] = nil
      expect(klass.registry_safe_install_test!).to be_falsey
    end
  end
end
