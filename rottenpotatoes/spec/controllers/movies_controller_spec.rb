require 'rails_helper'

describe MoviesController do
    
  describe 'GET index' do
 #   it 'assigns @teams' do
 #     team = Team.create
 #     get :index
 #     expect(assigns(:teams)).to eq([team])
 #   end
 
    it 'responds successfully with an HTTP 200 status code' do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end
    
    it 'loads all movies into @movies' do
      aladdin = Movie.create(:title => 'Aladdin', :rating => 'G', :release_date => '25-Nov-1992', :director => 'Ridley Scott')
      terminator = Movie.create(:title => 'The Terminator', :rating => 'R', :release_date => '26-Oct-1984', :director => 'James Cameron')
      get :index
      expect(assigns(:movies)).to match_array([aladdin, terminator])
    end
  end

end
