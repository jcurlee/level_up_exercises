require "CSV"
require "JSON"

class DinosaurCatalog
  ONE_TON = 2000

  attr_accessor :json_file_name
  attr_accessor :default_keys

  def default_keys
    @default_keys = %w(name period continent diet walking weight description)
  end

  def initialize(attrs = {})
    @dinosaur_catalog = []

    @json_file_name = 'dinodex.json'

    import_csv_files(attrs[:csv_files])

    parse_keys
  end

  def dinosaur_catalog_periods
    @dinosaur_catalog.map { |row| row[:period] }.uniq
  end

  def find_large
    find_by_weight('large')
  end

  def find_small
    find_by_weight('small')
  end

  def find_bipeds
    find_dinos(:walking, "biped")
  end

  def find_carnivores
    find_dinos(:diet, "carnivore")
      .concat find_dinos(:diet, "insectivore")
      .concat find_dinos(:diet, "piscivore")
  end

  def find_by_period(time_period)
    find_dinos(:period, time_period)
  end

  def export_to_json
    File.open(@json_file_name, "w") { |f| f.write JSON.dump @dinosaur_catalog }
  end

  private

  def find_by_weight(size)
    @dinosaur_catalog.select do |row|
      weight = row[:weight].to_i

      size == 'large' ? weight >= ONE_TON : weight < ONE_TON
    end
  end

  def find_dinos(key, value, catalog = nil)
    current_catalog = catalog ? catalog : @dinosaur_catalog
    current_catalog.select { |row| row[key] && row[key].downcase == value }
  end

  def import_csv_files(files)
    files.map do |file_name|
      CSV.foreach(
        file_name, headers: true, header_converters: :symbol
      ) do |row|
        @dinosaur_catalog << row.to_hash
      end
    end
  end

  def parse_keys
    @dinosaur_catalog = @dinosaur_catalog.map do |row|
      row[:name] = row[:genus] unless row[:name]
      row[:weight] = row[:weight_in_lbs] unless row[:weight]
      row[:diet] = 'Carnivore' if !row[:diet] && row[:carnivore] == 'Yes'
      row
    end
  end
end
