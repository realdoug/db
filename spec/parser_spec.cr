require "spec"
require "../src/Parser"

describe "Parser" do
  it "tokenizes a simple command" do
    result = Parser.tokenize("foo \"bar ba az zoom\"")
    result.should eq ["foo", "bar ba az zoom"]
  end

  it "tokenizes a command with many args" do
    result = Parser.tokenize("foo bar \"ba az zoom\" stuff")
    result.should eq ["foo", "bar", "ba az zoom", "stuff"]
  end
end
