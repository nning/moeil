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

      begin
        Domain.reindex
        Mailbox.reindex
      rescue
        # For now do not fail, if indexed search is not possible.
        nil
      end
    end

    context 'for Domain' do
      setup do
        @substring = @domain1.name.random_substring
        @results = Search.for(@mailbox1, @substring)
      end

      context 'random substring' do
        should 'not be empty' do
          assert !@substring.empty?
        end

        should 'be included in string' do
          assert @domain1.name.include? @substring
        end
      end

      should 'be successful' do
        assert !@results.empty?
      end

      should 'contain searched domain' do
        a = @results.select { |x| x.name == @domain1.name }
        assert !a.empty?
        assert a.size == 1
      end

      should 'not contain not searched domain' do
        a = @results.select { |x| x.name == @domain2.name }
        assert a.empty?
      end
    end

    context 'for Mailbox' do
      setup do
        substring = @mailbox1.username.random_substring
        @results = Search.for(@mailbox1, substring)
      end

      should 'contain searched mailbox' do
        a = @results[@domain1]
          .select { |x| x.username == @mailbox1.username }
          .select { |x| x.is_a? Mailbox }
        assert !a.empty?
        assert a.size == 1
      end

      should 'not contain not searched mailbox' do
        a = @results[@domain1]
          .select { |x| x.username == @mailbox2.username }
          .select { |x| x.is_a? Mailbox }
        assert a.empty?
      end
    end

    context 'for Alias' do
      setup do
        substring = @alias1.username.random_substring
        @results = Search.for(@mailbox1, substring)
      end

      should 'contain searched alias' do
        a = @results[@domain1]
          .select { |x| x.username == @alias1.username }
          .select { |x| x.is_a? Alias }
        assert !a.empty?
        assert a.size == 1
      end

      should 'not contain not searched alias' do
        a = @results[@domain1]
          .select { |x| x.username == @alias2.username }
          .select { |x| x.is_a? Alias }
        assert a.empty?
      end
    end
  end
end
