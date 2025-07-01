require_relative "parser"
require_relative "machine_context"

if __FILE__ == $0
  if ARGV.length < 1
    raise "No source file name."
  elsif ARGV.length > 1
    raise "Unnecessary arguments."
  end
  LinkedLang::MachineContext.new(LinkedLang::Parser.parse(ARGF.read)).run
end
