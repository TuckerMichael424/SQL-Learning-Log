# Create a filtering function called "filter_rides()" that will take 3 parameters: 
# list of ride durations, minimum duration (int), and a max duration (int), and return a new list containing the durations 
# that are between min and max (inclusive)

def filter_rides(ride_durations, min_duration, max_duration):
    filtered_rides = []
    if ride_durations == 0:
        print({"error": "No durations in list."})

    for duration in ride_durations:
        if min_duration <= duration <= max_duration:
            filtered_rides.append(duration)
    
    return({f"The ride durations that are between the minimum and maximum": filtered_rides})

ride_durations = [1, 5, 7, 10, 6]

print(filter_rides(ride_durations, 5, 10))

print("\n")

# Function Prompt 3: 
# Write code that:
# Creates a list called casual_rides with these durations: [45, 120, 15, 300, 60, 240, 30]

# Creates a list called member_rides with these durations: [10, 15, 20, 12, 18, 22, 15]

#  Filters casual_rides to keep only rides between 30 and 120 minutes (inclusive)

#  Filters member_rides to keep only rides between 10 and 30 minutes (inclusive)

#  Calls analyze_rides_by_type() with the filtered lists

#  Prints the result

def analyze_rides_by_type(casual_rides, member_rides):
    casual_rides = [45, 120, 15, 300, 60, 240, 30]
    member_rides = [10, 15, 20, 12, 18, 22, 15]

    # Filter casual_rides to keep only rides between 30 and 120 minutes (inclusive). 
    filtered_casual_rides = filter_rides(casual_rides, 30, 120)
    
    # Filter member_rides to keep only rides between 10 and 30 minutes (inclusive).
    filtered_member_rides = filter_rides(member_rides, 10, 30)

    return (filtered_casual_rides)

print(analyze_rides_by_type)