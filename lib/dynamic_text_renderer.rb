module DynamicTextRenderer
  @@options = {
    :images_path => '',
    :fonts_path => '',
    :base_url => ''
  }

  def self.options
    @@options
  end

  def self.render(text, options={})
    `#{convert} -trim "label:#{text.gsub('"','\"')}" #{image_filename(text,options)}`
  end

  def self.image_filename(text, options={})
    'test.png'
  end

  def self.convert
    unless defined? @@convert
      @@convert = `which convert`.strip
      raise Exception.new('convert not found on your system; please install ImageMagick') if @@convert.include? 'not found'
    end
    @@convert
  end
end
