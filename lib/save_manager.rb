require "yaml"

# Saves and loads games / serializes objects
# This implementation is from an old project and could do with a pass for best practices
module SaveManager
  def default_save
    "save.txt"
  end

  def save_message
    "Game saved, exiting program"
  end

  def save_game(round)
    yaml = YAML.dump(round)
    file = File.new(default_save, 'w+')
    file.puts(yaml)
    file.close
    puts save_message
    exit
  end

  def load_save
    YAML.load(File.read(default_save))
  end
end
