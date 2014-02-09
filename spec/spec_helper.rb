require 'rest_client'
require 'yajl'

def get_collection(url)
  data = Yajl::Parser.parse(RestClient.get(url))
  
  data['collection']
end

def get_link(item, rel)
  item['links'].select{ |link| link['rel'] == rel}[0]['href']
end
  
def get_data(item, name)
  item['data'].select{ |data| data['name'] == name}[0]['value']
end

def get_named_item(list, name)
  list.select{ |item| get_data(item, "name") == name}[0]
end

def get_named_event(base_url, name)
  events_url = get_link(get_collection(base_url), "event collection")
  collection = get_collection(events_url)
  get_named_item(collection['items'], name)
end