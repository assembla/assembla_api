def convert_to_constant(classes)
  constant = Object
  classes.split('::').each do |klass|
    constant = constant.const_get klass
  end
  return constant
end

def unescape(string)
  string.gsub('\n', "\n").gsub('\"', '"').gsub('\e', "\e")
end

def run_cmd(cmd)
  @cmd_output = `#{cmd}`

  if $?.exitstatus != 0
    fail("To execute command: #{cmd}")
  end
end

def data_root
  Pathname.new(File.expand_path("../../data", __FILE__))
end
