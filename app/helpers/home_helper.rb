module HomeHelper

  RESULTS_PATH = "./public/Results/"

  # Get the list of cities with highest altitudes for each country
  #
  # @param [String] csv file path to be processed
  #
  # @return [Array] sorted array of cities with highest altitude for each country
  #
  def self.get_list(filepath)
    data = CSV.read(filepath, col_sep: ';')

    fields = [ :id, :country, :city, :latitude, :longitude, :altitude]

    # Create hash structure of the given data
    hashed_data = data.map{ |row| fields.zip(row).to_h }

    # Group data by field 'country'
    hashed_data_by_country = hashed_data.group_by{ |row|  row[:country]}

    # Find the city with highest altitude for each country
    top_list = Array.new
    hashed_data_by_country.each do |hash_by_country|
      top_list << hash_by_country[1].max_by{|row| row[:altitude].to_i}
    end

    top_list = top_list.sort_by{ |row| row[:altitude].to_i}.reverse

    return top_list
  end

  # Print in STDOUT and into a text file the result
  #
  # @param [Array] sorted array of cities with highest altitude for each country
  #
  def self.print(top_list)
    begin
      filename = DateTime.now.to_s + ".txt"
      file = File.open(HomeHelper::RESULTS_PATH + filename, "w")
      top_list.each do |row|
        line = "#{row[:altitude].to_i}m - " + row[:city] + ", " + row[:country]
        puts "#{line}"
        file.puts line 
      end
      return file.path
    rescue IOError => ex
      puts "#{ex.backtrace}"
      return nil
    ensure
      file.close unless file.nil?
    end
  end
  
end
