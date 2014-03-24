require 'yaml'

module I18nLocales
  extend self

  def raw
    @@raw ||= YAML.load_file('data/pairs.yaml')
  end

  # country XX is %C
  # country xx is %c
  # language XX is %L
  # language xx is %l
  # % is %%
  # default is %c-%L
  class << self
    attr_accessor :format
  end
  self.format = '%c-%L'

  def all
    where
  end

  def match_country(country, find_by_country=nil)
    if find_by_country.is_a? Array
      find_by_country.map(&:downcase).include? country.downcase
    elsif find_by_country.is_a? String
      $stderr.puts "find_by_country=#{find_by_country} #{find_by_country.class}  == #{country} #{country.class}"
      find_by_country.downcase == country.downcase
    else
      true
    end
  end

  def match_language(language, find_by_language=nil)
    if find_by_language.is_a? Array
      find_by_language.map(&:upcase).include? language.upcase
    elsif find_by_language.is_a? String
      find_by_language.upcase == language.upcase
    else
      true
    end
  end

  def where(find_by_language=nil, find_by_country=nil, with_format=nil)
    raw.map { |country, languages|
      next unless match_country(country, find_by_country)
      languages.map { |language|
        next unless match_language(language, find_by_language)
        Pair.new(country, language, with_format)
      }.compact unless languages.nil?
    }.flatten.compact
  end
    
  class Pair
    attr_accessor :country, :language, :format

    def initialize(country, language, format=nil)
      @country = country
      @language = language
      @format = format || I18nLocales.format
    end

    def to_s
      format.gsub('%C',  country.upcase)
            .gsub('%L', language.upcase)
            .gsub('%c',  country.downcase)
            .gsub('%l', language.downcase)
            .gsub('%%', '%')
    end
  end
end
