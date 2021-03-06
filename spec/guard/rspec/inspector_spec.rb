require 'spec_helper'

describe Guard::RSpec::Inspector do

  describe ".clean" do

    it "should remove non-spec files" do
      subject.clean(["spec/guard/rspec_spec.rb", "bob.rb"]).should == ["spec/guard/rspec_spec.rb"]
    end

    it "should remove spec-looking but non-existing files" do
      subject.clean(["spec/guard/rspec_spec.rb", "bob_spec.rb"]).should == ["spec/guard/rspec_spec.rb"]
    end

    it "should remove spec-looking but non-existing files (2)" do
      subject.clean(["spec/guard/rspec/formatter_spec.rb"]).should == []
    end

    it "should keep spec folder path" do
      subject.clean(["spec/guard/rspec_spec.rb", "spec/models"]).should == ["spec/guard/rspec_spec.rb", "spec/models"]
    end

    it "should remove duplication" do
      subject.clean(["spec", "spec"]).should == ["spec"]
    end

    it "should remove spec folders included in other spec folders" do
      subject.clean(["spec/models", "spec"]).should == ["spec"]
    end

    it "should remove spec files included in spec folders" do
      subject.clean(["spec/guard/rspec_spec.rb", "spec"]).should == ["spec"]
    end

    it "should remove spec files included in spec folders (2)" do
      subject.clean(["spec/guard/rspec_spec.rb", "spec/guard/rspec/runner_spec.rb", "spec/guard/rspec"]).should == ["spec/guard/rspec_spec.rb", "spec/guard/rspec"]
    end

  end

end
