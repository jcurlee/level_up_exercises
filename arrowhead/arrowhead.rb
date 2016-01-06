class Arrowhead
  # This seriously belongs in a database.
  CLASSIFICATIONS = {
    far_west: {
      notched: "Archaic Side Notch",
      stemmed: "Archaic Stemmed",
      lanceolate: "Agate Basin",
      bifurcated: "Cody"
    },
    northern_plains: {
      notched: "Besant",
      stemmed: "Archaic Stemmed",
      lanceolate: "Humboldt Constricted Base",
      bifurcated: "Oxbow"
    }
  }

  def self.get_regional_shapes(region)
    raise "Unknown region, please provide a valid region." if !CLASSIFICATIONS.include? region
    CLASSIFICATIONS[region]
  end

  def self.classify(region, shape)
    shapes = self.get_regional_shapes(region)

    raise "Unknown shape value. Are you sure you know what you're talking about?" if !shapes.include? shape

    "You have a(n) '#{shapes[shape]}' arrowhead. Probably priceless."
  end
end

puts Arrowhead.classify(:northern_plains, :bifurcated)
