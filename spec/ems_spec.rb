# encoding: utf-8

require 'spec_helper'

URL_REGEX = /https?:\/\/.*/

describe 'EMS' do
  shared_context 'ems tests' do
    it 'should have href on root' do
      collection = get_collection(@base_url)

      collection['href'].should eql @base_url
    end

    it 'should have event collection on root' do
      collection = get_collection(@base_url)

      events_url = get_link(collection, 'event collection')
      events_url.should_not be_empty
    end

    it 'should have href on event collection' do
      events_url = get_link(get_collection(@base_url), 'event collection')

      collection = get_collection(events_url)
      collection['href'].should eql events_url
    end

    it 'should have href on item on event collection' do
      event = get_named_event(@base_url, @test_event_name)

      event['href'].should match(URL_REGEX)
    end

    it 'should have name on item on event collection' do
      event = get_named_event(@base_url, @test_event_name)

      value = get_data(event, 'name')
      value.should_not be_empty
    end

    it 'should have slug on item on event collection' do
      event = get_named_event(@base_url, @test_event_name)

      value = get_data(event, 'slug')
      value.should_not be_empty
    end

    it 'should have venue on item on event collection' do
      event = get_named_event(@base_url, @test_event_name)

      value = get_data(event, 'venue')
      value.should_not be_empty
    end

    it 'should have href on session collection on event collection' do
      event = get_named_event(@base_url, @test_event_name)

      link = get_link(event, 'session collection')
      link.should match(URL_REGEX)
    end

    it 'should have href on slot collection on event collection' do
      event = get_named_event(@base_url, @test_event_name)

      link = get_link(event, 'slot collection')
      link.should match(URL_REGEX)
    end

    it 'should have href on room collection on event collection' do
      event = get_named_event(@base_url, @test_event_name)

      link = get_link(event, 'room collection')
      link.should match(URL_REGEX)
    end

    it 'should have href on room collection' do
      event = get_named_event(@base_url, @test_event_name)
      collection_url = get_link(event, 'room collection')
      collection = get_collection(collection_url)
      collection['href'].should eql collection_url
    end

    it 'should have name on rooms if present' do
      event = get_named_event(@base_url, @test_event_name)
      collection_url = get_link(event, 'room collection')
      collection = get_collection(collection_url)
      if collection.has_key?('items') && collection['items'].length > 0
        value = get_data(collection['items'].first, 'name')
        value.should_not be_empty
      end
    end

    it 'should have href on slot collection' do
      event = get_named_event(@base_url, @test_event_name)
      collection_url = get_link(event, 'slot collection')
      collection = get_collection(collection_url)
      collection['href'].should eql collection_url
    end

    it 'should have times on slots if present' do
      event = get_named_event(@base_url, @test_event_name)
      collection_url = get_link(event, 'slot collection')
      collection = get_collection(collection_url)
      if collection.has_key?('items') && collection['items'].length > 0
        value_s = get_data(collection['items'].first, 'start')
        value_s.should_not be_empty
        value_e = get_data(collection['items'].first, 'end')
        value_e.should_not be_empty
      end
    end

    it 'should have href on session collection' do
      event = get_named_event(@base_url, @test_event_name)
      collection_url = get_link(event, 'session collection')
      collection = get_collection(collection_url)
      collection['href'].should eql collection_url
    end

    %w(format body state audience slug title lang summary level).each do |field|
      it "should have #{field} on session if present" do
        event = get_named_event(@base_url, @test_event_name)
        collection_url = get_link(event, 'session collection')
        collection = get_collection(collection_url)
        if collection.has_key?('items') && collection['items'].length > 0
          value = get_data(collection['items'].first, field)
          value.should_not be_empty
        end
      end
    end

    it 'should have keywords on session if present' do
      event = get_named_event(@base_url, @test_event_name)
      collection_url = get_link(event, 'session collection')
      collection = get_collection(collection_url)
      if collection.has_key?('items') && collection['items'].length > 0
        value = get_data_field(collection['items'].first, 'keywords', 'array')
        value.should be_an_instance_of Array
      end
    end

    ['speaker collection', 'room item', 'slot item', 'speaker item'].each do |field|
      it "should have a link for #{field} on session" do
        event = get_named_event(@base_url, @test_event_name)
        collection_url = get_link(event, 'session collection')
        collection = get_collection(collection_url)
        if collection.has_key?('items') && collection['items'].length > 0
          link = get_link(collection['items'].first, field)
          link.should match(URL_REGEX)
        end
      end
    end

    it 'should have href on speaker collection' do
      event = get_named_event(@base_url, @test_event_name)
      session = get_collection(get_link(event, 'session collection'))
      if session.has_key?('items') && session['items'].length > 0
        collection_url = get_link(session['items'].first, 'speaker collection')
        collection = get_collection(collection_url)
        collection['href'].should eql collection_url
      end
    end

    %w(name bio).each do |field|
      it "should have #{field} on speaker on speaker collection" do
        event = get_named_event(@base_url, @test_event_name)
        session = get_collection(get_link(event, 'session collection'))
        if session.has_key?('items') && session['items'].length > 0
          collection_url = get_link(session['items'].first, 'speaker collection')
          collection = get_collection(collection_url)
          if collection.has_key?('items') && collection['items'].length > 0
            value = get_data(collection['items'].first, field)
            value.should_not be_empty
          end
        end
      end
    end

    it 'should have photo on speaker on speaker collection' do
      event = get_named_event(@base_url, @test_event_name)
      session = get_collection(get_link(event, 'session collection'))
      if session.has_key?('items') && session['items'].length > 0
        collection_url = get_link(session['items'].first, 'speaker collection')
        collection = get_collection(collection_url)
        if collection.has_key?('items') && collection['items'].length > 0
          value = get_link(collection['items'].first, 'attach-photo')
          value.should match(URL_REGEX)
        end
      end
    end
  end

  describe 'JavaZone' do
    before do
      @base_url = 'http://javazone.no/ems/server'
      @test_event_name = 'JavaZone 2013'
    end

    include_context 'ems tests'
  end

  describe 'flatMap' do
    before do
      @base_url = 'http://localhost:1337'
      @test_event_name = 'flatMap(Oslo) 2014'
    end

    include_context 'ems tests'
  end
end
