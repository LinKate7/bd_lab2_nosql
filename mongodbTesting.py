import random
from faker import Faker
from pymongo import MongoClient
from bson import ObjectId
from datetime import datetime

# Connect to MongoDB
client = MongoClient("mongodb://localhost:27018/")
db = client['bookstore']

# Initialize Faker for generating fake data
fake = Faker()

# Helper function to generate random ObjectIds for books
def generate_book_id():
    return ObjectId()

# Insert Mock Data into 'reviews' collection
def insert_reviews(num):
    reviews = []
    for _ in range(num):
        review = {
            "_id": ObjectId(),
            "book_id": generate_book_id(),
            "reviewer": {
                "first_name": fake.first_name(),
                "last_name": fake.last_name(),
                "email": fake.email()
            },
            "rating": random.randint(1, 5),
            "review_text": fake.text(max_nb_chars=200),
            "review_date": datetime.now(),
            "is_deleted": random.choice([True, False])
        }
        reviews.append(review)
    
    db.reviews.insert_many(reviews)
    print(f"{num} reviews inserted.")

# Insert Mock Data into 'customers' collection
def insert_customers(num):
    customers = []
    for _ in range(num):
        customer = {
            "_id": ObjectId(),
            "first_name": fake.first_name(),
            "last_name": fake.last_name(),
            "email": fake.email(),
            "phone": fake.phone_number(),
            "address": fake.address(),
            "city": fake.city(),
            "country": fake.country(),
            "orders": [
                {
                    "order_id": ObjectId(),
                    "order_date": datetime.now(),
                    "status": random.choice(["Completed", "Pending"]),
                    "total_amount": round(random.uniform(20, 100), 2),
                    "books": [
                        {
                            "title": fake.word(),
                            "price": round(random.uniform(10, 50), 2),
                            "quantity": random.randint(1, 5)
                        } for _ in range(random.randint(1, 5))
                    ]
                }
            ]
        }
        customers.append(customer)
    
    db.customers.insert_many(customers)
    print(f"{num} customers inserted.")

# Insert Mock Data into 'orders' collection
def insert_orders(num):
    orders = []
    for _ in range(num):
        order = {
            "_id": ObjectId(),
            "customer_id": generate_book_id(),  # Random customer
            "order_date": datetime.now(),
            "status": random.choice(["Completed", "Pending"]),
            "total_amount": round(random.uniform(20, 100), 2),
            "books": [
                {
                    "book_id": generate_book_id(),  # Random book
                    "title": fake.word(),
                    "price": round(random.uniform(10, 50), 2),
                    "quantity": random.randint(1, 5)
                } for _ in range(random.randint(1, 5))
            ]
        }
        orders.append(order)
    
    db.orders.insert_many(orders)
    print(f"{num} orders inserted.")

# Insert mock data into all collections
def insert_mock_data(num_reviews, num_customers, num_orders):
    insert_reviews(num_reviews)
    insert_customers(num_customers)
    insert_orders(num_orders)

# Main execution
if __name__ == "__main__":
    num_reviews = 5000  # Number of reviews to insert
    num_customers = 5000  # Number of customers to insert
    num_orders = 5000  # Number of orders to insert

    insert_mock_data(num_reviews, num_customers, num_orders)
