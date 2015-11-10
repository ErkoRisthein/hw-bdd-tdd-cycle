require 'rails_helper'

describe MoviesHelper do
    
  describe 'oddness' do
    it 'returns odd if number is odd' do
      expect(helper.oddness(1)).to eq('odd')
    end
    
    it 'returns even if number is even' do
      expect(helper.oddness(2)).to eq('even')
    end
  end
  
end