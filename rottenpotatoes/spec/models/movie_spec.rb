require 'rails_helper'

describe Movie do
    
  it 'should return an array of all ratings' do
    expect(Movie.all_ratings).to eq(["G", "PG", "PG-13", "NC-17", "R"])
  end
  
end