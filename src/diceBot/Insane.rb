#--*-coding:utf-8-*--

class Insane < DiceBot
  
  def initialize
    super
    @sendMode = 2;
    @sortType = 3;
    @d66Type = 2;
  end
  def gameName
    'インセイン'
  end
  
  def gameType
    "Insane"
  end
  
  def prefixs
     ['ST', 'HJST', 'MTST', 'DVST', 'DT', 'BT', 'PT', 'FT', 'JT', 'BET', 'RTT', 'TVT', 'TET', 'TPT', 'TST', 'TKT', 'TMT',]
  end
  
  def getHelpMessage
    info = <<INFO_MESSAGE_TEXT
・判定
スペシャル／ファンブル／成功／失敗を判定
・各種表
シーン表　　　ST
　本当は怖い現代日本シーン表 HJST／狂騒の二〇年代シーン表 MTST
　暗黒のヴィクトリアシーン表 DVST
形容表　　　　DT
　本体表 BT／部位表 PT
感情表　　　　　　FT
職業表　　　　　　JT
バッドエンド表　　BET
ランダム特技決定表　RTT
指定特技(暴力)表　　(TVT)
指定特技(情動)表　　(TET)
指定特技(知覚)表　　(TPT)
指定特技(技術)表　　(TST)
指定特技(知識)表　　(TKT)
指定特技(怪異)表　　(TMT)
・D66ダイスあり
INFO_MESSAGE_TEXT
  end
  
  
  def changeText(string)
    string
  end
  
  
  def dice_command_xRn(string, nick_e)
    ''
  end
  
  def check_2D6(total_n, dice_n, signOfInequality, diff, dice_cnt, dice_max, n1, n_max)  # ゲーム別成功度判定(2D6)
    
    debug("total_n, dice_n, signOfInequality, diff, dice_cnt, dice_max, n1, n_max", total_n, dice_n, signOfInequality, diff, dice_cnt, dice_max, n1, n_max)
    
    return '' unless(signOfInequality == ">=")
    
    output = 
    if(dice_n <= 2)
      " ＞ ファンブル(判定失敗。山札から【狂気】を1枚獲得)"
    elsif(dice_n >= 12)
      " ＞ スペシャル(判定成功。【生命力】1点か【正気度】1点回復)"
    elsif(total_n >= diff)
      " ＞ 成功"
    else
      " ＞ 失敗"
    end
    
    return output
  end
  
  
  
  def rollDiceCommand(command)
    output = '1'
    type = ""
    total_n = ""
    
    case command
    when 'ST'
      type = 'シーン表'
      output, total_n = get_scene_table
    when 'HJST'
      type = '本当は怖い現代日本シーン表'
      output, total_n = get_horror_scene_table
    when 'MTST'
      type = '狂騒の二〇年代シーン表'
      output, total_n = get_mania_scene_table
    when 'DVST'
      type = '暗黒のヴィクトリアシーン表'
      output, total_n = get_dark_scene_table
    when 'DT'
      type = '形容表'
      output, total_n = get_description_table
    when 'BT'
      type = '本体表'
      output, total_n = get_body_table
    when 'PT'
      type = '部位表'
      output, total_n = get_parts_table
    when 'FT'
      type = '感情表'
      output, total_n = get_fortunechange_table
    when 'JT'
      type = '職業表'
      output, total_n = get_job_table
    when 'BET'
      type = 'バッドエンド表'
      output, total_n = get_badend_table
    when 'RTT'
      type = 'ランダム特技決定表'
      output, total_n = get_random_skill_table
        when 'TVT'
      type = '指定特技（暴力）表'
      output, total_n = get_violence_skill_table
    when 'TET'
      type = '指定特技（情動）表'
      output, total_n = get_emotion_skill_table
    when 'TPT'
      type = '指定特技（知覚）表'
      output, total_n = get_perception_skill_table
    when 'TST'
      type = '指定特技（技術）表'
      output, total_n = get_skill_skill_table
    when 'TKT'
      type = '指定特技（知識）表'
      output, total_n = get_knowledge_skill_table
    when 'TMT'
      type = '指定特技（怪異）表'
      output, total_n = get_mystery_skill_table
    end
    
    return "#{type}(#{total_n}) ＞ #{output}";
  end

  # シーン表
  def get_scene_table
    table = [
            '血の匂いがあたりに充満している。事件か？　事故か？　もしや、それは今も続いているのだろうか？',
            'これは……夢か？　もう終わっているはずの過去が、記憶の中から蘇ってくる。',
            '眼科に広がる町並みを見下ろしている。なぜこんな高所に……？',
            '世界の終わりのような暗黒。暗闇の中、何者かの気配が蠢く……。',
            '穏やかな時間が過ぎていく。まるであんなことがなかったかのようだ。',
            '湿った土の匂い。濃密な気配が漂う森の中。鳥や虫の声、風にそよぐ木々の音が聞こえる。',
            '人通りの少ない住宅街。見知らぬ人々の住まう家々の中からは、定かではない人声や物音が漏れてくる……',
            'にわかに空を雲が覆う。強い雨が降り出す。人々は、軒を求めて、大慌てで駆け出していく。',
            '荒れ果てた廃墟、朽ちた生活の名残。かすかに聞こえるのは風か、波の音か、耳鳴りか。',
            '人ごみ。喧騒。けたたましい店内BGMに、調子っぱずれの笑い声。騒がしい繁華街の一角だが……？',
            '明るい光りに照らされて、ほっと一息。だが光が強いほどに、影もまた濃くなる……。',
            ]
    
    return get_table_by_2d6(table)
  end


  # 本当は怖い現代日本シーン表
  def get_horror_scene_table
    table = [
        '不意に辺りが暗くなる。停電か？　闇の中から、誰かがあなたを呼ぶ声が聞こえてくる。',
        'ぴちょん。ぴちょん。ぴちょん。どこからか、水滴が落ちるような音が聞こえてくる。',
        '窓ガラスの前を通り過ぎたとき、不気味な何かが映り込む。目の錯覚……？',
        'テレビからニュースの音が聞こえてくる。何やら近所で物騒な事件があったようだが……',
        '暗い道を一人歩いている。背後から、不気味な跫音が近づいてくるような気がするのだが……。',
        '誰だろう？　ずっと視線を感じる。振り向いて見ても、そこにあるのは、いつも通りの光景なのだが……',
        '突如、携帯電話の音が鳴り響く。マナーモードにしておいたはずなのに……。一体、誰からだろう？',
        '茜さす夕暮れ。太陽は沈みかけ、空は血のように赤い。不安な気持ちが広がっていく……。',
        '美味しそうな香りが漂ってきて、急に空腹を感じる。今日は何を食べようかなぁ？',
        '甲高い鳴き声が、響き渡る。猫や子供がどこかで泣いているのか？　それとも……。',
        '寝苦しくて目を覚ます。何か悪夢を見ていたようだが……。あれ、意識はあるのに身体が動かない！',
            ]
    
    return get_table_by_2d6(table)
  end

  # 狂騒の二〇年代シーン表
  def get_mania_scene_table
    table = [
            '苔のこびりつく巨大な岩が並ぶ、皮に浮かぶ島。何を祀っているのかも分からない祭壇があり、いわく言いがたい雰囲気を漂わせる。',
            'もぐり酒場。看板もない地下の店は、街の男や酌婦たちで騒がしい。',
            '遺跡の中。誰が建てたとも知れぬ、非ユークリッド幾何学的な建築は、中を歩く者の正気を、徐々にに蝕んでいく。',
            '大学図書館。四十万冊を超える蔵書の中には、冒涜的な魔導書も含まれているという。',
            '強い風にのって、どこからか磯の香りが漂ってくる。海は遠いはずだが……。',
            '多くの人でごったがえす街角。ここならば、何者が混じっていても、気付かれることはない。',
            '深い闇の中。その向こうには、名状しがたき何者かが潜んでいそうだ。',
            '歴史ある新聞社。休むことなく発刊し続けた、百年分におよぶ新聞が保管されている。',
            '古い墓地。捻れた木々の間に、古びて墓碑銘も読めぬような墓石が並ぶ。いくつかの墓石はなぜか傾いている。',
            '河岸に建つ工場跡。ずいぶん前に空き家になったらしく、建物は崩れかけている。どうやら浮浪者の住処になっているらしい。',
            '静かな室内。なにか、不穏な気配を感じるが……あれはなんだ？　窓に、窓に！',
             ]
    
    return get_table_by_2d6(table)
  end

  # 暗黒のヴィクトリアシーン表
  def get_dark_scene_table
    table = [
             '霊媒師を中心に円卓を取り囲む人々が、降霊会を行っている。薄暗い部屋の中に怪しげなエクトプラズムが漂い始める。',
             '労働者達の集うパブ。女給たちが運ぶエールやジンを、赤ら顔の男たちが飲み干している。',
             '血の香りの漂う場所。ここで何があったのだろうか……',
             '売春宿の立ち並ぶ貧民街。軒先では娼婦たちが、客を待ち構えている。',
             '人々でごったがえす、騒がしい通り。様々な噂話が飛び交っている。東洋人を始めとした、外国人お姿も目立つ。',
             '霧深い街角。ガス灯の明かりだけが、石畳を照らしだしている。',
             '静まり返った部屋の中。ここならば、何をしても余計な詮索はされないだろう。',
             '汽笛の響く波止場。あの船は、外国へと旅立つのだろうか。',
             '書物の溢れる場所。調べ物をするにはもってこいだが。',
             '貴族や資産階級の人々が集うパーティ。上品な微笑みの下では、どんな企みが進んでいるのだろうか。',
             '静かな湖のほとり。草むらでは野生の兎が飛びはねている。',
            ]
    return get_table_by_2d6(table)
  end

  # 形容表
  def get_description_table
    table = [
             [11, '青ざめた'],
             [12, '血をしたたらせた'],
             [13, 'うろこ状の'],
             [14, '冒涜的な'],
             [15, '円筒状の'],
             [16, '無限に増殖する'],
             [22, '不規則な'],
             [23, 'ガーガー鳴く'],
             [24, '無数の'],
             [25, '毛深い'],
             [26, '色彩のない'],
             [33, '伸縮する'],
             [34, 'みだらな'],
             [35, '膨れ上がった'],
             [36, '巨大な'],
             [44, '粘液まみれの'],
             [45, '絶えず変化する'],
             [46, '蟲まみれの'],
             [55, 'キチン質の'],
             [56, '「本体表を使用する」のような'],
             [66, '虹色に輝く'],
            ]
    
    return get_table_by_d66_swap(table)
  end
  
  # 本体表
  def get_body_table
    table = [
             [11, '人間'],
             [12, '犬'],
             [13, 'ネズミ'],
             [14, '幽鬼'],
             [15, 'なめくじ'],
             [16, '蟲'],
             [22, '顔'],
             [23, '猫'],
             [24, 'ミミズ'],
             [25, '牛'],
             [26, '鳥'],
             [33, '半魚人'],
             [34, '人造人間'],
             [35, '蛇'],
             [36, '老人'],
             [44, 'アメーバ'],
             [45, '女性'],
             [46, '機械'],
             [55, 'タコ'],
             [56, '「部位表」を使用する'],
             [66, '小人'],
            ]
    
    return get_table_by_d66_swap(table)
  end
  
  
  # 部位表
  def get_parts_table
    table = [
             [11, '胴体'],
             [12, '足'],
             [13, '腕'],
             [14, '髪の毛／たてがみ'],
             [15, '口'],
             [16, '乳房'],
             [22, '顔'],
             [23, '肌'],
             [24, '瞳'],
             [25, '尾'],
             [26, '触手'],
             [33, '鼻'],
             [34, '影'],
             [35, '牙'],
             [36, '骨'],
             [44, '宝石'],
             [45, '翼'],
             [46, '脳髄'],
             [55, '舌'],
             [56, '枝や葉'],
             [66, '内臓'],
            ]
  
    return get_table_by_d66_swap(table)
  end
  
  
  # 感情表
  def get_fortunechange_table
    table = [
        '共感（プラス）／不信（マイナス）',
        '友情（プラス）／怒り（マイナス）',
        '愛情（プラス）／妬み（マイナス）',
        '忠誠（プラス）／侮蔑（マイナス）',
        '憧憬（プラス）／劣等感（マイナス）',
        '狂信（プラス）／殺意（マイナス）',
            ]
    
    return get_table_by_1d6(table)
  end

  # 職業表
  def get_job_table
    table = [
             [11, '考古学者≪情景≫≪考古学≫'],
             [12, 'ギャング≪拷問≫≪怒り≫'],
             [13, '探偵≪第六感≫≪数学≫'],
             [14, '警察≪射撃≫≪追跡≫'],
             [15, '好事家≪芸術≫≪人類学≫'],
             [16, '医師≪切断≫≪医学≫'],
             [22, '教授　知識分野から好きなものを二つ'],
             [23, '聖職者≪恥じらい≫≪愛≫'],
             [24, '心理学者　情動分野から好きなものを二つ'],
             [25, '学生　知識分野と情動分野から好きなものを一つずつ'],
             [26, '記者≪驚き≫≪メディア≫'],
             [33, '技術者≪電子機器≫≪機械≫'],
             [34, '泥棒≪物陰≫≪罠≫'],
             [35, '芸能人≪悦び≫≪芸術≫'],
             [36, '作家≪憂い≫≪教養≫'],
             [44, '冒険家≪殴打≫≪乗物≫'],
             [45, '司書≪整理≫≪メディア≫'],
             [46, '料理人≪焼却≫≪味≫'],
             [55, 'ビジネスマン≪我慢≫≪効率≫'],
             [56, '夜の蝶≪笑い≫≪官能≫'],
             [66, '用心棒　好きな暴力×2'],
            ]
    
    return get_table_by_d66_swap(table)
  end

  # バッドエンド表
  def get_badend_table
    table = [
             'あなたの周りに漆黒の闇が、異形の前肢が、無数の触手が集まってくる。彼らは、新たな仲間の誕生を祝福しているのだ。あなたは、もう怪異に怖がることはない。なぜなら、貴方自身が怪異となったからだ。以降、あなたは怪異のNPCとなって登場する。',
             lambda{return "牢獄のような、手術室のような薄暗い部屋に監禁される。そして、毎日のようにひどい拷問を受けることになった。何とか隙を見て逃げ出すことが出来たが……。#{get_random_skill_table_text_only}の特技が【恐怖心】になる。"},
             '間一髪のところを、謎の組織のエージェントに助けられる。「君は見所がある。どうだい？　我々と一緒にやってみないか」あなたは望むなら、忍者／魔法使い／ハンターとして怪異と戦うことが出来る。その場合、あなたは別のサイコロ・フェイクションのキャラクターとして生まれ変わる。',
             '病院のベッドで目を覚ます。長い間、ひどい悪夢を見ていた気がする。そのセッションの後遺症判定は、マイナス１の修正がつき、ファンブル値が１上昇する。',
             'どこかの民家で目を覚ます。素敵な人物に助けられ、手厚い介護を受けたようだ。特にペナルティはなし。',
             '「危ない！」大いなる絶望が、あなたに襲いかかってくる。1D6-1点のダメージを受ける。これによって【生命力】が0点になった場合、あなたは死亡する。ただし、あなたにプラスの【感情】を持つNPCがいた場合、そのNPCが、そのダメージを無効化してくれる。',
             '別の新たな怪事件に巻き込まれる。苦労のすえ、そちらは何とか無事解決！　特にペナルティはなし。',
             '大きな傷を負い、生死の境をさまよう。好きな特技で判定を行うこと。失敗すると死亡する。このとき、減少している【生命力】の分だけマイナスの修正がつく。',
             '目が覚めると見慣れない場所にいた。ここはどこだ？　私は誰だ？　どうやら、恐怖のあまり、記憶を失ってしまったようだ。功績点があれば、1点失う。',
             lambda{return "目を覚ますとそこはいつもの場所だった。しかし、どこか違和感を憶える。君たち以外、誰も事件のことを知らないようだ。死んだはずのあの人物も生きている。時間を旅したのか、ここは違う世界線か……？　#{get_random_skill_table_text_only}の特技が【恐怖心】になる。"},
             '振り返ると、そこには圧倒的な「それ」が待ち構えていた。無慈悲な一撃が、あなたを襲い、あなたは死亡する。',
            ]
    return get_table_by_2d6(table)
  end

  # 指定特技ランダム決定表
  def get_random_skill_table
    output = '1';
    type = 'ランダム';
    
    skillTableFull = [
      ['暴力', ['焼却', '拷問', '緊縛', '脅す', '破壊', '殴打', '切断', '刺す', '射撃', '戦争', '埋葬']],
      ['情動', ['恋', '悦び', '憂い', '恥じらい', '笑い', '我慢', '驚き', '怒り', '恨み', '哀しみ', '愛']],
      ['知覚', ['痛み', '官能', '手触り', 'におい', '味', '物音', '情景', '追跡', '芸術', '第六感', '物陰']],
      ['技術', ['分解', '電子機器', '整理', '薬品', '効率', 'メディア', 'カメラ', '乗物', '機械', '罠', '兵器']],
      ['知識', ['物理学', '数学', '化学', '生物学', '医学', '教養', '人類学', '歴史', '民俗学', '考古学', '天文学']],
      ['怪異', ['時間', '混沌', '深海', '死', '霊魂', '魔術', '暗黒', '終末', '夢', '地底', '宇宙']],
    ]
    
    skillTable, total_n = get_table_by_1d6(skillTableFull)
    tableName, skillTable = *skillTable
    skill, total_n2 = get_table_by_2d6(skillTable)
    return "「#{tableName}」≪#{skill}≫", "#{total_n},#{total_n2}"
  end

  #特技だけ抜きたい時用 あまりきれいでない
  def get_random_skill_table_text_only
    text, num = get_random_skill_table
    return text
  end
  
  # 指定特技ランダム決定(暴力)
  def get_violence_skill_table
    table = [
             '焼却',
             '拷問',
             '緊縛',
             '脅す',
             '破壊',
             '殴打',
             '切断',
             '刺す',
             '射撃',
             '戦争',
             '埋葬',
            ]
    return get_table_by_2d6(table)
  end
  
  # 指定特技ランダム決定(情動)
  def get_emotion_skill_table
    table = [
             '恋',
             '悦び',
             '憂い',
             '恥じらい',
             '笑い',
             '我慢',
             '驚き',
             '怒り',
             '恨み',
             '哀しみ',
             '愛',
            ]
    return get_table_by_2d6(table)
  end
  
  # 指定特技ランダム決定(知覚)
  def get_perception_skill_table
    table = [
             '痛み',
             '官能',
             '手触り',
             'におい',
             '味',
             '物音',
             '情景',
             '追跡',
             '芸術',
             '第六感',
             '物陰',
            ]
    return get_table_by_2d6(table)
  end
  
  # 指定特技ランダム決定(技術)
  def get_skill_skill_table
    table = [
             '分解',
             '電子機器',
             '整理',
             '薬品',
             '効率',
             'メディア',
             'カメラ',
             '乗物',
             '機械',
             '罠',
             '兵器',
            ]
    return get_table_by_2d6(table)
  end
  
  # 指定特技ランダム決定(知識)
  def get_knowledge_skill_table
    table = [
             '物理学',
             '数学',
             '化学',
             '生物学',
             '医学',
             '教養',
             '人類学',
             '歴史',
             '民俗学',
             '考古学',
             '天文学',
            ]
    return get_table_by_2d6(table)
  end
  
  # 指定特技ランダム決定(怪異)
  def get_mystery_skill_table
    table = [
             '時間',
             '混沌',
             '深海',
             '死',
             '霊魂',
             '魔術',
             '暗黒',
             '終末',
             '夢',
             '地底',
             '宇宙',
            ]
    return get_table_by_2d6(table)
  end
  
end
