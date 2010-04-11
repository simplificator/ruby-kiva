require '../helper'
class ImageTest < Test::Unit::TestCase
  DATA = {:template_id => 1, :id => 1234}
  context 'a new image' do
    setup do
      @image = Kiva::Image.new()
    end
    should 'have nil attributes' do
      assert !@image.id
      assert !@image.template_id
    end

    should 'raise when calling url' do
      assert_raise RuntimeError do
        @image.url
      end
    end
  end

  context 'a new image with data' do
    setup do
      @image = Kiva::Image.new(DATA)
    end

    should 'have an id' do
      assert_equal 1234, @image.id
    end

    should 'have a template_id' do
      assert_equal 1, @image.template_id
    end

    should 'generate image url for default size' do
      assert_equal 'http://www.kiva.org/img/w80h80/1234.jpg', @image.url
    end

    should 'generate image url for default w200h200' do
      assert_equal 'http://www.kiva.org/img/w200h200/1234.jpg', @image.url(:w200h200)
    end

    should 'raise on unknown size' do
      assert_raise RuntimeError do
        @image.url(:foobar)
      end
    end
  end

end