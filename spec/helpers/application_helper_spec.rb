require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the ApplicationHelper. For example:
#
# describe ApplicationHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe ApplicationHelper, type: :helper do
  #include ApplicationHelper

  describe 'style_attribute' do
    it 'returns the attribute if there is a value' do
      expect(helper.style_attribute('top', '10px')).to eq('top:10px;')
    end

    it 'returns nil if there is no value' do
      expect(helper.style_attribute('top', '10px')).to eq('top:10px;')
    end

    it 'returns integer value' do
      expect(helper.style_attribute('top', 10)).to eq('top:10;')
    end

    it 'returns symbol name' do
      expect(helper.style_attribute(:top, 10)).to eq('top:10;')
    end
  end

  describe 'style_position' do
    it 'returns only provided attribute values' do
      expect(helper.style_position(Position.new(top: '10px', left: '20px'))).to eq('left:20px;top:10px;')
    end
    it 'returns all attribute values' do
      expect(helper.style_position(Position.new(top: '10px', left: '20px', right: '30px', bottom: '40px', width: '50px', height: '60px')))
          .to eq('left:20px;top:10px;right:30px;bottom:40px;width:50px;height:60px;')
    end
  end

end
