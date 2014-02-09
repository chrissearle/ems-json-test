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
      event = get_named_event(@base_url, @test_event_name)
      
      event['href'].should_not be_empty
    end
    
    it 'should have name on item on event collection' do
      event = get_named_event(@base_url, @test_event_name)
      
      value = get_data(event, "name")
      value.should_not be_empty
    end
    
    it 'should have slug on item on event collection' do
      event = get_named_event(@base_url, @test_event_name)

      value = get_data(event, "slug")
      value.should_not be_empty
    end
    
    it 'should have venue on item on event collection' do
      event = get_named_event(@base_url, @test_event_name)

      value = get_data(event, "venue")
      value.should_not be_empty
    end

    it 'should have href on session collection on event collection' do
      event = get_named_event(@base_url, @test_event_name)

      link = get_link(event, "session collection")
      link.should_not be_empty
    end
    
    it 'should have href on slot collection on event collection' do
      event = get_named_event(@base_url, @test_event_name)

      link = get_link(event, "slot collection")
      link.should_not be_empty
    end
    
    it 'should have href on room collection on event collection' do
      event = get_named_event(@base_url, @test_event_name)

      link = get_link(event, "room collection")
      link.should_not be_empty
    end
    
    it 'should have href on room collection' do
      event = get_named_event(@base_url, @test_event_name)
      room_url = get_link(event, "room collection")
      collection = get_collection(room_url)
      collection['href'].should eql room_url
    end

    it 'should have href on slot collection' do
      event = get_named_event(@base_url, @test_event_name)
      room_url = get_link(event, "slot collection")
      collection = get_collection(room_url)
      collection['href'].should eql room_url
    end

    it 'should have href on session collection' do
      event = get_named_event(@base_url, @test_event_name)
      room_url = get_link(event, "session collection")
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
      @base_url = "http://localhost:1337"
      @test_event_name = "flatMap(Oslo) 2014"
    end
    
    include_context "ems tests"
  end
end
