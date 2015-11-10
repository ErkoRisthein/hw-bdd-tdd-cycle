require 'rails_helper'

describe MoviesController do
    
  describe 'GET index' do
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
  
  describe 'POST update' do
    it 'successfully updates the director of a movie' do
      aladdin = Movie.create(:title => 'Aladdin', :director => 'Unknown')
      
      post :update, :id => aladdin.id, :movie => {:director => 'Ridley Scott'}
      
      aladdin.reload
      expect(aladdin.director).to eq('Ridley Scott')
      expect(response).to redirect_to(movie_path(aladdin))
    end
  end
  
  describe 'GET same_director' do
    it 'successfully returns a list of movies from the same director' do
      start_wars = Movie.create(:title => 'Star Wars', :director => 'George Lucas')
      thx = Movie.create(:title => 'THX-1138', :director => 'George Lucas')
      
      get :same_director, :movie_id => start_wars.id

      expect(assigns(:movies)).to match_array([start_wars, thx])
    end
    
    it 'redirects to the root path if the director is empty' do
      start_wars = Movie.create(:title => 'Star Wars')
      
      get :same_director, :movie_id => start_wars.id

      expect(response).to redirect_to(root_path)
    end
    
    it 'redirects to the root path if the director is an empty string' do
      start_wars = Movie.create(:title => 'Star Wars', :director => '')
      
      get :same_director, :movie_id => start_wars.id

      expect(response).to redirect_to(root_path)
      expect(flash[:notice]).to eq("'Star Wars' has no director info")
    end
  end
  
  describe 'POST create' do
    it 'successfully creates the movie' do
      post :create, :movie => { :title => 'Aladdin' }
      
      expect(response).to redirect_to(movies_path)
      expect(flash[:notice]).to eq("Aladdin was successfully created.")
    end
  end
  
  describe 'GET edit' do
    it 'successfully assigns the movie to edit' do
      start_wars = Movie.create(:title => 'Star Wars') 
    
      get :edit, :id => start_wars.id
      
      expect(assigns(:movie)).to eq(start_wars)
    end
  end
  
  describe 'GET show' do
    it 'successfully assigns the movie to show' do
      start_wars = Movie.create(:title => 'Star Wars') 
    
      get :show, :id => start_wars.id
      
      expect(assigns(:movie)).to eq(start_wars)
    end
  end
  
  describe 'GET destroy' do
    it 'successfully deletes the movie' do
      start_wars = Movie.create(:title => 'Star Wars') 
    
      get :destroy, :id => start_wars.id
      
      expect(response).to redirect_to(movies_path)
      expect(flash[:notice]).to eq("Movie 'Star Wars' deleted.")
      expect(Movie.all).to be_empty
    end
  end

end
