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
  end
end