class MoviesController < ApplicationController
 

  # GET /movies
  # GET /movies.json
  def index
  end

  # GET /movies/1
  # GET /movies/1.json
  def show
  end

  # GET /movies/new
  def new
    @movie = Movie.new
  end

  # GET /movies/1/edit
  def edit
  end

  def filter
    Movie.update_all("filter_score = 0")
    if params[:actor].present?
      actor_names = params[:actor].split(',') 
      actor_names.each do |actor_name|
        actor_name = actor_name.strip
        Movie.where('cast_members LIKE ?', "%#{actor_name}%").update_all("filter_score = filter_score + 1")
      end
    end
    director_name = params[:director]
    Movie.where('director LIKE ?', "%#{director_name}%").update_all("filter_score = filter_score + 1") if director_name.present?
    if params[:language][:language_id].present?
      lang_name = Language.find(params[:language][:language_id]).name 
      Movie.where('languages LIKE ?', "%#{lang_name}%").update_all("filter_score = filter_score + 1")
    end
    if params[:company][:company_id].present?
      company_name = Company.find(params[:company][:company_id]).name
      Movie.where('company LIKE ?', "%#{company_name}%").update_all("filter_score = filter_score + 1")
    end

    if params[:genre][:genre_id].present?
      genre_name = Genre.find(params[:genre][:genre_id]).name
      Movie.where('genres LIKE ?', "%#{genre_name}%").update_all("filter_score = filter_score + 1")
    end
    @movies = Movie.where('filter_score != ?', 0).order('filter_score DESC')
    @other_movies = Movie.where('filter_score = ?', 0).first(10)
    
  end

  # POST /movies
  # POST /movies.json
  def create
    @movie = Movie.new(movie_params)

    respond_to do |format|
      if @movie.save
        format.html { redirect_to @movie, notice: 'Movie was successfully created.' }
        format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movies/1
  # PATCH/PUT /movies/1.json
  def update
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to @movie, notice: 'Movie was successfully updated.' }
        format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1
  # DELETE /movies/1.json
  def destroy
    @movie.destroy
    respond_to do |format|
      format.html { redirect_to movies_url, notice: 'Movie was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def movie_params
      params.fetch(:movie, {})
    end
end
