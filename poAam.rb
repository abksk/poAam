=begin
  Usage: ruby poAam.rb SIKS209999999.csv
  csvファイルはtwinsの成績→単位修得状況照会下部のダウンロードボタンから
=end

require "pp"
open(ARGV[0], "r") do |f|
  f.readline # 1行読み飛ばし
  all_credits = 0
  credit = Hash.new(0)
  f.each do |row|
    strs = row.split(",")
    all_credits += strs[5].slice(/\d(\.\d)?/).to_i
    credit[strs[6].slice(/[^\"]\+?/)] += strs[5].slice(/\d(\.\d)?/).to_i
  end
  puts "取得単位数: " + all_credits.to_s
  puts "内訳"
  pp credit
  puts "A, A+割合: " + (((10000 * (credit["A+"] + credit["A"])/all_credits).truncate)/100.0).to_s + "%"
end