require "yaml"

# Saves and loads games / serializes objects
# This implementation is from an old project and could do with a pass for best practices
# and improved features
module SaveManager
  def self.default_save
    "save.txt"
  end

  def self.save_message
    "Game saved, exiting program"
  end

  def self.save_game(round)
    yaml = YAML.dump(round)
    file = File.new(default_save, "w+")
    file.puts(yaml)
    file.close
    puts save_message
    exit
  end

  def self.load_save
    YAML.load(File.read(default_save))
  rescue Errno::ENOENT
    puts "No save files exist!"
    exit
  end
end
