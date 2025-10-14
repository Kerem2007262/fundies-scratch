use context starter2024

data MobileRecord:
    phone(title :: String, model :: String, color :: String, storage :: Number)
end

phone-1 = phone('iphone', '13 Pro', 'Purple', 64)
phone-2 = phone('iphone', '17 pro', 'Orange', 512)

phone-2.storage 
phone-1.storage 

fun compute-cost(p :: MobileRecord) -> Number:
  doc: "Computes phone cost based on storage capacity"
  base-price = 500
  price-per-gb = 2
  base-price + (p.storage * price-per-gb)
where:
  compute-cost(phone-1) is 628
  compute-cost(phone-2) is 1524
end
  
  
fun compute-cost-conditions(p :: MobileRecord) -> Number:
  doc: "Compute Phone cost based on storage, model, and color"
  base-price = if p.model == "13 pro": 
    799
  else if p.model == "14 pro": 
    999
  else if p.model == "17 pro": 
    1399
  else:699
  end
  #Storage
    storage-cost = if p.storgae <= 64:
    0
  else if p.storage <= 128:
    100
  else if p.storgage <= 256:
    200
  else if p.storgae <= 512:
    400
  else: 
    600
    end
    
  #color
  color-cost = if (p.color == "Orange") or (p.color == "purple"):
      150
    else:
      0
    end 

    
  base-price + storage-cost + color-cost
    
where:
  compute-cost-conditions(phone-1) is 799 + 0 + 0
  compute-cost-conditions(phone-2) is 1399 + 400 + 150
  end
    
data Priority:
  | low
  | medium
  | high
end

task-1-priority = low
task-2-priority = high
task-3-priority = medium

check:
  is-Priority(task-1-priority) is true
  is-low(task-1-priority) is true
  is-high(task-2-priority) is true
end

data Task:
  | task(description :: String, priority :: Priority)
  | note(description :: String)
end

task-1 = task("Study for exams", high)
task-2 = task("Watch a series", low)
task-3 = task("Go for groceries", medium)

fun describe(t :: Task) -> String:
  cases (Task) t:
    | task(d,p) => "Task: " + d 
    | note(d) => d
  end
end

describe(task-1)