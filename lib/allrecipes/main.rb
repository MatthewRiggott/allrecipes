class Allrecipes
  $URL= "http://allrecipes.com"
  include URLHelper

  def initialize
    @agent = Mechanize.new
  end

  def all(options={})
    page = @agent.get $URL + "/recipes" + "?page=#{options[:page]}&st=#{search_sort_parameter(options[:sort_by])}"
    PageParser.new(page, options).recipes
  end

  def course(course_type, options={})
    begin
      course_url = get_course_url(course_type) + "?page=#{options[:page]}&st=#{search_sort_parameter(options[:sort_by])}"
      page = @agent.get(course_url)
      PageParser.new(page, options).recipes
    rescue Exception
      raise "Course type doesn't exist"
    end
  end

  def region(region_type, options={})
    begin
      region_url = get_region_url(region_type) + "?page=#{options[:page]}&st=#{search_sort_parameter(options[:sort_by])}"
      page = @agent.get(region_url)
      PageParser.new(page, options).recipes
    rescue Exception
      raise "Region doesn't exist"
    end
  end

  def ingredient(name, options={})
    begin
      url = $URL + "/search/?wt=#{name}&page=#{options[:page]}&sb=#{ingredient_sort_parameter(options[:sort_by])}"
      page = @agent.get(url)
      options = options.merge({type: "ingredient"})
      PageParser.new(page, options).recipes
    rescue Exception
      raise "Could not find recipes that include this ingredient"
    end
  end


end

