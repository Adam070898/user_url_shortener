enable :sessions

get '/' do
  if session[:user_id] != nil
    redirect to("/welcome")
  end
  erb :index
end

post '/' do
  cur_user = User.authenticate(params[:email],params[:password])

  if cur_user == nil
puts "No user info"
    redirect to("/")
  else
    session[:user_id] = cur_user.id
    session[:user_name] = cur_user.full_name
    redirect to("/welcome")
  end
end

get '/welcome' do
  if session[:user_id] == nil
    redirect to("/")
  end
  session[:urls] = []
  Url.all.each do |url|
    if url.user_id == session[:user_id]
      session[:urls] << url
    end
  end
  puts session[:urls]
  erb :welcome
end

post '/welcome' do
  session[:user_id] = nil
  session[:urls] = nil
  redirect to("/")
end

get '/register' do
  erb :register
end

post '/register' do
  user = User.create(full_name: params[:name],email: params[:email],password: params[:password])
  redirect to ("/")
end

get '/goto/:short_url' do
  puts params[:short_url]

  le_url = Url.where(short_url: "#{params[:short_url]}").first
  if le_url
    le_url.clicks += 1
    le_url.save
    redirect to("#{le_url.long_url}")
  else
    session[:error_msg] = "Invalid URL"
    redirect to("/")
  end
end

get '/create' do
  erb :create
end

post "/create" do
  if session[:user_id] != nil
    cur_user = User.find(session[:user_id])
    new_url = cur_user.urls.create(long_url: params[:url],short_url: SecureRandom.hex(6),clicks: "0")
  else
    new_url = Url.create(user_id: nil, long_url: params[:url], short_url: SecureRandom.hex(6), clicks: "0")
  end
  if Url.where(long_url: params[:url]).first != nil
    @hidden = "Your new url is: #{new_url.short_url}"
  else
    @hidden = "Invalid URL"
  end
  erb :create
end
