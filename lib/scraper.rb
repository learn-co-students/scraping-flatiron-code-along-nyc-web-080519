require 'nokogiri'
require 'open-uri'

require_relative './course.rb'

class Scraper
  
  def print_courses
    self.make_courses
    Course.all.each do |course|
      if course.title && course.title != ""
        puts "Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
      end
    end
  end

  def get_page
    # understand this part
    html = open("http://learn-co-curriculum.github.io/site-for-scraping/courses")
    doc = Nokogiri::HTML(html)
  end

  def get_courses
    # we need to get the page and then use a .css selector
    # .post refers to all the posts of the classes
    # need to elaborate and study it more..
    self.get_page.css(".post")
  end

  def make_courses
    # iterate though all the courses that we get from scraping the web page
    # create a new course obj
    # get more information from the .css selector
    # and set each course info to each of the css selectors (?)
    self.get_courses.each do |post|
      course = Course.new
      course.title = post.css("h2").text
      course.schedule = post.css(".date").text
      course.description = post.css("p").text
    end
  end
  
end



