namespace :bootstrap do
      desc "populate database with data from tags.csv"
      task :default_tags => :environment do
        lines = File.new('db/data/tags.csv').readlines
        header = lines.shift.strip
        keys = header.split(',')
        lines.each do |line|
          params = {}
          values = line.strip.split(',')
          keys.each_with_index do |key,i|
            params[key] = values[i]
          end
          Tag.create(params)
        end
      end

      desc "populate database with data from feats.csv"
      task :default_feats => :environment do
        lines = File.new('db/data/feats.csv').readlines
        header = lines.shift.strip
        keys = header.split(',')
        lines.each do |line|
          params = {}
          values = line.strip.split(',')
          keys.each_with_index do |key,i|
            params[key] = values[i]
          end
          Feat.create(params)
        end
      end

      desc "populate database with data from taggings.csv"
      task :default_taggings => :environment do
        lines = File.new('db/data/taggings.csv').readlines
        header = lines.shift.strip
        keys = header.split(',')
        lines.each do |line|
          params = {}
          values = line.strip.split(',')
          keys.each_with_index do |key,i|
            params[key] = values[i]
          end
          Tagging.create(params)
        end
      end

      desc "Run all bootstrapping tasks"
      task :all => [:default_tags, :default_feats, :default_taggings]
    end
