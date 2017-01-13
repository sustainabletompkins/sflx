namespace :init do
  task :seed_categories => :environment do
    Category.delete_all
    Category.create(:id => 1, :name=>'Energy & Climate', :description=>'good stuff here')
    Category.create(:id => 2, :name=>'Food System', :description=>'1')
    Category.create(:id => 3, :name=>'Built Environment', :description=>'2')
    Category.create(:id => 4, :name=>'Transportation', :description=>'3')
    Category.create(:id => 5, :name=>'Sustainable Economy', :description=>'s')
    Category.create(:id => 6, :name=>'Envirnomental Protection', :description=>'s')
    Category.create(:id => 7, :name=>'Healthy Culture', :description=>'s')
    Category.create(:id => 8, :name=>'Democracy & Justice', :description=>'s')
  end

  task :seed_lists => :environment do
    List.delete_all
    List.create(:category_id=>5, :name=>'Sharing & Trading', :description => 'share and trade')
    List.create(:category_id=>5, :name=>'Green Products & Services', :description => 'green')
    List.create(:category_id=>5, :name=>'Triple Bottom Line Operations', :description => '')
    List.create(:category_id=>5, :name=>"Workers' Rights", :description => '')
    List.create(:category_id=>5, :name=>'Local Investment', :description => '')
    List.create(:category_id=>4, :name=>'Public Transport', :description => '')
    List.create(:category_id=>4, :name=>'Biking and Walking', :description => '')
    List.create(:category_id=>4, :name=>'Electric vehicles', :description => '')
    List.create(:category_id=>4, :name=>'Shared Use', :description => '')
    List.create(:category_id=>3, :name=>'Equitable Access', :description => '')
    List.create(:category_id=>3, :name=>'Healthy Infrastructure', :description => '')
    List.create(:category_id=>3, :name=>'Green Utilities', :description => '')
    List.create(:category_id=>3, :name=>'Smart Growth', :description => '')
    List.create(:category_id=>3, :name=>'Green Buildings', :description => '')
    List.create(:category_id=>2, :name=>'Local Growers', :description => '')
    List.create(:category_id=>2, :name=>'Local Processors', :description => '')
    List.create(:category_id=>2, :name=>'Local Crafted Beverages', :description => '')
    List.create(:category_id=>2, :name=>'Locally-sourced Grocery Stores', :description => '')
    List.create(:category_id=>2, :name=>'Locally-sourced  Restaurants', :description => '')
    List.create(:category_id=>2, :name=>'Food Justice & Sovereignty', :description => '')
    List.create(:category_id=>1, :name=>'Renewables', :description => '')
    List.create(:category_id=>1, :name=>'Energy Efficiency', :description => '')
    List.create(:category_id=>1, :name=>'Adaptation/Resilience', :description => '')
    List.create(:category_id=>1, :name=>'Keep It In the Ground', :description => '')
    List.create(:category_id=>1, :name=>'Energy Democracy', :description => '')
    List.create(:category_id=>6, :name=>'Pollution Prevention', :description => '')
    List.create(:category_id=>6, :name=>'Waste Reduction', :description => '')
    List.create(:category_id=>6, :name=>'Land Conservation', :description => '')
    List.create(:category_id=>6, :name=>'Watershed Protection', :description => '')
    List.create(:category_id=>6, :name=>'Air Quality', :description => '')
    List.create(:category_id=>6, :name=>'Biodiversity', :description => '')
    List.create(:category_id=>7, :name=>'Connecting to Nature', :description => '')
    List.create(:category_id=>7, :name=>'Bridging Differences', :description => '')
    List.create(:category_id=>7, :name=>'Arts for Sustainability', :description => '')
    List.create(:category_id=>7, :name=>'Personal well being', :description => '')
    List.create(:category_id=>7, :name=>'Greening Health Care', :description => '')
    List.create(:category_id=>7, :name=>'Systems Thinking', :description => '')
    List.create(:category_id=>8, :name=>'Civic Engagement', :description => '')
    List.create(:category_id=>8, :name=>'Participatory Democracy', :description => '')
    List.create(:category_id=>8, :name=>'Human Rights', :description => '')
    List.create(:category_id=>8, :name=>'Fighting Bias', :description => '')
    List.create(:category_id=>8, :name=>'Criminal Justice Reform', :description => '')



  end

  task :seed_tags => :environment do


    #ActsAsTaggableOn::Tag.create(:name => "reuse")
    ActsAsTaggableOn::Tag.create(:name => "reduce")
    #ActsAsTaggableOn::Tag.create(:name => "solar")
    ActsAsTaggableOn::Tag.create(:name => "wind")
    ActsAsTaggableOn::Tag.create(:name => "hydro")
    ActsAsTaggableOn::Tag.create(:name => "biofuel")
    ActsAsTaggableOn::Tag.create(:name => "geothermal")

    ActsAsTaggableOn::Tag.create(:name => "low-carbon")
    ActsAsTaggableOn::Tag.create(:name => "disinvestment")
    ActsAsTaggableOn::Tag.create(:name => "distributed energy")
    ActsAsTaggableOn::Tag.create(:name => "organic")
    ActsAsTaggableOn::Tag.create(:name => "CSAs")
    ActsAsTaggableOn::Tag.create(:name => "permaculture")
    ActsAsTaggableOn::Tag.create(:name => "composting")
    ActsAsTaggableOn::Tag.create(:name => "local-beverages")
    ActsAsTaggableOn::Tag.create(:name => "community-kitchens")
    ActsAsTaggableOn::Tag.create(:name => "community-gardens")
    ActsAsTaggableOn::Tag.create(:name => "ecoindustrial-design")


    ActsAsTaggableOn::Tag.create(:name => "affordable-housing")
    ActsAsTaggableOn::Tag.create(:name => "infill-development")
    ActsAsTaggableOn::Tag.create(:name => "microgrids")



    ActsAsTaggableOn::Tag.create(:name => "habitat-preservation")
    ActsAsTaggableOn::Tag.create(:name => "invasive-species")
    ActsAsTaggableOn::Tag.create(:name => "voluntary-simplicity")
    ActsAsTaggableOn::Tag.create(:name => "hazardous-waste")
    ActsAsTaggableOn::Tag.create(:name => "ride-sharing")
    ActsAsTaggableOn::Tag.create(:name => "trails")
    ActsAsTaggableOn::Tag.create(:name => "vehicle-sharing")
    ActsAsTaggableOn::Tag.create(:name => "low-emission-vehicles")
    ActsAsTaggableOn::Tag.create(:name => "recycling")
    ActsAsTaggableOn::Tag.create(:name => "multimodal")
    ActsAsTaggableOn::Tag.create(:name => "local-currencies")
    ActsAsTaggableOn::Tag.create(:name => "biking")
    ActsAsTaggableOn::Tag.create(:name => "electric-bikes")

    ActsAsTaggableOn::Tag.create(:name => "worker-owned")
    ActsAsTaggableOn::Tag.create(:name => "cooperatives")

    ActsAsTaggableOn::Tag.create(:name => "policy")
    ActsAsTaggableOn::Tag.create(:name => "education")
    ActsAsTaggableOn::Tag.create(:name => "training")
    ActsAsTaggableOn::Tag.create(:name => "grassroots-organizing")
    ActsAsTaggableOn::Tag.create(:name => "nature-appreciation")
    ActsAsTaggableOn::Tag.create(:name => "voter-participation")
    ActsAsTaggableOn::Tag.create(:name => "healthy-lifestyle")
    ActsAsTaggableOn::Tag.create(:name => "youth-empowerment")
    ActsAsTaggableOn::Tag.create(:name => "participatory-budgeting")
    ActsAsTaggableOn::Tag.create(:name => "alternatives-to-incarceration")
    ActsAsTaggableOn::Tag.create(:name => "water-quality")
    ActsAsTaggableOn::Tag.create(:name => "air-quality")
    ActsAsTaggableOn::Tag.create(:name => "climate-change")
    ActsAsTaggableOn::Tag.create(:name => "social-justice")













  end
end