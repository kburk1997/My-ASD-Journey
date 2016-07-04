class PagesController < ApplicationController
	def index
		@simulations=Simulation.all
	end
end
