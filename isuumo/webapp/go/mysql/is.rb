arr = ["ゲーミングチェア",
"座椅子",
"エルゴノミクス",
"ハンモック"]

cmd = 'sed -i '
arr.each_with_index do |v,i|
    cmd += "-e \"s/'#{v}'/'#{v}', '#{i}'/g\" "
end

cmd += ' mysql/2_DummyChairData.sql'

puts cmd

arr = [    "黒",
"白",
"赤",
"青",
"緑",
"黄",
"紫",
"ピンク",
"オレンジ",
"水色",
"ネイビー",
"ベージュ"]

cmd = 'sed -i '
arr.each_with_index do |v,i|
    cmd += "-e \"s/'#{v}'/'#{v}', '#{i}'/g\" "
end

cmd += ' mysql/2_DummyChairData.sql'
puts cmd
