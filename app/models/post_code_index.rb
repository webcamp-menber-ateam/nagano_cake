# encoding: utf-8
require 'csv'
require 'singleton'#１回だけ作成、○とセットで運用

class PostCodeIndex
  include Singleton #１回だけ作成、○とセットで
  def initialize
    # file = File.join File.dirname(__FILE__), '..', '..', 'config', 'KEN_ALL.csv'
    file = 'app/assets/csv/KEN_ALL.CSV'
    @data = {}
    # 読み込みを行単位で指定
    CSV.foreach(file, encoding: 'Shift_JIS:UTF-8') do |row|
      post_code, prefecture, city_street = row[2], row[6], row[7]
      @data[post_code] = {
        post_code: post_code,
        prefecture: prefecture,
        city_street: city_street,
      }
    end
  end

  def lookup(post_code)
    @data[clean_post_code(post_code)]
  end

  def clean_post_code(input)
    input.to_s.tr('０-９', '0-9').gsub(/[^0-9]/, '')
  end

end