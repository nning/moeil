require 'test_helper'

# Tests for lib/search.rb
class SearchTest < ActiveSupport::TestCase
  context 'Search' do
    setup do
      @domain1  = FactoryGirl.create :domain
      @mailbox1 = FactoryGirl.create :mailbox, domain: @domain1, admin: true
      @alias1   = FactoryGirl.create :alias,   domain: @domain1

      @domain2  = FactoryGirl.create :domain
      @mailbox2 = FactoryGirl.create :mailbox, domain: @domain2
      @alias2   = FactoryGirl.create :alias,   domain: @domain2

      [Alias, Domain, Mailbox].map(&:reindex)
    end

    context 'for Domain' do
      [true, false].each do |sql|
        context "(sql:#{sql})" do
          context 'random' do
            setup do
              @substring = @domain1.name.random_substring
              @results = Search.for(@mailbox1, @substring, sql: sql)
            end

            context 'substring' do
              should 'not be empty' do
                assert !@substring.empty?
              end

              should 'be included in string' do
                assert @domain1.name.include? @substring
              end
            end

            should 'not be empty' do
              assert !@results.empty?
            end

            should 'contain searched domain' do
              assert @results.keys.include? @domain1
            end
          end

          context 'static' do
            setup do
              @results = Search.for(@mailbox1, @domain1.name, sql: sql)
            end

            should 'be successful' do
              assert !@results.empty?
              assert @results.size == 1
            end

            should 'contain searched domain' do
              assert @results.keys.include? @domain1
            end

            should 'not contain not searched domain' do
              assert !(@results.keys.include? @domain2)
            end
          end
        end
      end
    end

    context 'for Mailbox' do
      [true, false].each do |sql|
        context "(sql:#{sql})" do
          context 'random' do
            setup do
              @substring = @mailbox1.username.random_substring
              @results = Search.for(@mailbox1, @substring, sql: sql)
              @results = @results.values.flatten
            end

            should 'not be empty' do
              assert !@results.empty?
            end

            should 'contain searched mailbox' do
              assert @results.include? @mailbox1
            end
          end
          
          context 'static' do
            setup do
              @results = Search.for(@mailbox1, @mailbox1.username, sql: sql)
              @results = @results.values.flatten
            end

            should 'not be empty' do
              assert !@results.empty?
              assert @results.size == 1
            end

            should 'contain searched mailbox' do
              assert @results.include? @mailbox1
            end

            should 'not contain not searched mailbox' do
              assert !(@results.include? @mailbox2)
            end
          end
        end
      end
    end

    context 'for Alias' do
      [true, false].each do |sql|
        context "(sql:#{sql})" do
          context 'random' do
            setup do
              @substring = @alias1.username.random_substring
              @results = Search.for(@mailbox1, @substring, sql: sql)
              @results = @results.values.flatten
            end

            should 'not be empty' do
              assert !@results.empty?
            end

            should 'contain searched alias' do
              assert @results.include? @alias1
            end
          end
          
          context 'static' do
            setup do
              @results = Search.for(@mailbox1, @alias1.username, sql: sql)
              @results = @results.values.flatten
            end

            should 'not be empty' do
              assert !@results.empty?
              assert @results.size == 1
            end

            should 'contain searched alias' do
              assert @results.include? @alias1
            end

            should 'not contain not searched alias' do
              assert !(@results.include? @alias2)
            end
          end
        end
      end
    end
  end

# private

# # Filter an array with select for objects class or attribute values.
# def filter(array, clazz = nil, args = {})
#   array.select! { |x| x.is_a? clazz } if clazz

#   args.each do |k, v| 
#     array.select! { |x| x.send(k) == v }
#   end

#   array
# end
end
