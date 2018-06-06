require 'json'
require 'nokogiri'
require 'open-uri'

polls = Nokogiri::HTML(open('http://www.calculatedpolitics.com/project/2018-ontario/'))
riding_projections_table = polls.xpath('//*[@id="post-10171"]/div[2]/table[3]')
riding_data_without_header = riding_projections_table.search('tr').drop(1)
riding_projections = riding_data_without_header.each_with_object({}) do |tr, ridings|
  parties = tr.search('td')
    .map(&:text)
    .map(&:to_i)
  riding_name = parties[0]
  lib, pc, ndp, green = parties[2], parties[3], parties[4], parties[5]
  ridings[riding_name] = {
    green: green,
    lib: lib,
    ndp: ndp,
    pc: pc,
  }
end