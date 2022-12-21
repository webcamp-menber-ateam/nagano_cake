# encoding: utf-8
require 'csv'
require 'singleton'#１回だけ作成、○とセットで運用

class PostCodeIndex
  include Singleton #１回だけ作成、○とセットで運用
  def initialize
    file = 'app/assets/csv/KEN_ALL.CSV'
    @data = {}
    # 読み込みを行単位で指定
    CSV.foreach(file, encoding: 'Shift_JIS:UTF-8') do |row|
      post_code, prefecture, city, street = row[2], row[6], row[7], row[8]
      @data[post_code] = {
        post_code: post_code,
        prefecture: prefecture,
        city: city,
        street: clean_street(street)
      }
    end
  end

  def lookup(post_code)
    @data[clean_post_code(post_code)]
  end

  def clean_post_code(input)
    input.to_s.tr('０-９', '0-9').gsub(/[^0-9]/, '')
  end

  private
  def clean_street(input)
    return '' if input == '以下に掲載がない場合'
    # .直前の一文字,*０回以上繰り返す,$ 行末
    input.sub(/（.*$/, '')
  end

end