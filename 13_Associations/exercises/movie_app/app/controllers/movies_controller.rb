class MoviesController < ApplicationController
  before_action :find_movie, only: [:update, :edit, :show]
  
  before_filter :authenticate_user!, only: [:edit, :create]

  def index
    @movies = Movie.all
  end

  def new
    @movie = Movie.new
  end

  def create
    safe_movie = params.require(:movie).permit(:title, :description, :year_released, :rating)
    @movie = current_user.movies.new safe_movie
    if @movie.save
      redirect_to @movie
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    safe_movie = params.require(:movie).permit(:title, :description, :year_released, :rating)
    if @movie.update(safe_movie)
      redirect_to @movie
    else
      render 'edit'
    end
  end

  def show
  end

  def search
    query = params[:q]                                                             
    @movies = Movie.search_for query 
  end

  private 

  def find_movie
    @movie = Movie.find params[:id]
  end
end
