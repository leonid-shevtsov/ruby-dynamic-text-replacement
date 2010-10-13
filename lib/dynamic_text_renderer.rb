require 'digest/md5'
require 'active_support/core_ext'
require 'active_support/core_ext/string'

module DynamicTextRenderer
  @@options = {
    :images_path => '.',
    :fonts_path => '.',
    :base_url => '',
    :defaults => {
      :bgcolor => 'transparent',
    }
  }

  def self.options
    @@options
  end

  def self.render(text, text_options={})
    convert_options = {}
    if font = text_options.fetch(:font, nil)
      convert_options[:font] = File.join options[:fonts_path],font
    end
    if size = text_options.fetch(:size, nil)
      convert_options[:pointsize] = size
    end
    if bgcolor = text_options.fetch(:bgcolor, options[:defaults][:bgcolor])
      convert_options[:background] = bgcolor
    end
    if color = text_options.fetch(:color, nil)
      convert_options[:fill] = color
    end
    puts `#{convert} #{convert_options.map{|k,v| "-#{k} \"#{v.to_s.gsub('"','\\"')}\""}.join(' ')} "label:#{text.gsub('"','\\"')}"  #{File.join options[:images_path], image_filename(text, convert_options)}`
  end

  def self.image_filename(text, convert_options)
    filename_hash = Digest::MD5.hexdigest(text+convert_options.inspect)
    "#{text.parameterize}_#{filename_hash}.png"
  end

  def self.convert
    unless defined? @@convert
      @@convert = `which convert`.strip
      raise Exception.new('convert not found on your system; please install ImageMagick') if @@convert.include? 'not found'
    end
    @@convert
  end
end
