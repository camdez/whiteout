require "whiteout"

describe Whiteout do
  it "cleans trailing spaces" do
    Whiteout.clean("foo    \n").should eql("foo\n")
  end

  it "cleans trailing tabs" do
    Whiteout.clean("bar\t\t\n").should eql("bar\n")
  end

  it "leaves non-trailing whitespace intact" do
    baz = "\t\tbaz  baz\n"
    Whiteout.clean(baz).should eql(baz)
  end

  it "leaves consecutive newlines intact" do
    baz = "foo\n\nbar\b"
    Whiteout.clean(baz).should eql(baz)
  end

  it "can handle a more complex case" do
    input  = "int foo() \t\n{\n    // Returns 42   \n\treturn 42;\n} \n"
    output = "int foo()\n{\n    // Returns 42\n\treturn 42;\n}\n"
    Whiteout.clean(input).should eql(output)
  end
end
