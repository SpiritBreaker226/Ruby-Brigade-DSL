class FancyRouter
	attr_accessor :routes

	def initialize
		self.routes = []
	end
	
	def route(&block)
		# instance_eval(&block)
		yield(self)
		self.routes
	end

	def get(path, to)
		self.routes << { http_methods: :get, path: path, to: to }
	end

	def post(path, to)
		self.routes << { http_methods: :post, path: path, to: to }	
	end

	def resources(resource)
		get("/#{resource}", "#{resource}#index")
		get("/#{resource}", "#{resource}#new")
		get("/#{resource}", "#{resource}#show")
		post("/#{resource}", "#{resource}#create")
	end
end

routes = FancyRouter.new.route do |r|
	r.get "/", "pages#home"
	r.resources :users
end

p routes