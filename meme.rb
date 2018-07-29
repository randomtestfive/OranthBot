require 'mini_magick'

module Meme
  def self.crop_to_size(image, x, y)
    image.combine_options do |c|
      c.resize "#{x}x#{y}^"
      c.gravity 'center'
      c.extent "#{x}x#{y}"
    end
    return image
  end

  def self.save_img_url(url, id)
    MiniMagick::Image::open(url).format('png').write("memes/tmp-#{id}.png")
  end

  def self.place_at_resize(id1, id2, x, y, w, h, out_id)
    over = MiniMagick::Image::open("#{id1}")
    under = MiniMagick::Image::open("#{id2}")
    Meme.crop_to_size(over, w, h)
    result = under.composite(over) do |c|
      c.compose "Over"
      c.geometry "+#{x}+#{y}"
    end
    result.format('png').write("memes/tmp-#{out_id}.png")
    return result
  end

  def self.place_at(id1, id2, x, y, out_id)
    over = MiniMagick::Image::open("#{id1}")
    under = MiniMagick::Image::open("#{id2}")
    result = under.composite(over) do |c|
      c.compose "Over"
      c.geometry "+#{x}+#{y}"
    end
    result.format('png').write("memes/tmp-#{out_id}.png")
    return result
  end

  def self.place_from_center(id1, id2, x, y, out_id)
    over = MiniMagick::Image::open(id1)
    under = MiniMagick::Image::open(id2)
    result = under.composite(over) do |c|
      c.compose "Over"
      c.gravity "Center"
      c.geometry "+#{x}+#{y}"
    end
    result.format('png').write("memes/tmp-#{out_id}.png")
  end

  def self.place_from_center_resize(id1, id2, x, y, w, h, out_id)
    over = MiniMagick::Image::open(id1)
    under = MiniMagick::Image::open(id2)
    Meme.crop_to_size(over, w, h)
    result = under.composite(over) do |c|
      c.compose "Over"
      c.gravity "Center"
      c.geometry "+#{x}+#{y}"
    end
    result.format('png').write("memes/tmp-#{out_id}.png")
  end

  def self.draw_text(id, text, x, y, s, out_id)
    MiniMagick::Tool::Convert.new do |c|
      c.background 'none'
      c.font 'Courier'
      c.pointsize "#{s}"
      c.gravity 'center'
      c << "label:#{text}"
      c.trim
      c << '+repage'
      c << "memes/text-#{out_id}.png"
    end
    Meme.place_from_center "memes/text-#{out_id}.png", id.to_s, x, y, out_id
  end

  def self.draw_text_dim(id, text, x, y, s, d, out_id)
    MiniMagick::Tool::Convert.new do |c|
      c.background 'none'
      c.font 'Courier'
      c.pointsize "#{s}"
      c.gravity 'center'
      c.size "#{d}"
      c << "caption:#{text}"
      c.trim
      c << '+repage'
      c << "memes/text-#{out_id}.png"
    end
    Meme.place_from_center "memes/text-#{out_id}.png", id.to_s, x, y, out_id
  end

  def self.flop(in_id, out_id)
    MiniMagick::Tool::Convert.new do |c|
      c << in_id
      c.flop
      c << out_id
    end
  end

  def self.get_int(input)
    return ("%+d" % input)
  end

  def self.who_would_win(label1, image1, label2, image2)
    puts 'saving image 1 as id 0'
    Meme.save_img_url image1, 0
    puts 'saving image 2 as id 1'
    Meme.save_img_url image2, 1
    puts 'overlaying id 0 on who-would-win as id 2'
    Meme.place_at_resize "memes/tmp-0.png", "memes/who-would-win.jpg", 7, 176, 400, 320, 2
    puts 'overlaying id 1 on id 2 as id 2'
    Meme.place_at_resize "memes/tmp-1.png", "memes/tmp-2.png", 422, 176, 375, 320, 2
    puts 'drawing label 1 on id 2 as id 2'
    Meme.draw_text "memes/tmp-2.png", label1, -190, -110, 30, 2
    puts 'drawing label 2 on id 2 as id 2'
    Meme.draw_text "memes/tmp-2.png", label2, 200, -110, 30, 2
  end

  def self.you_vs_the_guy(image1, image2)
    puts 'saving image 1 as id 0'
    Meme.save_img_url image1, 0
    puts 'saving image 2 as id 1'
    Meme.save_img_url image2, 1
    puts 'overlaying id 0 on you-vs-the-guy as id 2'
    Meme.place_at_resize "memes/tmp-0.png", "memes/you-vs-the-guy.png", 0, 100, 400, 400, 2
    puts 'overlaying id 1 on id 2 as id 2'
    Meme.place_at_resize "memes/tmp-1.png", "memes/tmp-2.png", 400, 100, 400, 400, 2
  end

  def self.drake(label1, label2)
    puts 'drawing label 1 on drake as id 0'
    Meme.draw_text_dim "memes/drake.jpg", label1, 160, -190, 30, '300x365', 0
    puts 'drawing label 2 on id 0 as id 0'
    Meme.draw_text_dim "memes/tmp-0.png", label2, 160, 190, 30, '300x365', 0
  end

  def self.expanding_brain(label1, label2, label3, label4)
    puts 'drawing label 1 on expanding-brain as id 0'
    Meme.draw_text_dim "memes/expanding-brain.jpg", label1, -220, -460, 40, '360x270', 0
    puts 'drawing label 2 on id 0 as id 0'
    Meme.draw_text_dim "memes/tmp-0.png", label2, -220, -150, 40, '360x270', 0
    puts 'drawing label 3 on id 0 as id 0'
    Meme.draw_text_dim "memes/tmp-0.png", label3, -220, 140, 40, '360x220', 0
    puts 'drawing label 4 on id 0 as id 0'
    Meme.draw_text_dim "memes/tmp-0.png", label4, -220, 440, 40, '360x270', 0
  end

  def self.car_salesman(label1, image1, image2)
    puts 'drawing label 1 on car-salesman-0 as id 0'
    MiniMagick::Tool::Convert.new do |c|
      c.background 'none'
      c.font 'Courier'
      c.pointsize "50"
      c.gravity 'west'
      c.size "830x240"
      c << "caption:#{label1}"
      c.trim
      c << '+repage'
      c << "memes/text-0.png"
    end
    Meme.place_at "memes/text-0.png", "memes/car-salesman-0.png", 25, 25, 0
    puts 'saving image 1 as id 1'
    Meme.save_img_url image1, 1
    puts 'drawing image 1 on id 0 as id 0'
    Meme.place_from_center_resize "memes/tmp-1.png", "memes/tmp-0.png", -150, 100, 500, 390, 0
    puts 'drawing car-salesman-1 on id 0 as id 0'
    Meme.place_at "memes/car-salesman-1.png", "memes/tmp-0.png", 0, 0, 0
    if image2 != nil
      puts 'saving image 2 as id 1'
      Meme.save_img_url image2, 1
      puts 'drawing image 2 on id 0 as id 0'
      Meme.place_at_resize "memes/tmp-1.png", "memes/tmp-0.png", 538, 268, 120, 120, 0
    end
  end

  def self.boo(label1, image1)
    puts 'drawing label 1 on boo as id 0'
    MiniMagick::Tool::Convert.new do |c|
      c.background 'none'
      c.font 'Courier'
      c.pointsize "20"
      c.size "140x100"
      c.gravity 'SouthWest'
      c << "caption:#{label1}"
      c << "memes/text-0.png"
    end
    Meme.place_at "memes/text-0.png", "memes/boo.png", 270, 280, 0
    if image1 != nil
      puts 'saving image 1 as id 1'
      Meme.save_img_url image1, 1
      puts 'drawing image 1 on id 0 as id 0'
      Meme.place_at_resize "memes/tmp-1.png", "memes/tmp-0.png", 193, 156, 40, 40, 0
      puts 'drawing image 1 on id 0 as id 0'
      Meme.place_at_resize "memes/tmp-1.png", "memes/tmp-0.png", 449, 155, 40, 40, 0
      puts 'drawing image 1 on id 0 as id 0'
      Meme.place_at_resize "memes/tmp-1.png", "memes/tmp-0.png", 191, 413, 40, 40, 0
      puts 'flopping id 1 as id 1'
      Meme.flop 'memes/tmp-1.png', 'memes/tmp-1.png'
      puts 'drawing image 1 on id 0 as id 0'
      Meme.place_at_resize "memes/tmp-1.png", "memes/tmp-0.png", 448, 409, 40, 40, 0
    end
  end
end
