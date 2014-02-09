# encoding: utf-8
 
require 'spec_helper'

describe 'EMS' do
  shared_context "ems tests" do
    it 'should have href on root' do
      collection = get_collection(@base_url)
      collection['href'].should eql @base_url
    end
  
    it 'should have event collection on root' do
      collection = get_collection(@base_url)
      events_url = get_link(collection, "event collection")
      events_url.should_not be_empty
    end
  
    it 'should have href on event collection' do
      events_url = get_link(get_collection(@base_url), "event collection")
      collection = get_collection(events_url)
      collection['href'].should eql events_url
    end

    it 'should have href on item on event collection' do
      events_url = get_link(get_collection(@base_url), "event collection")
      collection = get_collection(events_url)
      latest_item = get_named_item(collection['items'], @test_event_name)
      latest_item = collection['items'].last
      latest_item['href'].should_not be_empty
    end
    
    it 'should have name on item on event collection' do
      events_url = get_link(get_collection(@base_url), "event collection")
      collection = get_collection(events_url)
      latest_item = get_named_item(collection['items'], @test_event_name)
      value = get_data(latest_item, "name")
      value.should_not be_empty
    end
    
    it 'should have slug on item on event collection' do
      events_url = get_link(get_collection(@base_url), "event collection")
      collection = get_collection(events_url)
      latest_item = get_named_item(collection['items'], @test_event_name)
      value = get_data(latest_item, "slug")
      value.should_not be_empty
    end
    
    it 'should have venue on item on event collection' do
      events_url = get_link(get_collection(@base_url), "event collection")
      collection = get_collection(events_url)
      latest_item = get_named_item(collection['items'], @test_event_name)
      value = get_data(latest_item, "venue")
      value.should_not be_empty
    end

    it 'should have href on session collection on event collection' do
      events_url = get_link(get_collection(@base_url), "event collection")
      collection = get_collection(events_url)
      latest_item = get_named_item(collection['items'], @test_event_name)
      link = get_link(latest_item, "session collection")
      link.should_not be_empty
    end
    
    it 'should have href on slot collection on event collection' do
      events_url = get_link(get_collection(@base_url), "event collection")
      collection = get_collection(events_url)
      latest_item = get_named_item(collection['items'], @test_event_name)
      link = get_link(latest_item, "slot collection")
      link.should_not be_empty
    end
    
    it 'should have href on room collection on event collection' do
      events_url = get_link(get_collection(@base_url), "event collection")
      collection = get_collection(events_url)
      latest_item = get_named_item(collection['items'], @test_event_name)
      link = get_link(latest_item, "room collection")
      link.should_not be_empty
    end
    
    it 'should have href on room collection' do
      events_url = get_link(get_collection(@base_url), "event collection")
      events = get_collection(events_url)
      latest_item = get_named_item(events['items'], @test_event_name)
      room_url = get_link(latest_item, "room collection")
      collection = get_collection(room_url)
      collection['href'].should eql room_url
    end
  end

  describe "JavaZone" do
    before do
      @base_url = "http://javazone.no/ems/server"
      @test_event_name = "JavaZone 2013"
    end
    
    include_context "ems tests"
  end

  describe "flatMap" do
    before do
      @base_url = "http://lannister.hamnis.org:1337"
      @test_event_name = "flatMap(Oslo) 2014"
    end
    
    include_context "ems tests"
  end
end
