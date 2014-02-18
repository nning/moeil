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
      setup do
        @substring = @domain1.name.random_substring
      end

      context 'random substring' do
        should 'not be empty' do
          assert !@substring.empty?
        end

        should 'be included in string' do
          assert @domain1.name.include? @substring
        end
      end

      [true, false].each do |sql|
        context "(sql:#{sql})" do
          setup do
            @results = Search.for(@mailbox1, @substring, sql: sql)
          end

          should 'be successful' do
            assert !@results.empty?
          end

          should 'contain searched domain' do
            a = filter(@results, nil, name: @domain1.name)
            assert !a.empty?
            assert a.size == 1
          end

          should 'not contain not searched domain' do
            a = filter(@results, nil, name: @domain2.name)
            assert a.empty?
          end
        end
      end
    end

    context 'for Mailbox' do
      setup do
        @substring = @mailbox1.username.random_substring
      end

      [true, false].each do |sql|
        context "(sql:#{sql})" do
          setup do
            @results = Search.for(@mailbox1, @substring, sql: sql)
          end

          should 'contain searched mailbox' do
            a = filter(@results[@domain1], Mailbox, username: @mailbox1.username)
            assert !a.empty?
            assert a.size == 1
          end

          should 'not contain not searched mailbox' do
            a = filter(@results[@domain1], Mailbox, username: @mailbox2.username)
            assert a.empty?
          end
        end
      end
    end

    context 'for Alias' do
      setup do
        @substring = @alias1.username.random_substring
      end

      [true, false].each do |sql|
        context "(sql:#{sql})" do
          setup do
            @results = Search.for(@mailbox1, @substring, sql: sql)
          end

          should 'contain searched alias' do
            a = filter(@results[@domain1], Alias, username: @alias1.username)
            assert !a.empty?
            assert a.size == 1
          end

          should 'not contain not searched alias' do
            a = filter(@results[@domain1], Alias, username: @alias2.username)
            assert a.empty?
          end
        end
      end
    end
  end

  private

  # Filter an array with select for objects class or attribute values.
  def filter(array, clazz = nil, args = {})
    array.select! { |x| x.is_a? clazz } if clazz

    args.each do |k, v| 
      array.select! { |x| x.send(k) == v }
    end

    array
  end
end
