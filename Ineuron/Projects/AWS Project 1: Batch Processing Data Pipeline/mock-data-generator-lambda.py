import json
import random

name_list = ['Shashank', 'Amit', 'Nitin', 'Manish', 'Nikhil', 'Kunal', 'Vishal']
age_list = [29,34,21,23,27,22,20]
salary_list = [1000,2000,3000,4000,5000,6000,7000]

def lambda_handler(event, context):
    # TODO implement
    index = random.randint(0,6)
    payload = {}
    payload['emp_name'] = name_list[index]
    payload['emp_age'] = age_list[index]
    payload['emp_sal'] = salary_list[index]
    
    return payload
