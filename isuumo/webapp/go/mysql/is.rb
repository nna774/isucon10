arr = ["ゲーミングチェア",
"座椅子",
"エルゴノミクス",
"ハンモック"]

cmd = 'sed -i '
arr.each_with_index do |v,i|
    cmd += "-e \"s/'#{v}'/'#{v}', #{i}/g\" "
end

puts cmd
