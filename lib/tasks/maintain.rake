namespace :maintain do
  task :fix_tags => :environment do

    Listing.all.each do |l|
      new_tags = []
      if l.tag_list.join(",").include? ' '
        l.tag_list.each do |t|
          tags = t.split(' ')
          new_tags << tags
          if tags.length > 1
            tags.each do |word|
              tag = ActsAsTaggableOn::Tag.where(:name=>word).first
              if tag.present? && !l.tag_list.include?(word)
                l.tags << tag
              end
            end
            ActsAsTaggableOn::Tag.find_by_name(t).destroy
          end
        end
        l.update_attribute(:tag_list, :new_tags)
      end
    end
  end


  task :assign_listings_to_admin => :environment do
    Listing.all.each do |lis|
      if lis.user.present?
      else
        lis.update_attribute(:user_id, 1)
      end
    end
  end

  task :assign_slugs => :environment do
    Listing.all.each do |lis|
      slug = lis.title.downcase.gsub(/['&+],/,'').gsub('  ',' ').gsub(' ','-')
      lis.update_attribute(:slug, slug)
    end
    List.all.each do |lis|
      slug = lis.name.downcase.gsub(/['&+],/,'').gsub('  ',' ').gsub(' ','-')
      lis.update_attribute(:slug, slug)
    end
    Category.all.each do |lis|
      slug = lis.name.downcase.gsub(/['&+],/,'').gsub('  ',' ').gsub(' ','-')
      lis.update_attribute(:slug, slug)
    end
  end

  task :assign_places => :environment do
    Listing.all.each do |l|
      p = Place.where(:zipcode=>l.zip_code)
      if p.first.present?
        p.first.listings << l
      end
    end
  end

  task :assign_empty_places => :environment do
    Listing.where(:place_id=>nil).each do |l|
      p = Place.where(:zipcode=>l.zip_code)
      if p.first.present?
        p.first.listings << l
      else
        county = l.county
        city = l.city
        zip = l.zip_code
        new_county = County.where(:county=>county).first
        new_place = Place.where(:city=>city).first
        if new_county.present?
        else
          new_county = County.create(:county=>county)

        end
        if new_place.present?

        else
          new_place = Place.create(:city=>city, :zipcode=>zip, :county_id => new_county.id)


        end
        new_place.listings << l 
      end
    end
  end

end
