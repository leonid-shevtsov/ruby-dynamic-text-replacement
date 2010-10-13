require 'lib/dynamic_text_renderer'

describe DynamicTextRenderer do
  it "should find convert on the system" do
    DynamicTextRenderer.convert.should =~ %r(/convert)
  end

  it "should generate a valid filename for images" do
    {
      ['hello','serif',12] => 'hello.png',
      ['Hello World','Rockwell',12] => 'hello-world.png',
    }.each do |params, filename|
      DynamicTextRenderer.image_filename(*params).should == filename
    end
  end

  it "should render files" do
    DynamicTextRenderer.render('CLIENT TESTIMONIALS', :font => 'Rockwell.ttf', :size => 24, :bgcolor => '#4BB4E3', :color => '#ffffff')
  end
end
