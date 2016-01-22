class NameFormatError < RuntimeError; end
class NameCollisionError < RuntimeError; end

class Robot
  attr_accessor :name

  def name_generator
    @name_generator ||= -> { name_builder }
  end

  def name=(name)
    @name = name ? register_name(name) : generate_name
  end

  def initialize(args = {})
    @name_generator = args[:name_generator]
    self.name = args[:name]
  end

  private_class_method

  def self.registry
    @registry ||= []
  end

  private

  def generate_name
    robot_name = name_generator.call

    register_name(robot_name)
  end

  def name_builder
    robot_name = "#{generate_char}#{generate_num_string}"

    return name_generator.call if name_exists?(robot_name)

    robot_name
  end

  def register_name(robot_name)
    raise NameCollisionError, "Robot name \"#{robot_name}\" "\
      "already exists!" if name_exists?(robot_name)

    raise NameFormatError, "Robot name \"#{robot_name}\" "\
      "is wrong format!" unless robot_name =~ /^[A-Z]{2}[0-9]{3}$/

    self.class.registry << robot_name

    robot_name
  end

  def generate_char
    ('A'..'Z').to_a.sample(2).join
  end

  def generate_num_string
    (1..3).reduce("") { |nums| nums << rand(10).to_s }
  end

  def name_exists?(robot_name)
    self.class.registry.include?(robot_name)
  end
end
