IRB.conf[:AUTO_INDENT] = true
IRB.conf[:SAVE_HISTORY] = 1000
require 'irb/completion' # Autocompletion einschalten
IRB.conf[:PROMPT_MODE] = :SIMPLE

require 'irbtools'
require 'irbtools/more'
require 'irbtools/configure'

FancyIrb.start :colorize => {
  :rocket_prompt => [:blue],
  :result_prompt => [:blue],
  :input_prompt  => nil,
  :irb_errors    => [:red],
  :stderr        => [:red, :bright],
  :stdout        => [:white],
  :input         => nil,
  :output        => true,
}

Irbtools.remove_library :paint
Irbtools.remove_library :fancy_irb
Irbtools.add_library :paint, :late => true do Wirb.load_schema :classic_paint if defined? Wirb end
Irbtools.add_library :fancy_irb, :thread => -1 do FancyIrb.start end
Irbtools.add_package :more
Irbtools.start
